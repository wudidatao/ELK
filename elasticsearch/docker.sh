#首次启动，创建容器
docker-compose up -d

#初始化容器
docker cp 9414e701e6b2:/usr/share/elasticsearch /data/
#容器写入时会有权限问题，暂设777解决
chmod -R 777 /data/elasticsearch

#二次启动，映射配置
docker-compose up -d

#如果需要重建容器的数据文件，可以把数据目录改个名
mv -r /usr/share/elasticsearch /usr/share/elasticsearch_bak
