#首次启动，创建容器
docker-compose up -d

#初始化容器
docker cp 9414e701e6b2:/usr/share/kibana /data/
#容器写入时会有权限问题，暂设777解决
chmod -R 777 /data/kibana

#二次启动，映射配置
docker-compose up -d
