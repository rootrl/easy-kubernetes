#!/usr/bin/env bash

systemctl stop firewalld.service

yum update -y

yum install -y git vim net-tools.x86_64

yum install gcc gcc-c++ kernel-devel -y
