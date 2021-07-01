#!/bin/sh

docker build -t rmckaykm/ubuntu-2004-clang-11:latest -f src/Dockerfile .

#docker run --rm -it -V $(pwd):/home/build rmckaykm/gcc-10host-arm:latest apt list --installed