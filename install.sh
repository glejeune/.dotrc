#!/bin/bash

CURRENT_PATH=$(pwd)
INSTALL_ROOT_PATH=$(cd $(dirname $0) && pwd)
TS=$(date +"%s")

PLATFORM='unknown'
_UNAMESTR=`uname`
if [ "$_UNAMESTR" == "Linux" ] ; then
  PLATFORM='linux'
elif [ "$_UNAMESTR" == "Darwin" ] ; then
  PLATFORM='darwin'
fi

install_powerline_fonts() {
  if [ "$PLATFORM" == "darwin" ] ; then
    cd $INSTALL_ROOT_PATH
    git clone https://github.com/Lokaltog/powerline-fonts.git
    find powerline-fonts -type f -iname "*.[o|t]tf" -exec cp {} ~/Library/Fonts \;
    rm -rf powerline-fonts
  elif [ "$PLATFORM" == "linux" ] ; then
    cd $INSTALL_ROOT_PATH
    wget https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf
    wget https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf
    mkdir -p ~/.fonts
    mv PowerlineSymbols.otf ~/.fonts
    fc-cache -vf ~/.fonts 
    mkdir -p ~/.fonts.conf.d/
    mkdir -p ~/.config/fontconfig/conf.d/
    cp 10-powerline-symbols.conf ~/.fonts.conf.d/
    mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/
  fi
}

install_vundle() {
  cd ~
  mv .vimrc .vimrc.keep
  mv .vimrc.bundle .vimrc
  cd $INSTALL_ROOT_PATH
  mkdir -p _vim/bundle
  [ -e "_vim/bundle/vundle" ] || git clone https://github.com/gmarik/vundle.git _vim/bundle/vundle
  vim +BundleInstall +qall
  cd ~
  mv .vimrc .vimrc.bundle
  mv .vimrc.keep .vimrc
}

save_and_link() {
  _SOURCE=$1
  _DESTINATION=$2
  [ -e "$_DESTINATION" ] && mv $_DESTINATION $_DESTINATION.save-$TS
  ln -s $INSTALL_ROOT_PATH/$_SOURCE $_DESTINATION
}

create_symlinks() {
  cd ~
  save_and_link "_zsh" ".zsh"
  save_and_link "_zshrc" ".zshrc"
  save_and_link "_vim" ".vim"
  save_and_link "_vimrc" ".vimrc"
  save_and_link "_vimrc.bundle" ".vimrc.bundle"
  save_and_link "_tmux.conf" ".tmux.conf"
  save_and_link "_tmux.macosx" ".tmux.macosx"
  save_and_link "_tmux.linux" ".tmux.linux"
  save_and_link "_ctags" ".ctags"
  save_and_link "_muttrc" ".muttrc"
  save_and_link "_screenrc" ".screenrc"
}

configure_gmail_for_mutt() {
  echo ""
  echo "** Gmail configuration :"
  echo ""
  OK=no
  while [ "$OK" != "yes" ]; do
    echo -n "Your firstname : "; read FNAME
    echo -n "Your lastname : "; read LNAME
    echo -n "Your GMail login : "; read GLOGIN
    echo -n "Your GMail password : "; read GPASS
    if [ $(echo "$GLOGIN" | grep -c "@") -eq 0 ] ; then
      GMAIL=$(echo "$GLOGIN@gmail.com")
    else
      GMAIL=$(echo "$GLOGIN")
      GLOGIN=$(echo "$GLOGIN" | sed -e 's/@.*//')
    fi
    echo -n "It's good? [yes] : "; read OK
    if [ "Z$OK" == "Z" ]; then
      OK="yes"
    fi
  done

  [ -e .muttrc.gmail ] && mv .muttrc.gmail .muttrc.gmail-save-$TS
  echo "my_hdr From: $FNAME $LNAME <$GMAIL>" > .muttrc.gmail
  echo "set envelope_from_address=\"$GMAIL\"" >> .muttrc.gmail
  echo "set imap_user=\"$GMAIL\"" >> .muttrc.gmail
  echo "set imap_pass=\"$GPASS\"" >> .muttrc.gmail
  echo "set smtp_url=\"smtps://$GLOGIN:$GPASS@smtp.gmail.com:465\"" >> .muttrc.gmail
}

configure_mutt() {
  cd ~
  mkdir -p .mutt/cache/bodies
  configure_gmail_for_mutt
}

install_local() {
  cd ~
  mkdir .zshrc.local
  cd .zshrc.local
  git clone git://github.com/zsh-users/zsh-syntax-highlighting.git
  echo "source $ZSHRC_LOCAL/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
}

create_symlinks
install_vundle
install_powerline_fonts
configure_mutt
install_local
cd $CURRENT_PATH

echo ""
echo "** Installation complete... Enjoy!"
echo ""

