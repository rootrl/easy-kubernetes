#!/usr/bin/env bash

wget https://storage.googleapis.com/golang/go1.9.1.linux-amd64.tar.gz

sudo tar -C /usr/local -xzf go1.9.1.linux-amd64.tar.gz 

echo "export GOROOT=/usr/local/go" >> /etc/profile

echo "export PATH=\$PATH:\$GOROOT/bin" >> /etc/profile

source /etc/profile
