#!/bin/bash

. ./var.sh

yum install git -y
wget https://nodejs.org/dist/v10.15.1/node-v10.15.1-linux-x64.tar.xz
xz -d node-v10.15.1-linux-x64.tar.xz
tar -xvf node-v10.15.1-linux-x64.tar
mv node-v10.15.1-linux-x64 /usr/local/node

sed -i "s/bin$/&:\/usr\/local\/node\/bin/" ~/.bash_profile
source ~/.bash_profile

node -v
npm -v

npm install -g cnpm --registry=https://registry.npm.taobao.org
#add
npm install -g grunt-cli
cnpm -v

wget https://github.com/mobz/elasticsearch-head/archive/master.zip
yum install unzip -y
unzip master.zip
mv master.zip elasticsearch-head-master.zip
cd elasticsearch-head-master
yum install bzip2 -y
#根据实际缺失文件安装，不同版本有所不同
npm install phantomjs-prebuilt@2.1.16 --ignore-scripts


#Gruntfile.js文件增加hostname: '*',不要忘记

echo "
http.cors.enabled: true
http.cors.allow-origin: "*"
" >> /etc/elasticsearch/elasticsearch.yml

#启动elasticsearch-head-master插件
nohup npm run start &

echo "访问http://${host_ip}:9100"
