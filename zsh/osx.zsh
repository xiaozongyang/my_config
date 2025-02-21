source "$(dirname $(realpath $(which fzf)))/../shell/completion.zsh"
source "$(dirname $(realpath $(which fzf)))/../shell/key-bindings.zsh"

# env vars
## homebrew
export HOMEBREW_AUTO_UPDATE_SECS=86400

# aliases
## homebrew
alias bi="brew install"
alias bic="bi --cask"
alias bs="brew search"

## kubectx
alias kx="kubectx"
alias kxc="kx -c"

## kubectl
alias k="kubectl"
alias kg="k get"
alias kgw="kg -o wide"
alias kgy="kg -o yaml"
alias ke="k exec -it"
alias kd="k describe"
alias kdp="kd po"
