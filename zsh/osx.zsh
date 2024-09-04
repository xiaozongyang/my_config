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
alias ke="k exec -it"
