#!/bin/bash

#输出到es，对应索引logstash
/usr/share/logstash/bin/logstash -e 'input { stdin {} } output { elasticsearch { hosts => ["192.168.1.54:9200"] index => "logstash-%{+YYYy.MM.dd}" } }'
#输出到屏幕和es
/usr/share/logstash/bin/logstash -e 'input { stdin {} } output { stdout {} elasticsearch { hosts => ["192.168.1.54:9200"] index => "logstash-%{+YYYy.MM.dd}" } }'
#指定配置文件 -f 测试配置文件是否正确 -t
/usr/share/logstash/bin/logstash -t -f /etc/logstash/conf.d/nginx-access-log.conf


#启动配置
cat /etc/logstash/startup.options

#服务配置
cat /etc/logstash/logstash.yml

#sincedb文件位置
/var/lib/logstash/plugins/inputs/file

systemctl start logstash.service
systemctl stop logstash.service

#安装zabbix插件
/usr/share/logstash/bin/logstash-plugin list
/usr/share/logstash/bin/logstash-plugin install logstash-output-zabbix

#
/usr/share/logstash/vendor/bundle/jruby/2.3.0/gems/logstash-patterns-core-4.1.2/lib/logstash/patterns/
#java定义
/usr/share/logstash/vendor/bundle/jruby/2.3.0/gems/logstash-patterns-core-4.1.2/patterns/java
#修改catalina时间，默认的不对
CATALINA_DATESTAMP %{MONTHDAY}-%{MONTH}-20%{YEAR} %{HOUR}:?%{MINUTE}(?::?%{SECOND})

