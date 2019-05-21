#!/bin/bash
#强烈建议使用rpm安装，可以默认设置好很多系统参数，无需在安装后再次设置
. ./var.sh

yum install java -y

yum install wget -y
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-6.6.0.rpm
rpm -ivh elasticsearch-6.6.0.rpm

cd /etc/elasticsearch/
sed -i "s/#cluster.name: my-application/cluster.name: $cluster_name/g" elasticsearch.yml
sed -i "s/#node.name: node-1/node.name: $node_name/g" elasticsearch.yml
sed -i "s/#node.attr.rack: r1/node.attr.rack: $node_attr_rack/g" elasticsearch.yml
sed -i "s/#network.host: 192.168.0.1/network.host: $host_ip/g" elasticsearch.yml
sed -i "s/#http.port: 9200/http.port: $http_port/g" elasticsearch.yml
sed -i "s&#discovery.zen.ping.unicast.hosts: \[\"host1\", \"host2\"\]&discovery.zen.ping.unicast.hosts: $hosts&g" elasticsearch.yml
sed -i "s/#discovery.zen.minimum_master_nodes:/discovery.zen.minimum_master_nodes: $master_nodes/g" elasticsearch.yml
sed -i "s/#gateway.recover_after_nodes: 3/gateway.recover_after_nodes: $recover_after_nodes/g" elasticsearch.yml

systemctl start elasticsearch
systemctl enable elasticsearch.service
