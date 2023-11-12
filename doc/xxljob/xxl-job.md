# 拉取镜像
```java
docker pull xuxueli/xxl-job-admin:2.3.0
```

# 创建容器
```java
docker run -e PARAMS="--spring.datasource.url=jdbc:mysql://139.198.181.54:3306/xxl_job?Unicode=true&characterEncoding=UTF-8 \
--spring.datasource.username=root \
--spring.datasource.password=Dcp#7ujm" \
-p 8888:8080 -v /tmp:/data/applogs \
--name xxl-job-admin --restart=always  -d xuxueli/xxl-job-admin:2.3.0
```
