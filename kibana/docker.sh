docker-compose up -d

#初始化容器
docker cp 9414e701e6b2:/usr/share/kibana /data/

重新加载
docker-compose up -d
