#!/bin/bash

. ./var.sh

wget https://artifacts.elastic.co/downloads/kibana/kibana-6.6.0-x86_64.rpm
rpm -ivh kibana-6.6.0-x86_64.rpm

cd /etc/kibana/

sed -i "s/#server.port: 5601/server.port: 5601/g" kibana.yml
sed -i "s/#server.host: "localhost"/server.host: \"$host_ip\"/g" kibana.yml
sed -i "s/#elasticsearch.hosts: [\"http:\/\/localhost:9200\/elasticsearch.hosts: [\"http:\/\/$host_ip:9200"]//g" kibana.yml
#sed -i "s///g" kibana.yml

systemctl start kibana
systemctl enable kibana 
