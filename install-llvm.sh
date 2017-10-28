#!/bin/bash

# update repo data
sudo apt update

# install llvm runtime and m4 preprocessor
sudo apt install llvm-3.8-dev llvm-3.8 llvm-runtime m4

# install ocaml llvm binding
opam install llvm.3.8

# set opam environment for current shell
eval `opam config env`
