#!/bin/bash

echo "
input {
    file{
        path => "/var/log/messages"
        type => "system-log"
        start_position => "beginning"
    }
    file{
        path => "/var/log/secure"
        type => "secure-log"
        start_position => "beginning"
    }

}

output {
    if [type] == "system-log" {
        elasticsearch {
            hosts => ["192.168.1.54:9200"]
            index => "system-log-messages%{+YYYY.MM}"
        }
    }
    if [type] == "secure-log" {
        elasticsearch {
            hosts => ["192.168.1.54:9200"]
            index => "system-log-secure%{+YYYY.MM}"
        }
    }
}
" > system_log.conf

chmod 644 /var/log/messages
chmod 644 /var/log/secure

#多行[开始的内容合并到一个事件中
input {
    file{
        path => "/var/log/messages"
        type => "system-log"
        start_position => "beginning"
        codec => multiline {
            pattern => "^\["
            negate => true
            what => "previous"
        }
    }
}
