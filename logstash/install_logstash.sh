#!/bin/bash

rpm -ivh jdk-8u60-linux-x64.rpm

yum install wget -y
#wget https://artifacts.elastic.co/downloads/logstash/logstash-6.6.0.rpm
rpm -ivh logstash-6.6.0.rpm

#rpm安装时不使用/etc/logstash/目录启动服务，而是使用/usr/share/logstash/config/
mkdir -p /usr/share/logstash/config/
ln -s /etc/logstash/* /usr/share/logstash/config
chown -R logstash:logstash /usr/share/logstash/config/

#创建配置文件目录
echo "
LS_CONF_DIR=/etc/logstash/conf.d
" >> /etc/logstash/startup.options

echo "安装完成，测试服务是否正常，等待一段时间服务启动后，输入个hello，看是否有返回结果"
/usr/share/logstash/bin/logstash -e 'input { stdin {} } output { stdout {} }'

systemctl start logstash.service
systemctl enable logstash.service
