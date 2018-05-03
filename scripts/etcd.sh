#!/usr/bin/env bash

git clone https://github.com/coreos/etcd.git

cd etcd

./build

cp ./bin/etcd /usr/local/bin/

cp ./bin/etcdctl /usr/local/bin/

etcd --version


IP=$(ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'|tr -d "addr:" | awk "{if (NR == 2) {print $1}}")
IP1=45.76.211.150
IP2=2
Ip3=3

echo << TPL > /lib/systemd/system/etcd.service
[Unit]
Description=Etcd Server
After=network.target
After=network-online.target
Wants=network-online.target

[Service]
Type=notify
#WorkingDirectory=/usr/local/src/etcd-v3.1.7-linux-amd64
#EnvironmentFile=/usr/local/src/etcd-v3.1.7-linux-amd64/etcd.conf
# set GOMAXPROCS to number of processors
ExecStart=/usr/local/bin/etcd \
--name k8sETCD$IP \
--initial-advertise-peer-urls http://$IP:4010 \
--listen-peer-urls http://0.0.0.0:4010 \
--advertise-client-urls http://$IP:4011,http://$IP:4012 \
--listen-client-urls http://0.0.0.0:4011,http://0.0.0.0:4012 \
--initial-cluster-token k8s-etcd-cluster \
--initial-cluster k8sETCD0=http://$IP:4010,k8sETCD1=http://$IP:4010,k8sETCD2=http://$IP:4010 \
--initial-cluster-state new

Restart=on-failure
LimitNOFILE=65536


[Install]
WantedBy=multi-user.target
TPL

systemctl daemon-reload
systemctl start etcd

curl -L http://$IP:4012/version
