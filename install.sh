#!/usr/bin/bash

# clone oh-my-zsh and change shell to zsh
cd ~ && sh -c "$(curl -fsSL \
    https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
# replace original .zshrc with mine and reload it
mv ~/.zshrc ~/.zshrc.bak
ln -s .zshrc ~/.zshrc
source ~/.zshrc

# install vim-plug plugin manager
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

if [ -d ~/.vim/templates ]; then
    mv ~/.vim/templates ~/.vim/templates.bak
fi
ln -s ~/.my_config/vim_templates ~/.vim/templates
