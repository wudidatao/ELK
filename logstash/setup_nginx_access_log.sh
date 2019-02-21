#!/bin/bash

#nginx日志改成json格式

#标准
log_format  json  '{"remote_addr": "$remote_addr","remote_user": "$remote_user","time_local":"[$time_local]","request":"$request","status":"$status","body_bytes_sent":"$body_bytes_sent","http_referer":"$http_referer","http_user_agent":"$http_user_agent","http_x_forwarded_for":"$http_x_forwarded_for" }';

#优化


access_log  /var/log/nginx/access_json.log  json;



echo "
input {
    file {
        path => "/var/log/nginx/access_json.log"
        codec => "json"
        type => "nginx-access-log"
    }
}

filter {

}

output {
    elasticsearch {
        hosts => ["192.168.1.54:9200"]
        index => "nginx-access-log-%{+YYYY.MM.dd}"
    }
}
" > nginx-access-log.conf

cp nginx-access-log.conf /etc/logstash/conf.d/

chmod 644 /var/log/nginx/access_json.log

#第一次开始日志收集，默认从access_log_json.log尾部开始读取数据，如果没有新数据产生，则不会生成索引。当新数据生成是，索引创建并追加生成索引。

#刷日志 ab -n 10 -1 http://192.168.1.57/
