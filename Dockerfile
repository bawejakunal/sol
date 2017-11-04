FROM ubuntu:artful

# Create superuser separate from root
ARG user=plt
RUN apt-get update && apt-get -y install sudo
RUN echo "$user ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN adduser --disabled-password --shell /bin/bash --ingroup sudo --gecos "$user,,," $user
USER $user

# Install dependencies for MicroC
RUN sudo apt-get update && sudo apt-get install -y m4 clang cmake pkg-config make ocaml opam llvm-5.0-dev
RUN opam init && eval `opam config env` && opam install llvm

# Configure environment
RUN echo 'eval `opam config env`' >> /home/$user/.bashrc
RUN sudo ln -s `which lli-5.0` /usr/local/bin/lli
RUN sudo ln -s `which llc-5.0` /usr/local/bin/llc

# Add MicroC code to /app folder of the image and set
# this directory as the default working directory
ADD . /app
RUN sudo chown -R $user /app
WORKDIR /app
