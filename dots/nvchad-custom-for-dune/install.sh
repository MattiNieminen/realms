#!/usr/bin/env bash

rm -rf ~/.config/nvim/lua/custom
mkdir -p ~/.config/nvim/lua/custom
cp -r *.lua configs ~/.config/nvim/lua/custom/
