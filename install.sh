#!/bin/sh

CURRENT_PATH=$(pwd)
INSTALL_ROOT_PATH=$(cd $(dirname $0) && pwd)
TS=$(date +"%s")

PLATFORM='unknown'
_UNAMESTR=`uname`
if [[ "$_UNAMESTR" == 'Linux' ]]; then
  PLATFORM='linux'
elif [[ "$_UNAMESTR" == 'Darwin' ]]; then
  PLATFORM='darwin'
fi

install_powerline_fonts() {
  cd $INSTALL_ROOT_PATH
  git clone https://github.com/Lokaltog/powerline-fonts.git
  find powerline-fonts -type f -iname "*.[o|t]tf" -exec cp {} ~/Library/Fonts \;
  rm -rf powerline-fonts
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
  save_and_link "_ctags" ".ctags"
}

create_symlinks
install_vundle
install_powerline_fonts
cd $CURRENT_PATH

echo "** Installation complete... Enjoy!"

