# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
#export ZSH=/home/xiaozy/.oh-my-zsh
export ZSH=/usr/share/oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

########## ENV varaiables ###########
export TOMCAT_HOME="/usr/share/tomcat8"
export LC_CTYPE=zh_CN.UTF-8
export VISUAL="vim"
export SSH_AUTH_SOCK=/tmp/ssh-HzyUYoAm5g6f/agent.6068
export SSH_AGENT_PID=SSH_AGENT_PID=6069
export CEPH_DEPLOY_REPO_URL=http://mirrors.ustc.edu.cn/ceph
export PATH="${HOME}/.local/bin:${PATH}"
export MEDIA_HOME="/run/media/xiaozy/"
export PAGER="vimpager"
export LANG=en_US.UTF-8
export REPO_URL='https://mirrors.tuna.tsinghua.edu.cn/git/git-repo/'

### Wine Envs ###
export WINEARCH=win32
export WINEPREFIX=~/.deepinwine

########## custom alias ##############
alias vi="vim"
alias ptpython="ptpython --vi"
alias gs="git status"
alias tailf="tail -f"
alias less="$(ls /usr/share/vim/vim*/macros/less.sh)"
alias git="hub"
#alias python=$(which python3.6)
alias pydb2="python2 -m pdb"
alias pydb3="python3 -m pdb"


function pkg_rm_orphan(){
    echo "rmove orphan packages"
    sudo pacman -Rns $(pacman -Qdtq)
}

function batch_chown(){
    ll $1 |  sed '1,2d' | awk -F '->' '{print $NF}' | xargs sudo chown -R $(whoami)
}

function ftppath(){
    if [ -z $1 ]; then
        echo "Argument \$1: file required!" && return 1
    fi
    file=$1
    echo "ftp://$(hostname)$(realpath ${file})"
}

# ls files without extensions
function ls_noext(){
    ls -1 "$@" | awk -F '.' '{print $1}'
}

function connect_remote_desktop(){
    local _REMOTE_IP=10.109.246.16
    rdesktop -g 1920x1000 -P -z -u jiaohuan  2>&1 >/dev/null &
}

function mv2ngix(){
    nginx_dir=/usr/share/nginx/html
    for f in $@; do
        sudo mv $f $nginx_dir
    done
}

## auto-start X at login
if [ -z "${DISPLAY}" ] \
    && [ -n "${XDG_VTNR}" ] \
    && [ "${XDG_VTNR}" -eq 1 ]
then
    exec startx
fi
#
# auto-play music at login
#

function play_music(){
    _MUSIC_PID="$(ps -ef | grep mplayer | grep music-playlist | sed '/grep/d'| awk '{print $2}')"
    if [ -z "${_MUSIC_PID}" ]; then
        nohup mplayer -playlist ~/Music/music-playlist -vo null &
    fi
}

function stop_music(){
    if [ -n ${_MUSIC_PID} ]; then
        kill -9 ${_MUSIC_PID}
        unset _MUSIC_PID
    fi

}

#play_music
#

## auto start xscreensaver
if [ -z "$(pgrep gnome-screensav)" ]; then
    gnome-screensaver & disown
fi

function load_im_fcitx(){
    ########### use fcitx as input source ############
    export GTK_IM_MODULE=fcitx
    export XMODIFIERS=@im=fcitx
    export QT_IM_MODULE=fcitx
    export XIM=fcitx
    export XIM_PROGRAM=fcitx
}

function load_im_ibus(){
    ########### use ibus as input source #############
    export XMODIFIERS=@im=ibus
    export QT_IM_MODULE=ibus
    export XIM=ibus
    export XIM_PROGRAM=ibus
}

load_im_ibus

function venv2_init(){
    local VENV_DIR=${1:=.venv2}
    virtualenv ${VENV_DIR} -p $(which python2) --no-site-packages
    source ${VENV_DIR}/bin/activate
}

function venv3_init(){
    local VENV_DIR=${1:=.venv3}
    virtualenv ${VENV_DIR} -p $(which python2) --no-site-packages
    source ${VENV_DIR}/bin/activate
}

function venv2_activate(){
    local ACTIVATE_SCRIPT=${1:=.venv2/bin/activate}
    source ${ACTIVATE_SCRIPT}
}

function venv3_activate(){
    local ACTIVATE_SCRIPT=${1:=.venv3/bin/activate}
    source ${ACTIVATE_SCRIPT}
}
