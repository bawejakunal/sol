#!/bin/bash

#@author: Kunal Baweja

# update repo data
sudo apt update

# install llvm runtime and m4 preprocessor
sudo apt install --yes llvm-3.8-dev \
    llvm-3.8    \
    llvm-runtime\
    m4          \
    llvm

# install ocaml llvm binding
opam install --yes llvm.3.8

