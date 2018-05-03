#!/usr/bin/env bash

systemctl stop firewalld.service

yum update -y

yum install git -y

yum install gcc gcc-c++ kernel-devel -y
