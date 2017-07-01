#!/bin/sh

INSTALL_ROOT_PATH=$(cd $(dirname $0) && pwd)
echo $INSTALL_ROOT_PATH

(crontab -l ; echo "*/3 * * * * $INSTALL_ROOT_PATH/mailrun.sh") | sort - | uniq - | crontab -
(crontab -l ; echo "*/3 * * * * $INSTALL_ROOT_PATH/mail_notify.sh") | sort - | uniq - | crontab -
