#!/bin/bash

sudo add-apt-repository ppa:ubuntu-toolchain-r/test -y
sudo apt-get update -qq
sudo apt-get autoremove -y
sudo apt-get install -y gcc-${GCC_VERSION} gfortran-${GCC_VERSION}
