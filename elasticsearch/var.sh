#!/bin/bash

elasticsearch_base=/usr/share/
elasticsearch_home=$elasticsearch_base/elasticsearch

#集群名称
cluster_name=my-application

#根据节点修改,各节点不同
node_name=node-1

#节点描述，各节点不同
node_attr_rack=r1

#数据文件位置
#path_data=$elasticsearch_home/data

#日志文件位置
#path_logs=$elasticsearch_home/logs

#本地ip
host_ip=192.168.1.54

#监听端口
http_port=9200

#初始化节点ip
hosts=[\"192.168.1.54\",\"192.168.1.55\",\"192.168.1.56\"]

#最少主节点数，默认为空
master_nodes=2

#设置这个集群中节点的数量，默认为2，一旦这N个节点启动，就会立即进行数据恢复
recover_after_nodes=2

