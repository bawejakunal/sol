# SOL - Shape Oriented Language

SOL is an easy to use domain specific language for creating 2D animations. 

### Build Status

Travis CI is not supporting Xvfb headless UI testing as expected, causing test cases to be killed, hence the failed status.  
The tests pass on a UI supported testing environment.  

[![Build Status](https://travis-ci.com/bawejakunal/sol.svg?token=HmbQpxEB9Why6RZSRefB&branch=master)](https://travis-ci.com/bawejakunal/sol)

### Authors
**Aditya Narayanamoorthy (an2753)** - Language Guru  
**Gergana Alteva (gla2112)** - Project Manager  
**Erik Dyer (ead2174)** - Testing  
**Kunal Baweja (kb2896)** - System Architect & Testing  

### Compile SOL
Follow the below steps to install dependencies for SOL and compile `sol.native` compiler on `Ubuntu 16.04` or greater version.

1. Install *LLVM* dev and runtime packages and *opam llvm bindings* package.  
     `./install-llvm.sh`

2. Download *SDL GFX library* to support animation.  
    `wget http://www.ferzkopp.net/Software/SDL2_gfx/SDL2_gfx-1.0.3.tar.gz`

3. Build and Install *SDL GFX* and dependencies including *SDL2*.  
     `./install-sdl-gfx`

4. Build the `sol.native` compiler  
      `make clean all`

### Run Automated Tests
1. Run `./testall.sh` to run the test cases in [tests](tests/) folder.  
2. Test results can be seen on console `./testall.log` generated file.
