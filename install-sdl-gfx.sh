#!/bin/bash

SDL_GFX="SDL2_gfx-1.0.3"
SDL_GFX_TAR=$SDL_GFX".tar.gz"

# install sdl
sudo apt install --yes libegl1-mesa-dev libgles2-mesa-dev sdl2-2.0 libsdl2-dev

# untar the file folder
tar xvzf $SDL_GFX_TAR

# step into directory
cd $SDL_GFX

# generate
./autogen.sh

# configure
./configure --prefix=/usr

# make
make

# install
sudo make install
