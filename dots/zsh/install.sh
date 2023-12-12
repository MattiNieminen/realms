#!/usr/bin/env bash

mkdir -p "$HOME/.zsh"
rm -rf "$HOME/.zsh/pure"
git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"

cp .zshrc ~
