#!/bin/bash
alias bi="brew install"
alias bic="brew install --cask"

function install_formulas() {
    bi go
    bi gopls

    bi yq
    bi hurl

    # k8s clis
    bi kubernetes-cli
    bi kubectx
    bi kustomize

    # docker
    bi colima
    # npm
    bi npm
}

function install_casks() {
    bic alfred
    bic maccy
    bic dbeaver-community
    bic obsidian
    bic ghostty
    bic snipaste
}
