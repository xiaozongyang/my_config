#!/usr/bin/bash
CURDIR=`cd $(dirname $0) && pwd`

# backup [file]
function backup() {
    if [ -f $1 ]; then
        mv "$1" "$1-bak"
    fi
}

# link [from] [to]
function link() {
    if [ -z $2 ]; then
        return 1
    fi
    ln -s $1 $2
}

# backup existing configuration and link new
function install() {
    backup ~/.vimrc
    backup ~/.tmux.conf
    backup ~/.gitconfig

    mkdir -p ~/.config/git

    link vimrc ~/.vimrc
    link vim ~/.vim
    link tmux.conf ~/.tmux.conf
    link gitconfig ~/.gitconfig
    link git-ignore-gloabl ~/.config/git/git-ignore-global
}

# restore to original configuration
function uninstall() {
    rm ~/.vimrc ~/.tmux.conf ~/.gitconfig
    mv ~/.vimrc-bak ~/.vimrc
    mv ~/.tmux.conf-bak ~/.tmux.conf
    mv ~/.gitconfig-bak ~/.gitconfig
}

# print help message
function print_help_message() {
    echo "usage: 'sh install.sh install|uninstall'"
}

cmd=${1:-install}

if [ ${cmd} != "install" ] || [ ${cmd} != "uninstall" ]; then
    ${cmd}
else
    print_help_message
fi
