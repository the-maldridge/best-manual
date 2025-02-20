#!/bin/sh

go install github.com/Vaelatern/mdbook-d2-go@latest
export PATH="$PATH:/opt/buildhome/go/bin"

cargo install mdbook-callouts
cargo install mdbook
mdbook build
