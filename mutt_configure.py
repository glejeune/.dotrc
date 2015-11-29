#!/usr/bin/env python

import ConfigParser
import os
import sys
import string
import shutil


def which(program):
    def is_exe(fpath):
        return os.path.isfile(fpath) and os.access(fpath, os.X_OK)

    fpath, fname = os.path.split(program)
    if fpath:
        if is_exe(program):
            return program
    else:
        for path in os.environ["PATH"].split(os.pathsep):
            path = path.strip('"')
            exe_file = os.path.join(path, program)
            if is_exe(exe_file):
                return exe_file
    return None


class MuttConfiguration:

    def __init__(self):
        self.home = os.path.expanduser("~")
        self.local_path = os.path.dirname(os.path.realpath(__file__))
        self.dot_mutt = os.path.join(self.home, ".mutt")
        self.dot_mutt_accounts = os.path.join(self.dot_mutt, "accounts")
        self.dot_mutt_signatures = os.path.join(self.dot_mutt, "signatures")
        self.maildir = os.path.join(self.home, "Mail")
        self.msmtprc = os.path.join(self.home, ".msmtprc")
        self.offlineimaprc = os.path.join(self.home, ".offlineimaprc")
        self.muttrc_accounts = os.path.join(self.home, ".muttrc.accounts")

        self.offlineimap = which("offlineimap")
        if not self.offlineimap:
            print("Can't find offlineimap")
            self.offlineimap = raw_input("Path to offlineimap : ")

        self.msmtp = which("msmtp")
        if not self.msmtp:
            print("Can't find msmtp")
            self.msmtp = raw_input("Path to msmtp : ")

        print(" > will use %s" % (self.offlineimap))
        print(" > will use %s" % (self.msmtp))

    def install_muttrc(self):
        src_muttrc = os.path.join(self.local_path, "_muttrc")
        dst_muttrc = os.path.join(self.home, ".muttrc")
        if not os.path.exists(dst_muttrc):
            print(" > create .muttrc link")
            os.symlink(src_muttrc, dst_muttrc)
        else:
            print(" ! .muttrc already exist")
            answer = raw_input(' * Replace it (N) ? ')
            if answer in ["Y", "y", "O", "o", "yes", "oui"]:
                print(" > Remove %s" % (dst_muttrc))
                os.remove(dst_muttrc)
                self.install_muttrc()

    def create_mutt_directories(self):
        self.__create_dir_if_not_exist(self.dot_mutt)
        self.__create_dir_if_not_exist(self.dot_mutt_accounts)
        self.__create_dir_if_not_exist(self.dot_mutt_signatures)
        self.__create_dir_if_not_exist(self.maildir)

    def add_mutt_files(self):
        dst_icalview_rb = os.path.join(self.dot_mutt, "icalview.rb")
        src_icalview_rb = os.path.join(self.local_path, "icalview.rb")
        self.__add_link(src_icalview_rb, dst_icalview_rb)
        dst_view_attachment_sh = os.path.join(self.dot_mutt, "view_attachment.sh")
        src_view_attachment_sh = os.path.join(self.local_path, "view_attachment.sh")
        self.__add_link(src_view_attachment_sh, dst_view_attachment_sh)
        dst_mailcap = os.path.join(self.dot_mutt, "mailcap")
        src_mailcap = os.path.join(self.local_path, "mailcap")
        self.__copy_file(src_mailcap, dst_mailcap)

    def add_account(self):
        print(" > Account general informations")
        self.email = raw_input(" * Your email address : ")
        if self.__check_account():
            print(" ! Account %s already exist. Abort!" % (self.email))
            sys.exit(1)
        self.domain = string.split(self.email, "@")[1]
        self.__get_general_infos()
        self.__get_imap_infos()
        self.__get_smtp_infos()
        self.__write_account_file()
        self.__write_msmtprc()
        self.__write_muttrc_accounts()
        self.__write_offlineimaprc()

    def __get_general_infos(self):
        self.realname = raw_input(" * Your real name : ")
        self.spoolfile = raw_input(" * spoolfile (INBOX) : ")
        if not self.spoolfile:
            self.spoolfile = "+%s/INBOX" % (self.email)
        else:
            self.spoolfile = "+%s/%s" % (self.email, self.spoolfile)
        self.record = raw_input(" * sent messages (Send Messages) : ")
        if not self.record:
            self.record = "+%s/Send Messages" % (self.email)
        else:
            self.record = "+%s/%s" % (self.email, self.record)
        self.postponed = raw_input(" * drafts (Drafts) : ")
        if not self.postponed:
            self.postponed = "+%s/Drafts" % (self.email)
        else:
            self.postponed = "+%s/%s" % (self.email, self.postponed)

    def __get_imap_infos(self):
        print(" > IMAP informations")
        self.imap_server = raw_input(" * IMAP server (imap.%s) : " % (self.domain))
        if not self.imap_server:
            self.imap_server = "imap.%s" % (self.domain)
        self.imap_port = raw_input(" * IMAP port (default) : ")
        self.imap_user = raw_input(" * IMAP username : ")
        self.imap_password = raw_input(" * IMAP password : ")
        self.imap_use_ssl = raw_input(" * IMAP use SSL ? (Y) ")
        if not self.imap_use_ssl:
            self.imap_use_ssl = "Y"
        if self.imap_use_ssl in ["Y", "y", "O", "o", "yes", "oui"]:
            self.imap_use_ssl = "yes"
            #self.imap_cert_fingerprint = raw_input(" * IMAP SHA1 of server certificate : ")
        else:
            self.imap_use_ssl = "no"

    def __get_smtp_infos(self):
        print(" > SMTP informations")
        self.smtp_server = raw_input(" * SMTP server (smtp.%s) : " % (self.domain))
        if not self.smtp_server:
            self.smtp_server = "smtp.%s" % (self.domain)
        self.smtp_port = raw_input(" * SMTP port (default) : ")
        self.smtp_auth = raw_input(" * SMTP auth (Y) ?")
        if not self.smtp_auth:
            self.smtp_auth = "Y"
        if self.smtp_auth in ["Y", "y", "O", "o", "yes", "oui"]:
            self.smtp_auth = "on"
            self.smtp_user = raw_input(" * SMTP username (%s) : " % (self.imap_user))
            if not self.smtp_user:
                self.smtp_user = self.imap_user
            self.smtp_password = raw_input(" * SMTP password (%s) : " % (self.imap_password))
            if not self.smtp_password:
                self.smtp_password = self.imap_password
        else:
            self.smtp_auth = "off"
        self.smtp_tls = raw_input(" * SMTP use TLS ? (Y) ")
        if not self.smtp_tls:
            self.smtp_tls = "Y"
        if self.smtp_tls in ["Y", "y", "O", "o", "yes", "oui"]:
            self.smtp_tls = "on"
        else:
            self.smtp_tls = "off"

    def __create_dir_if_not_exist(self, directory):
        if not os.path.exists(directory):
            print(" > create %s" % (directory))
            os.mkdir(directory)
        else:
            print(" ! %s already exist. Keep it!" % (directory))

    def __check_account(self):
        self.account_file = os.path.join(self.dot_mutt_accounts, self.email)
        return os.path.exists(self.account_file)

    def __write_account_file(self):
        print(" > create %s" % (self.account_file))
        f = open(self.account_file, 'w')
        f.write("# %s\n" % (self.account_file))
        f.write('set from = "%s"\n' % (self.email))
        f.write('set realname = "%s"\n' % (self.realname))
        f.write('set sendmail = "%s -a %s"\n' % (self.msmtp, self.email))
        f.write('set spoolfile = "%s"\n' % (self.spoolfile))
        f.write('set record = "%s"\n' % (self.record))
        f.write('set postponed = "%s"\n' % (self.postponed))
        f.write('# set signature = "%s"\n' % (os.path.join(self.dot_mutt_signatures, self.email)))
        f.close()

    def __write_msmtprc(self):
        print(" > Update %s" % (self.msmtprc))
        f = open(self.msmtprc, 'a')
        f.write('\n\n')
        f.write('account %s\n' % (self.email))
        f.write('host %s\n' % (self.smtp_server))
        if self.smtp_port:
            f.write('port %s\n' % (self.smtp_port))
        f.write('protocol smtp\n')
        f.write('from %s\n' % (self.email))
        f.write('auth %s\n' % (self.smtp_auth))
        if self.smtp_auth == "on":
            f.write('user %s\n' % (self.smtp_user))
            f.write('password %s\n' % (self.smtp_password))
        f.write('tls %s\n' % (self.smtp_tls))
        f.write('tls_nocertcheck\n')
        f.close()
        os.chmod(self.msmtprc, 0600)

    def __write_muttrc_accounts(self):
        print(" > Update %s" % (self.muttrc_accounts))
        write_source = False
        if not os.path.exists(self.muttrc_accounts):
            write_source = True
        f = open(self.muttrc_accounts, 'a')
        if write_source:
            f.write('source ~/.mutt/accounts/%s\n' % (self.email))
        f.write('\n')
        f.write('folder-hook %s/* source ~/.mutt/accounts/%s\n' % (self.email, self.email))
        f.write("# macro index,pager <f2> '<sync-mailbox><enter-command>source ~/.mutt/accounts/%s<enter><change-folder>!<enter>'\n" % (self.email))
        f.close

    def __write_offlineimaprc(self):
        print(" > Update %s" % (self.offlineimaprc))
        config = ConfigParser.RawConfigParser()
        if os.path.exists(self.offlineimaprc):
            config.read(self.offlineimaprc)
            accounts = config.get('general', 'accounts')
            accounts = "%s, %s" % (accounts, self.email)
            config.set('general', 'accounts', accounts)
            maxsyncaccounts = config.getint('general', 'maxsyncaccounts')
            maxsyncaccounts = maxsyncaccounts + 1
            config.set('general', 'maxsyncaccounts', maxsyncaccounts)
        else:
            config.add_section('general')
            config.set('general', 'accounts', self.email)
            config.set('general', 'maxsyncaccounts', 1)
            config.set('general', 'socktimeout', 60)
            config.set('general', 'ui', 'basic')

        config.add_section('Account %s' % (self.email))
        config.set('Account %s' % (self.email), 'localrepository', '%s-local' % (self.email))
        config.set('Account %s' % (self.email), 'remoterepository', '%s-remote' % (self.email))

        config.add_section('Repository %s-local' % (self.email))
        config.set('Repository %s-local' % (self.email), 'type', 'Maildir')
        config.set('Repository %s-local' % (self.email), 'localfolders', '~/Mail/%s' % (self.email))

        config.add_section('Repository %s-remote' % (self.email))
        config.set('Repository %s-remote' % (self.email), 'type', 'IMAP')
        config.set('Repository %s-remote' % (self.email), 'remotehost', self.imap_server)
        if self.imap_port:
            config.set('Repository %s-remote' % (self.email), 'remoteport', self.imap_port)
        config.set('Repository %s-remote' % (self.email), 'remoteuser', self.imap_user)
        config.set('Repository %s-remote' % (self.email), 'remotepass', self.imap_password)
        config.set('Repository %s-remote' % (self.email), 'ssl', self.imap_use_ssl)
        if self.imap_use_ssl == "yes":
            # config.set('Repository %s-remote' % (self.email), 'cert_fingerprint', self.imap_cert_fingerprint)
            config.set('Repository %s-remote' % (self.email), 'sslcacertfile', '/etc/ssl/certs/ca-certificates.crt')
        config.set('Repository %s-remote' % (self.email), 'realdelete', 'no')

        with open(self.offlineimaprc, 'wb') as configfile:
            config.write(configfile)

    def __add_link(self, src, dst):
        makelink = True
        if os.path.exists(dst):
            print(" ! File %s exist!" % (src))
            answer = raw_input("Replace it (Y) ? ")
            if not answer:
                answer = "Y"
            if answer in ["Y", "y", "O", "o", "yes", "oui"]:
                os.remove(dst)
            else:
                makelink = False
        if makelink:
            os.symlink(src, dst)

    def __copy_file(self, src, dst):
        makecopy = True
        if os.path.exists(dst):
            print(" ! File %s exist!" % (src))
            answer = raw_input("Replace it (N) ? ")
            if not answer:
                answer = "N"
            if answer in ["Y", "y", "O", "o", "yes", "oui"]:
                os.remove(dst)
            else:
                makecopy = False
        if makecopy:
            shutil.copy(src, dst)


if __name__ == "__main__":
    conf = MuttConfiguration()
    conf.install_muttrc()
    conf.create_mutt_directories()
    conf.add_mutt_files()
    conf.add_account()
