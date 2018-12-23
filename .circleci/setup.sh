#!/bin/bash

sudo apt-get update && sudo apt-get install -y wget git \
                                                    build-essential \
                                                    squashfs-tools \
                                                    libtool \
                                                    autotools-dev \
                                                    libarchive-dev \
                                                    automake \
                                                    autoconf \
                                                    uuid-dev \
                                                    libssl-dev \
                                                    figlet


sudo sed -i -e 's/^Defaults\tsecure_path.*$//' /etc/sudoers

# Check Python

echo "Python Version:"
python --version
pip install sregistry[all]
sregistry version

echo "sregistry Version:"

# Install Singularity

cd /tmp && \
    git clone -b vault/release-2.6 https://www.github.com/sylabs/singularity.git
    cd singularity && \
    ./autogen.sh && \
    ./configure --prefix=/usr/local && \
    make && sudo make install
