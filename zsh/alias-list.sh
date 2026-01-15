alias vzshrc="vim ~/.zshrc"
alias szshrc="source ~/.zshrc"
alias bi="brew install"
alias bic="bi --cask"
alias python="python3"
alias py="python"

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

# kubectl
alias kaf="k apply -f"
alias kcf="k create -f"
alias kdff="k diff -f"
alias kafd="k apply --dry-run=server -f"
alias kdel="k delete"
alias kdelf="kdel -f"
alias kcgc="kubectl config get-contexts"

# go
alias gomt="go mod tidy"
alias gobu="go build ./..."
alias govt="go vet ./..."
alias gotest="go test ./..."

# java
alias java-debug="java -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=8000"
alias get-local-ip="ifconfig| grep 'inet ' | grep '10.' | awk '{print \$2}'"

# python
alias pyvenv="python -m venv .venv && source .venv/bin/activate"
