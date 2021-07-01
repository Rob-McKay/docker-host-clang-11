FROM ubuntu:latest

LABEL Description="Image for building with the host Clang-11 toolchain installed"
LABEL maintainer="Rob McKay"

RUN apt-get update && apt install -y ca-certificates && \
    rm -rf /var/lib/apt/lists/*

#&& echo 'APT::Acquire::Retries "3";' > /etc/apt/apt.conf.d/80-retries

# wget is needed to get the toolchain

# Use the closest mirrors, rather than the defaults from the docker image

RUN echo "deb mirror://mirrors.ubuntu.com/mirrors.txt focal main restricted universe multiverse">/etc/apt/sources.list && \
    echo "deb mirror://mirrors.ubuntu.com/mirrors.txt focal-updates main restricted universe multiverse">>/etc/apt/sources.list && \
    echo "deb mirror://mirrors.ubuntu.com/mirrors.txt focal-security main restricted universe multiverse">>/etc/apt/sources.list && \
    echo "deb mirror://mirrors.ubuntu.com/mirrors.txt focal-backports main restricted universe multiverse">>/etc/apt/sources.list && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get update && \
    apt-get install -y -f ninja-build wget bzip2 binutils binutils-common git gettext-base git-doc- gnupg manpages- manpages-dev- --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
    
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key --no-check-certificate | apt-key add - && \
    echo "deb http://apt.llvm.org/focal/ llvm-toolchain-focal-11 main" >>/etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y -f clang-tidy-11 libclang-common-11-dev clang-tools-11 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
    
WORKDIR /opt
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN wget https://github.com/Kitware/CMake/releases/download/v3.20.1/cmake-3.20.1-linux-x86_64.sh -O cmake-3.20.1-linux-x86_64.sh -q --no-check-certificate && \
    chmod +x cmake-3.20.1-linux-x86_64.sh && \
    printf "y\ny\n" | ./cmake-3.20.1-linux-x86_64.sh && \
    rm cmake-3.20.1-linux-x86_64.sh
    
# add the tools to the path
ENV PATH="/opt/cmake-3.20.1-linux-x86_64/bin:${PATH}"
WORKDIR /home/build
