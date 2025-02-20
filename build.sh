#!/bin/sh

go install github.com/Vaelatern/mdbook-d2-go@latest
export PATH="$PATH:~/go/bin"

cargo install mdbook-callouts
export PATH="$PATH:~/.cargo/bin"

mdbook build
