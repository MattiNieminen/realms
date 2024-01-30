#!/usr/bin/env bash

mkdir -p ~/.clojure
rm -rf ~/.clojure/deps.edn
cp deps.edn ~/.clojure/deps.edn

echo "" >> ~/.zshrc
echo "alias conjure=\"clj -M:repl/conjure\"" >> ~/.zshrc
