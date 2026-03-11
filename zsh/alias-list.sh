#bash
alias vzshrc="vim ~/.zshrc"
alias szshrc="source ~/.zshrc"
alias wcl="wc -l"

alias bi="brew install"
alias bic="bi --cask"

# maven
alias mci="mvn clean install"
alias mcp="mvn clean package"
alias mcd="mvn clean deploy"
alias mcpst="mcp -DskipTests=true -Dmaven.test.skip=true"

# git
alias g="git"
alias gss="g status --short"
alias gp="g push"
alias gf="g fetch"
alias gfo="gf origin"
alias gpo="gp origin"
alias gpom="gpo main"
alias gcom="gco main"
alias grp="g rev-parse"
alias grps="g rev-parse --short"
alias gcamc="git commit --amend -C @"
alias grb="g rebase"
alias grbo="grb origin"
alias grbom="grb origin/main"
alias gco="g checkout"
alias gcob="g checkout -b"
alias gbr="git branch"
alias gbrsc="git branch --show-current"

# kubectl
alias k="kubectl"
alias kg="k get"
alias kgw="kg -o wide"
alias kgy="kg -o yaml"
alias kgj="kg -o json"
alias ke="k exec -it"
alias kd="k describe"
alias kdp="kd po"
alias kaf="k apply -f"
alias kcf="k create -f"
alias kdff="k diff -f"
alias kafd="k apply --dry-run=server -f"
alias kdel="k delete"
alias kdelf="kdel -f"
alias kcgc="kubectl config get-contexts"

## kubectx
alias kx="kubectx"
alias kxc="kx -c"
alias kxcp="kxc | pbcopy"

# go
alias gomt="go mod tidy"
alias gomg="go mod graph"
alias gomw="go mod why"
alias gobu="go build ./..."
alias govt="go vet ./..."
alias gotest="go test ./..."

# java
alias java-debug="java -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=8000"
alias get-local-ip="ifconfig| grep 'inet ' | grep '10.' | awk '{print \$2}'"

# python
alias python="python3"
alias py="python"
alias pyvenv="python -m venv .venv && source .venv/bin/activate"

alias cc='claude'
alias ccp='--permission-mode plan'
