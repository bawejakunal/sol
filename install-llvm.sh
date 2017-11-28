#!/bin/bash

# update repo data
sudo apt update

# install llvm runtime and m4 preprocessor
sudo apt install --yes llvm-3.8-dev llvm-3.8 llvm-runtime m4 llvm

# install sdl
sudo apt install --yes libegl1-mesa-dev libgles2-mesa-dev sdl2-2.0 libsdl2-dev

# install ocaml llvm binding
opam install --yes llvm.3.8

