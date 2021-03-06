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
    mkdir -p ~/.config/fontconfig/conf.d/
    mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/
  fi
}

install_vundle() {
  cd ~
  mv .vimrc .vimrc.keep
  mv .vimrc.bundle .vimrc
  cd $INSTALL_ROOT_PATH
  [ -e "_vim/bundle" ] && rm -rf _vim/bundle
  [ -e "_vim/plugged" ] && rm -rf _vim/plugged
  mkdir -p _vim/plugged
  [ -e "~/.local/share/nvim/site/autoload/plug.vim" ] || curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  vim +PlugInstall +qall
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
  mkdir -p ~/.config/nvim/

  # zsh
  save_and_link "_zsh" ".zsh"
  save_and_link "_zshrc" ".zshrc"
  # tmux
  save_and_link "_tmux.conf" ".tmux.conf"
  save_and_link "_tmux.macosx" ".tmux.macosx"
  save_and_link "_tmux.linux" ".tmux.linux"
  # vim
  save_and_link "_vim" ".vim"
  save_and_link "_vimrc" ".vimrc"
  save_and_link "_vimrc.bundle" ".vimrc.bundle"
  # nvim
  save_and_link "bundle.vim" ".config/nvim/bundle.vim"
  save_and_link "init.vim" ".config/nvim/init.vim"
  save_and_link "_vim/bundle" ".config/nvim/bundle"
  save_and_link "_vim/snippets" ".config/nvim/snippets"

  save_and_link "_ctags" ".ctags"
  save_and_link "_irbrc" ".irbrc"
  save_and_link "_urlview" ".urlview"
  save_and_link "_screenrc" ".screenrc"
  save_and_link "_gitconfig" ".gitconfig"
  save_and_link "_editorconfig" ".editorconfig"
}

install_local() {
  cd ~
  mkdir .zshrc.local
  cd .zshrc.local
  git clone git://github.com/zsh-users/zsh-syntax-highlighting.git
  git clone https://github.com/supercrabtree/k.git
  ZSHRC_LOCAL=$(pwd)
  echo "source $ZSHRC_LOCAL/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" > zshrc
  echo "source $ZSHRC_LOCAL/k/k.sh" >> zshrc
}

install_wrangler() {
  mkdir -p ~/bin
  git clone https://github.com/RefactoringTools/wrangler ~/bin/wrangler
  cd ~/bin/wrangler
  ./configure
  make
}

install_gems() {
  gem install what_methods
}

create_symlinks
install_vundle
install_powerline_fonts
install_local
install_wrangler
cd $CURRENT_PATH

echo ""
echo "** Installation complete... Enjoy!"
echo ""

