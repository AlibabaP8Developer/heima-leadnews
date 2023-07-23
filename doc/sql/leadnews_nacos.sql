CREATE DATABASE IF NOT EXISTS leadnews_nacos DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE leadnews_nacos;
SET NAMES utf8;

-- MySQL dump 10.13  Distrib 8.0.26, for Linux (x86_64)
--
-- Host: 139.198.181.54    Database: leadnews_nacos
-- ------------------------------------------------------
-- Server version	8.0.26

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `config_info`
--

DROP TABLE IF EXISTS `config_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `config_info` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'content',
  `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `src_user` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'source user',
  `src_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'source ip',
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '' COMMENT '租户字段',
  `c_desc` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `c_use` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `effect` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `type` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `c_schema` text CHARACTER SET utf8 COLLATE utf8_bin,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_configinfo_datagrouptenant` (`data_id`,`group_id`,`tenant_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=194 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='config_info';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config_info`
--

LOCK TABLES `config_info` WRITE;
/*!40000 ALTER TABLE `config_info` DISABLE KEYS */;
INSERT INTO `config_info` VALUES (1,'mp-config.properties','xc-group','#驼峰下划线转换\r\nmybatis-plus.global-config.db-column-underline = true\r\n#实体扫描，多个package用逗号或者分号分隔\r\nmybatis-plus.typeAliasesPackage = com.xuecheng.*.entity\r\n#字段策略 0:\"忽略判断\",1:\"非 NULL 判断\"),2:\"非空判断\"\r\nmybatis-plus.global-config.field-strategy=2\r\n#全局地开启或关闭配置文件中的所有映射器已经配置的任何缓存，开发时不需要开启。\r\nmybatis-plus.configuration.cache-enabled = false\r\n#映射文件mapper文件存储位置\r\nmybatis-plus.mapper-locations = classpath:com.xuecheng.*.mapper/*.xml\r\n#主键类型  0:\"数据库ID自增\", 1:\"用户输入ID\",2:\"全局唯一ID (数字类型唯一ID)\", 3:\"全局唯一ID UUID\";\r\nmybatis-plus.global-config.id-type = 0\r\n#刷新mapper 调试神器\r\nmybatis-plus.global-config.refresh-mapper = true','c4830681643505108185f52cbff96453','2022-08-31 13:31:52','2022-08-31 13:31:52',NULL,'192.168.101.1','','3adc3388-087e-4c90-a373-c5a6484752df',NULL,NULL,NULL,'properties',NULL),(7,'feign-config.properties','xc-group','# 开启 feign 的远程调用使用熔断\nfeign.sentinel.enabled = true\n# 配置请求GZIP压缩\nfeign.compression.request.enabled = false\n# 配置压缩数据大小的下限\nfeign.compression.request.min-request-size = 2048\n# 配置响应GZIP压缩\nfeign.compression.response.enabled = false\n# 配置压缩支持的MIME TYPE\nfeign.compression.request.mime-types[0] = text/xml\nfeign.compression.request.mime-types[1] = application/xml\nfeign.compression.request.mime-types[2] = application/json','2f3be5ae5f601d5b37e586607956770e','2022-08-31 13:31:52','2022-08-31 13:31:52',NULL,'192.168.101.1','','3adc3388-087e-4c90-a373-c5a6484752df',NULL,NULL,NULL,'properties',NULL),(8,'ribbon-config.properties','xc-group','#对当前实例的重试次数 default 0\r\nribbon.MaxAutoRetries = 1\r\n#设置连接超时时间 default 2000\r\nribbon.ConnectTimeout = 3000\r\n#对所有操作请求都进行重试 default false\r\nribbon.OkToRetryOnAllOperations = false\r\n#设置读取超时时间 default 5000\r\nribbon.ReadTimeout = 20000\r\n#切换实例的重试次数 default 1\r\nribbon.MaxAutoRetriesNextServer = 1','95976e0fbb744e2c148d1b9a214025b3','2022-08-31 13:31:52','2022-08-31 13:31:52',NULL,'192.168.101.1','','3adc3388-087e-4c90-a373-c5a6484752df',NULL,NULL,NULL,'properties',NULL),(9,'freemarker-config.properties','xc-group','#开启 freemarker 功能\r\nspring.freemarker.enabled = true\r\n#关闭模板缓存，方便测试\r\nspring.freemarker.cache = false\r\nspring.freemarker.settings.template_update_delay = 0\r\n#页面模板后缀名\r\nspring.freemarker.suffix = .ftl\r\nspring.freemarker.charset = UTF-8\r\n#页面模板位置(默认为 classpath:/templates/)\r\nspring.freemarker.template-loader-path = classpath:/templates/\r\n#关闭项目中的静态资源映射(static、resources文件夹下的资源)\r\nspring.resources.add-mappings = false','b922b2f76a55b5f1bb66bd0e86fd67da','2022-08-31 13:31:52','2022-08-31 13:31:52',NULL,'192.168.101.1','','3adc3388-087e-4c90-a373-c5a6484752df',NULL,NULL,NULL,'properties',NULL),(10,'rabbitmq-config.properties','xc-group','#rabbitmq 配置信息\nspring.rabbitmq.host = 192.168.101.65\nspring.rabbitmq.port = 5672\nspring.rabbitmq.username = guest\nspring.rabbitmq.password = guest\nspring.rabbitmq.password.virtual-host = /\n\n#correlated 异步回调，定义ConfirmCallback，MQ返回结果时会回调这个ConfirmCallback\nspring.rabbitmq.publisher-confirm-type = correlated\n#开启publish-return功能，同样是基于callback机制，需要定义ReturnCallback\nspring.rabbitmq.publisher-returns = true\n#定义消息路由失败时的策略。true，则调用ReturnCallback；false：则直接丢弃消息\nspring.rabbitmq.template.mandatory = true\n#出现异常时返回nack，消息回滚到mq；没有异常，返回ack\nspring.rabbitmq.listener.simple.acknowledge-mode = auto\n#开启消费者失败重试\nspring.rabbitmq.listener.simple.retry.enabled = true\n#初识的失败等待时长为1秒\nspring.rabbitmq.listener.simple.retry.initial-interval = 1000ms\n#失败的等待时长倍数，下次等待时长 = multiplier * last-interval\nspring.rabbitmq.listener.simple.retry.multiplier = 1\n#最大重试次数\nspring.rabbitmq.listener.simple.retry.max-attempts = 3\n# true无状态；false有状态。如果业务中包含事务，这里改为false\nspring.rabbitmq.listener.simple.retry.stateless=true\n\n\n#消息队列配置\n#消息同步交换机\nxc.mq.msgsync.exchange=xc.msgsync.direct\n#课程发布消息队列\nxc.mq.msgsync.queue.coursepub=xc.course.publish.queue\n#课程发布消息队列routingkey\nxc.mq.msgsync.queue.coursepub.key=xc.course.publish.queue\n#课程发布结果消息队列\nxc.mq.msgsync.queue.coursepubresult=xc.course.publish.result.queue\n#课程发布结果消息队列routingkey\nxc.mq.msgsync.queue.coursepubresult.key=xc.course.publish.result.queue','f7df4f6cf31e7401353c013820bb555c','2022-08-31 13:31:52','2022-09-01 02:57:24',NULL,'192.168.101.1','','3adc3388-087e-4c90-a373-c5a6484752df','','','','properties',''),(15,'uaa-gateway-server-dev.properties','xc-group','#srpingboot http 配置信息\r\nserver.servlet.context-path = /\r\nserver.port=63010','001a3d10fe3c491c0444f6dcdd6b35e8','2022-08-31 13:31:52','2022-08-31 13:31:52',NULL,'192.168.101.1','','3adc3388-087e-4c90-a373-c5a6484752df',NULL,NULL,NULL,'properties',NULL),(16,'uaa-service-dev.properties','xc-group','#srpingboot http 配置信息\nserver.servlet.context-path = /uaa\nserver.port=63020\n\nspring.datasource.url = jdbc:mysql://127.0.0.1:3306/xc2.0_uaa?userUnicode=true&useSSL=false&characterEncoding=utf8','bcaad64b545f0d673d52b52084270ff8','2022-08-31 13:31:52','2022-08-31 13:31:52',NULL,'192.168.101.1','','3adc3388-087e-4c90-a373-c5a6484752df',NULL,NULL,NULL,'properties',NULL),(20,'redis-config.properties','xc-group','# Redis数据库索引（默认为0）\nspring.redis.database=0\n# Redis服务器地址\nspring.redis.host=192.168.101.64\n# Redis服务器连接端口\nspring.redis.port=6379\n# Redis服务器连接密码（默认为空）\nspring.redis.password=itcast20220812\nspring.redis.lettuce.pool.max-active=20\nspring.redis.lettuce.pool.max-idle=10\nspring.redis.lettuce.pool.min-idle=0\nspring.redis.lettuce.pool.max-wait=-1\n# 连接池最大连接数（使用负值表示没有限制）\n#spring.redis.jedis.pool.max-active=20\n# 连接池最大阻塞等待时间（使用负值表示没有限制）\n#spring.redis.jedis.pool.max-wait=-1\n# 连接池中的最大空闲连接\n#spring.redis.jedis.pool.max-idle=10\n# 连接池中的最小空闲连接\n#spring.redis.jedis.pool.min-idle=0\n# 连接超时时间（毫秒）\nspring.redis.timeout=1000','179450e4e39ac7dcce283e3d80cb6d97','2022-08-31 13:31:52','2022-08-31 13:31:52',NULL,'192.168.101.1','','3adc3388-087e-4c90-a373-c5a6484752df',NULL,NULL,NULL,'properties',NULL),(21,'comment-service.properties','xc-group','#srpingboot http 配置信息\nserver.servlet.context-path = /comment\nserver.port=63120\n\nspring.datasource.url = jdbc:mysql://192.168.101.65:3306/xc2.0_comments?userUnicode=true&useSSL=false&characterEncoding=utf8','1e6275014671ea2db7d2bff629055f56','2022-08-31 13:31:52','2022-09-01 03:14:32',NULL,'192.168.101.1','','3adc3388-087e-4c90-a373-c5a6484752df','','','','properties',''),(88,'swagger-dev.yaml','xuecheng-plus-common','# swagger 文档配置\nswagger:\n  title: \"学成在线内容管理系统\"\n  description: \"内容系统管理系统对课程相关信息进行业务管理数据\"\n  base-package: com.xuecheng\n  enabled: true\n  version: 1.0.0\n\ntest_config:\n a: 1a\n b: 1b\n c: 1c\n d: 1d','9c0d3be98c5a9ff620445bd718ea10ad','2022-09-11 08:14:16','2022-09-11 08:49:11',NULL,'192.168.101.1','','dev','','','','yaml',''),(91,'logging-dev.yaml','xuecheng-plus-common','# 日志文件配置路径\nlogging:\n  config: classpath:log4j2-dev.xml\n  level:\n    org.springframework.cloud.gateway: trace','cf8b1af28beb25b242f97519c8f2c560','2022-09-11 08:22:12','2022-09-12 13:21:52',NULL,'192.168.101.1','','dev','','','','yaml',''),(121,'freemarker-config-dev.yaml','xuecheng-plus-common','spring:\r\n  freemarker:\r\n    enabled: true\r\n    cache: false   #关闭模板缓存，方便测试\r\n    settings:\r\n      template_update_delay: 0\r\n    suffix: .ftl   #页面模板后缀名\r\n    charset: UTF-8\r\n    template-loader-path: classpath:/templates/   #页面模板位置(默认为 classpath:/templates/)\r\n    resources:\r\n      add-mappings: false   #关闭项目中的静态资源映射(static、resources文件夹下的资源)\r\n    ','8e97657f299e4a1a6158e8ebf4894e51','2022-09-15 11:18:37','2022-09-15 11:18:37',NULL,'192.168.101.1','','dev',NULL,NULL,NULL,'yaml',NULL),(134,'rabbitmq-dev.yaml','xuecheng-plus-common','spring:\n  rabbitmq:\n    host: 192.168.101.65\n    port: 5672\n    username: guest\n    password: guest\n    virtual-host: /\n    publisher-confirm-type: correlated #correlated 异步回调，定义ConfirmCallback，MQ返回结果时会回调这个ConfirmCallback\n    publisher-returns: false #开启publish-return功能，同样是基于callback机制，需要定义ReturnCallback\n    template:\n      mandatory: false #定义消息路由失败时的策略。true，则调用ReturnCallback；false：则直接丢弃消息\n    listener:\n      simple:\n        prefetch: 1  #每次只能获取一条消息，处理完成才能获取下一个消息\n        acknowledge-mode: none #auto:出现异常时返回unack，消息回滚到mq；没有异常，返回ack ,manual:手动控制,none:丢弃消息，不回滚到mq\n        retry:\n          enabled: true #开启消费者失败重试\n          initial-interval: 1000ms #初识的失败等待时长为1秒\n          multiplier: 1 #失败的等待时长倍数，下次等待时长 = multiplier * last-interval\n          max-attempts: 3 #最大重试次数\n          stateless: true #true无状态；false有状态。如果业务中包含事务，这里改为false','9a2acc646d17166ee29989751faceaea','2022-09-20 02:42:44','2022-09-20 05:26:56',NULL,'192.168.101.1','','dev','','','','yaml',''),(145,'feign-dev.yaml','xuecheng-plus-common','feign:\n  client:\n    config:\n      default: # default全局的配置\n        loggerLevel: BASIC # 日志级别，BASIC就是基本的请求和响应信息\n  hystrix:\n    enabled: true\n  circuitbreaker:\n    enabled: true\n  httpclient:\n    enabled: true # 开启feign对HttpClient的支持\n    max-connections: 200 # 最大的连接数\n    max-connections-per-route: 50 # 每个路径的最大连接数\n','2287b4dcf1db4d243a11c74f7a2b6aff','2022-09-20 11:59:29','2022-10-03 01:07:11',NULL,'192.168.101.1','','dev','','','','yaml',''),(184,'leadnews-user-dev.yaml','leadnews-group','spring:\n  datasource:\n    driver-class-name: com.mysql.jdbc.Driver\n    url: jdbc:mysql://139.198.181.54:3306/leadnews_user?useUnicode=true&characterEncoding=UTF-8&serverTimezone=UTC\n    username: root\n    password: Dcp#7ujm\n  redis:\n    host: 139.198.181.54\n    password: Dcp#7ujm\n    port: 6379\n# 设置Mapper接口所对应的XML文件位置，如果你在Mapper接口中有自定义方法，需要进行该配置\nmybatis-plus:\n  mapper-locations: classpath*:mapper/*.xml\n  # 设置别名包扫描路径，通过该属性可以给包中的类注册别名\n  type-aliases-package: com.heima.model.user.pojos\n\nswagger:\n  title: \"黑马头条API文档\"\n  description: \"黑马头条API文档用户管理进行业务管理数据\"\n  base-package: com.heima.user\n  enabled: true\n  version: 1.0.0','bb511739e7bf5c6ecb511262d1cda46f','2023-07-22 13:00:21','2023-07-22 13:00:43','nacos','127.0.0.1','','dev','','','','yaml',''),(186,'leadnews-app-gateway-dev.yaml','leadnews-group','spring:\n  cloud:\n    gateway:\n      globalcors:\n        add-to-simple-url-handler-mapping: true\n        corsConfigurations:\n          \'[/**]\':\n            allowedHeaders: \"*\"\n            allowedOrigins: \"*\"\n            allowedMethods:\n              - GET\n              - POST\n              - DELETE\n              - PUT\n              - OPTION\n      routes:\n        # 平台管理\n        - id: leadnews-user\n          uri: lb://leadnews-user\n          predicates:\n            - Path=/user/**\n          filters:\n            - StripPrefix= 1\n        # 文章微服务\n        - id: leadnews-article\n          uri: lb://leadnews-article\n          predicates:\n            - Path=/article/**\n          filters:\n            - StripPrefix= 1','20531d47b3c9459ed095a48783e47801','2023-07-22 13:02:26','2023-07-22 14:22:44','nacos','127.0.0.1','','dev','','','','yaml',''),(187,'leadnews-article-dev.yaml','leadnews-group','spring:\n  datasource:\n    driver-class-name: com.mysql.jdbc.Driver\n    url: jdbc:mysql://139.198.181.54:3306/leadnews_article?useUnicode=true&characterEncoding=UTF-8&serverTimezone=UTC\n    username: root\n    password: Dcp#7ujm\n  redis:\n    host: 139.198.181.54\n    password: Dcp#7ujm\n    port: 6379\n# 设置Mapper接口所对应的XML文件位置，如果你在Mapper接口中有自定义方法，需要进行该配置\nmybatis-plus:\n  mapper-locations: classpath*:mapper/*.xml\n  # 设置别名包扫描路径，通过该属性可以给包中的类注册别名\n  type-aliases-package: com.heima.model.user.pojos\n\nswagger:\n  title: \"黑马头条API文档\"\n  description: \"黑马头条API文档文章管理进行业务管理数据\"\n  base-package: com.heima.article\n  enabled: true\n  version: 1.0.0','aada261080fc9c47894dd0a0893ac056','2023-07-22 13:47:45','2023-07-22 13:49:05','nacos','127.0.0.1','','dev','','','','yaml',''),(190,'leadnews-wemedia-dev.yaml','leadnews-group','spring:\n  datasource:\n    driver-class-name: com.mysql.jdbc.Driver\n    url: jdbc:mysql://139.198.181.54:3306/leadnews_wemedia?useUnicode=true&characterEncoding=UTF-8&serverTimezone=UTC\n    username: root\n    password: Dcp#7ujm\n  redis:\n    host: 139.198.181.54\n    password: Dcp#7ujm\n    port: 6379\n# 设置Mapper接口所对应的XML文件位置，如果你在Mapper接口中有自定义方法，需要进行该配置\nmybatis-plus:\n  mapper-locations: classpath*:mapper/*.xml\n  # 设置别名包扫描路径，通过该属性可以给包中的类注册别名\n  type-aliases-package: com.heima.model.user.pojos\n\nswagger:\n  title: \"黑马头条API文档\"\n  description: \"黑马头条API文档自媒体管理进行业务管理数据\"\n  base-package: com.heima.article\n  enabled: true\n  version: 1.0.0\n\nminio:\n  accessKey: minioadmin\n  secretKey: minioadmin\n  bucket: testbucket\n  endpoint: http://139.198.181.54:9000\n  readPath: http://139.198.181.54:9000','d27d9bd7cad713ca92719076b479dd33','2023-07-22 16:18:46','2023-07-23 03:22:25','nacos','127.0.0.1','','dev','','','','yaml',''),(192,'leadnews-wemedia-gateway-dev.yaml','leadnews-group','spring:\n  cloud:\n    gateway:\n      globalcors:\n        cors-configurations:\n          \'[/**]\': # 匹配所有请求\n            allowedOrigins: \"*\" #跨域处理 允许所有的域\n            allowedMethods: # 支持的方法\n              - GET\n              - POST\n              - PUT\n              - DELETE\n      routes:\n        # 平台管理\n        - id: leadnews-wemedia\n          uri: lb://leadnews-wemedia\n          predicates:\n            - Path=/wemedia/**\n          filters:\n            - StripPrefix= 1','962f3b419875f2a7b0a2ecdbb0b223c9','2023-07-22 16:42:49','2023-07-22 16:42:49',NULL,'127.0.0.1','','dev',NULL,NULL,NULL,'yaml',NULL);
/*!40000 ALTER TABLE `config_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `config_info_aggr`
--

DROP TABLE IF EXISTS `config_info_aggr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `config_info_aggr` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
  `datum_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'datum_id',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '内容',
  `gmt_modified` datetime NOT NULL COMMENT '修改时间',
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '' COMMENT '租户字段',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_configinfoaggr_datagrouptenantdatum` (`data_id`,`group_id`,`tenant_id`,`datum_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='增加租户字段';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config_info_aggr`
--

LOCK TABLES `config_info_aggr` WRITE;
/*!40000 ALTER TABLE `config_info_aggr` DISABLE KEYS */;
/*!40000 ALTER TABLE `config_info_aggr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `config_info_beta`
--

DROP TABLE IF EXISTS `config_info_beta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `config_info_beta` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'app_name',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'content',
  `beta_ips` varchar(1024) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'betaIps',
  `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `src_user` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'source user',
  `src_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'source ip',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '' COMMENT '租户字段',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_configinfobeta_datagrouptenant` (`data_id`,`group_id`,`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='config_info_beta';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config_info_beta`
--

LOCK TABLES `config_info_beta` WRITE;
/*!40000 ALTER TABLE `config_info_beta` DISABLE KEYS */;
/*!40000 ALTER TABLE `config_info_beta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `config_info_tag`
--

DROP TABLE IF EXISTS `config_info_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `config_info_tag` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '' COMMENT 'tenant_id',
  `tag_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'tag_id',
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'app_name',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'content',
  `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `src_user` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'source user',
  `src_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'source ip',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_configinfotag_datagrouptenanttag` (`data_id`,`group_id`,`tenant_id`,`tag_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='config_info_tag';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config_info_tag`
--

LOCK TABLES `config_info_tag` WRITE;
/*!40000 ALTER TABLE `config_info_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `config_info_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `config_tags_relation`
--

DROP TABLE IF EXISTS `config_tags_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `config_tags_relation` (
  `id` bigint NOT NULL COMMENT 'id',
  `tag_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'tag_name',
  `tag_type` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'tag_type',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '' COMMENT 'tenant_id',
  `nid` bigint NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`nid`) USING BTREE,
  UNIQUE KEY `uk_configtagrelation_configidtag` (`id`,`tag_name`,`tag_type`) USING BTREE,
  KEY `idx_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='config_tag_relation';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config_tags_relation`
--

LOCK TABLES `config_tags_relation` WRITE;
/*!40000 ALTER TABLE `config_tags_relation` DISABLE KEYS */;
/*!40000 ALTER TABLE `config_tags_relation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_capacity`
--

DROP TABLE IF EXISTS `group_capacity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `group_capacity` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'Group ID，空字符表示整个集群',
  `quota` int unsigned NOT NULL DEFAULT '0' COMMENT '配额，0表示使用默认值',
  `usage` int unsigned NOT NULL DEFAULT '0' COMMENT '使用量',
  `max_size` int unsigned NOT NULL DEFAULT '0' COMMENT '单个配置大小上限，单位为字节，0表示使用默认值',
  `max_aggr_count` int unsigned NOT NULL DEFAULT '0' COMMENT '聚合子配置最大个数，，0表示使用默认值',
  `max_aggr_size` int unsigned NOT NULL DEFAULT '0' COMMENT '单个聚合数据的子配置大小上限，单位为字节，0表示使用默认值',
  `max_history_count` int unsigned NOT NULL DEFAULT '0' COMMENT '最大变更历史数量',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_group_id` (`group_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='集群、各Group容量信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_capacity`
--

LOCK TABLES `group_capacity` WRITE;
/*!40000 ALTER TABLE `group_capacity` DISABLE KEYS */;
/*!40000 ALTER TABLE `group_capacity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `his_config_info`
--

DROP TABLE IF EXISTS `his_config_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `his_config_info` (
  `id` bigint unsigned NOT NULL,
  `nid` bigint unsigned NOT NULL AUTO_INCREMENT,
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'app_name',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `src_user` text CHARACTER SET utf8 COLLATE utf8_bin,
  `src_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `op_type` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '' COMMENT '租户字段',
  PRIMARY KEY (`nid`) USING BTREE,
  KEY `idx_gmt_create` (`gmt_create`) USING BTREE,
  KEY `idx_gmt_modified` (`gmt_modified`) USING BTREE,
  KEY `idx_did` (`data_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=214 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='多租户改造';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `his_config_info`
--

LOCK TABLES `his_config_info` WRITE;
/*!40000 ALTER TABLE `his_config_info` DISABLE KEYS */;
INSERT INTO `his_config_info` VALUES (81,188,'system-service-dev.yaml','xuecheng-plus-project','','spring:\n  datasource:\n    driver-class-name: com.mysql.cj.jdbc.Driver\n    url: jdbc:mysql://192.168.101.65:3306/xcplus_system?serverTimezone=UTC&userUnicode=true&useSSL=false&\n    username: root\n    password: mysql\n\n','7c166a3388dc2a93e3e6a9d2444175bc','2023-07-22 11:36:12','2023-07-22 03:36:12',NULL,'127.0.0.1','D','dev'),(82,189,'system-api-dev.yaml','xuecheng-plus-project','','server:\n  servlet:\n    context-path: /system\n  port: 63110\n\ntestconfig:\n a: 1aa','08bc232c5164645dae080a8e0574cf27','2023-07-22 11:36:18','2023-07-22 03:36:17',NULL,'127.0.0.1','D','dev'),(0,190,'leadnews-user-dev.yml','DEFAULT_GROUP','','spring:\n  datasource:\n    driver-class-name: com.mysql.jdbc.Driver\n    url: jdbc:mysql://139.198.181.54:3306/leadnews_user?useUnicode=true&characterEncoding=UTF-8&serverTimezone=UTC\n    username: root\n    password: Dcp#7ujm\n# 设置Mapper接口所对应的XML文件位置，如果你在Mapper接口中有自定义方法，需要进行该配置\nmybatis-plus:\n  mapper-locations: classpath*:mapper/*.xml\n  # 设置别名包扫描路径，通过该属性可以给包中的类注册别名\n  type-aliases-package: com.heima.model.user.pojos','d798ba27650ff797e17442553ccc941e','2023-07-22 11:41:15','2023-07-22 03:41:15',NULL,'127.0.0.1','I','dev'),(175,191,'leadnews-user-dev.yml','DEFAULT_GROUP','','spring:\n  datasource:\n    driver-class-name: com.mysql.jdbc.Driver\n    url: jdbc:mysql://139.198.181.54:3306/leadnews_user?useUnicode=true&characterEncoding=UTF-8&serverTimezone=UTC\n    username: root\n    password: Dcp#7ujm\n# 设置Mapper接口所对应的XML文件位置，如果你在Mapper接口中有自定义方法，需要进行该配置\nmybatis-plus:\n  mapper-locations: classpath*:mapper/*.xml\n  # 设置别名包扫描路径，通过该属性可以给包中的类注册别名\n  type-aliases-package: com.heima.model.user.pojos','d798ba27650ff797e17442553ccc941e','2023-07-22 11:55:41','2023-07-22 03:55:40',NULL,'127.0.0.1','D','dev'),(0,192,'leadnews-user-dev.yaml','leadnews-user-group','','spring:\n  datasource:\n    driver-class-name: com.mysql.jdbc.Driver\n    url: jdbc:mysql://139.198.181.54:3306/leadnews_user?useUnicode=true&characterEncoding=UTF-8&serverTimezone=UTC\n    username: root\n    password: Dcp#7ujm\n# 设置Mapper接口所对应的XML文件位置，如果你在Mapper接口中有自定义方法，需要进行该配置\nmybatis-plus:\n  mapper-locations: classpath*:mapper/*.xml\n  # 设置别名包扫描路径，通过该属性可以给包中的类注册别名\n  type-aliases-package: com.heima.model.user.pojos','d798ba27650ff797e17442553ccc941e','2023-07-22 11:56:38','2023-07-22 03:56:38',NULL,'127.0.0.1','I','dev'),(176,193,'leadnews-user-dev.yaml','leadnews-user-group','','spring:\n  datasource:\n    driver-class-name: com.mysql.jdbc.Driver\n    url: jdbc:mysql://139.198.181.54:3306/leadnews_user?useUnicode=true&characterEncoding=UTF-8&serverTimezone=UTC\n    username: root\n    password: Dcp#7ujm\n# 设置Mapper接口所对应的XML文件位置，如果你在Mapper接口中有自定义方法，需要进行该配置\nmybatis-plus:\n  mapper-locations: classpath*:mapper/*.xml\n  # 设置别名包扫描路径，通过该属性可以给包中的类注册别名\n  type-aliases-package: com.heima.model.user.pojos','d798ba27650ff797e17442553ccc941e','2023-07-22 16:24:41','2023-07-22 08:24:40','nacos','127.0.0.1','U','dev'),(176,194,'leadnews-user-dev.yaml','leadnews-user-group','','spring:\n  datasource:\n    driver-class-name: com.mysql.jdbc.Driver\n    url: jdbc:mysql://139.198.181.54:3306/leadnews_user?useUnicode=true&characterEncoding=UTF-8&serverTimezone=UTC\n    username: root\n    password: Dcp#7ujm\n  redis:\n    host: 139.198.181.54\n    password: Dcp#7ujm\n    port: 6379\n# 设置Mapper接口所对应的XML文件位置，如果你在Mapper接口中有自定义方法，需要进行该配置\nmybatis-plus:\n  mapper-locations: classpath*:mapper/*.xml\n  # 设置别名包扫描路径，通过该属性可以给包中的类注册别名\n  type-aliases-package: com.heima.model.user.pojos','2fddccd288c41f549b4fbfd71e3e97d9','2023-07-22 18:15:06','2023-07-22 10:15:06','nacos','127.0.0.1','U','dev'),(0,195,'leadnews-app-gateway.yaml','leadnews-gateway-group','','spring:\n  cloud:\n    gateway:\n      globalcors:\n        add-to-simple-url-handler-mapping: true\n        corsConfigurations:\n          \'[/**]\':\n            allowedHeaders: \"*\"\n            allowedOrigins: \"*\"\n            allowedMethods:\n              - GET\n              - POST\n              - DELETE\n              - PUT\n              - OPTION\n      routes:\n        # 平台管理\n        - id: user\n          uri: lb://leadnews-user\n          predicates:\n            - Path=/user/**\n          filters:\n            - StripPrefix= 1','8ce0e5e580fb26d5cf43043a4d3c075a','2023-07-22 20:17:20','2023-07-22 12:17:21',NULL,'127.0.0.1','I','dev'),(179,196,'leadnews-app-gateway.yaml','leadnews-gateway-group','','spring:\n  cloud:\n    gateway:\n      globalcors:\n        add-to-simple-url-handler-mapping: true\n        corsConfigurations:\n          \'[/**]\':\n            allowedHeaders: \"*\"\n            allowedOrigins: \"*\"\n            allowedMethods:\n              - GET\n              - POST\n              - DELETE\n              - PUT\n              - OPTION\n      routes:\n        # 平台管理\n        - id: user\n          uri: lb://leadnews-user\n          predicates:\n            - Path=/user/**\n          filters:\n            - StripPrefix= 1','8ce0e5e580fb26d5cf43043a4d3c075a','2023-07-22 20:18:03','2023-07-22 12:18:03',NULL,'127.0.0.1','D','dev'),(0,197,'leadnews-app-gateway-dev.yaml','leadnews-gateway-group','','spring:\n  cloud:\n    gateway:\n      globalcors:\n        add-to-simple-url-handler-mapping: true\n        corsConfigurations:\n          \'[/**]\':\n            allowedHeaders: \"*\"\n            allowedOrigins: \"*\"\n            allowedMethods:\n              - GET\n              - POST\n              - DELETE\n              - PUT\n              - OPTION\n      routes:\n        # 平台管理\n        - id: user\n          uri: lb://leadnews-user\n          predicates:\n            - Path=/user/**\n          filters:\n            - StripPrefix= 1','8ce0e5e580fb26d5cf43043a4d3c075a','2023-07-22 20:18:50','2023-07-22 12:18:50',NULL,'127.0.0.1','I','dev'),(180,198,'leadnews-app-gateway-dev.yaml','leadnews-gateway-group','','spring:\n  cloud:\n    gateway:\n      globalcors:\n        add-to-simple-url-handler-mapping: true\n        corsConfigurations:\n          \'[/**]\':\n            allowedHeaders: \"*\"\n            allowedOrigins: \"*\"\n            allowedMethods:\n              - GET\n              - POST\n              - DELETE\n              - PUT\n              - OPTION\n      routes:\n        # 平台管理\n        - id: user\n          uri: lb://leadnews-user\n          predicates:\n            - Path=/user/**\n          filters:\n            - StripPrefix= 1','8ce0e5e580fb26d5cf43043a4d3c075a','2023-07-22 20:35:47','2023-07-22 12:35:46','nacos','127.0.0.1','U','dev'),(0,199,'leadnews-user-dev.yml','leadnews-group','','1','c4ca4238a0b923820dcc509a6f75849b','2023-07-22 20:59:16','2023-07-22 12:59:16',NULL,'127.0.0.1','I','dev'),(182,200,'leadnews-user-dev.yml','leadnews-group','','1','c4ca4238a0b923820dcc509a6f75849b','2023-07-22 20:59:40','2023-07-22 12:59:40','nacos','127.0.0.1','U','dev'),(176,201,'leadnews-user-dev.yaml','leadnews-user-group','','spring:\n  datasource:\n    driver-class-name: com.mysql.jdbc.Driver\n    url: jdbc:mysql://139.198.181.54:3306/leadnews_user?useUnicode=true&characterEncoding=UTF-8&serverTimezone=UTC\n    username: root\n    password: Dcp#7ujm\n  redis:\n    host: 139.198.181.54\n    password: Dcp#7ujm\n    port: 6379\n# 设置Mapper接口所对应的XML文件位置，如果你在Mapper接口中有自定义方法，需要进行该配置\nmybatis-plus:\n  mapper-locations: classpath*:mapper/*.xml\n  # 设置别名包扫描路径，通过该属性可以给包中的类注册别名\n  type-aliases-package: com.heima.model.user.pojos\n\nswagger:\n  title: \"黑马头条API文档\"\n  description: \"黑马头条API文档用户管理进行业务管理数据\"\n  base-package: com.heima.user\n  enabled: true\n  version: 1.0.0','bb511739e7bf5c6ecb511262d1cda46f','2023-07-22 20:59:53','2023-07-22 12:59:53',NULL,'127.0.0.1','D','dev'),(0,202,'leadnews-user-dev.yaml','leadnews-group','','1','c4ca4238a0b923820dcc509a6f75849b','2023-07-22 21:00:21','2023-07-22 13:00:21',NULL,'127.0.0.1','I','dev'),(184,203,'leadnews-user-dev.yaml','leadnews-group','','1','c4ca4238a0b923820dcc509a6f75849b','2023-07-22 21:00:43','2023-07-22 13:00:43','nacos','127.0.0.1','U','dev'),(182,204,'leadnews-user-dev.yml','leadnews-group','','spring:\n  datasource:\n    driver-class-name: com.mysql.jdbc.Driver\n    url: jdbc:mysql://139.198.181.54:3306/leadnews_user?useUnicode=true&characterEncoding=UTF-8&serverTimezone=UTC\n    username: root\n    password: Dcp#7ujm\n  redis:\n    host: 139.198.181.54\n    password: Dcp#7ujm\n    port: 6379\n# 设置Mapper接口所对应的XML文件位置，如果你在Mapper接口中有自定义方法，需要进行该配置\nmybatis-plus:\n  mapper-locations: classpath*:mapper/*.xml\n  # 设置别名包扫描路径，通过该属性可以给包中的类注册别名\n  type-aliases-package: com.heima.model.user.pojos\n\nswagger:\n  title: \"黑马头条API文档\"\n  description: \"黑马头条API文档用户管理进行业务管理数据\"\n  base-package: com.heima.user\n  enabled: true\n  version: 1.0.0','bb511739e7bf5c6ecb511262d1cda46f','2023-07-22 21:00:53','2023-07-22 13:00:53',NULL,'127.0.0.1','D','dev'),(180,205,'leadnews-app-gateway-dev.yaml','leadnews-gateway-group','','spring:\n  cloud:\n    gateway:\n      globalcors:\n        add-to-simple-url-handler-mapping: true\n        corsConfigurations:\n          \'[/**]\':\n            allowedHeaders: \"*\"\n            allowedOrigins: \"*\"\n            allowedMethods:\n              - GET\n              - POST\n              - DELETE\n              - PUT\n              - OPTION\n      routes:\n        # 平台管理\n        - id: leadnews-user\n          uri: lb://leadnews-user\n          predicates:\n            - Path=/user/**\n          filters:\n            - StripPrefix= 1','97ab644cc5d1539296476de14ad222e3','2023-07-22 21:01:41','2023-07-22 13:01:41',NULL,'127.0.0.1','D','dev'),(0,206,'leadnews-app-gateway-dev.yaml','leadnews-group','','spring:\n  cloud:\n    gateway:\n      globalcors:\n        add-to-simple-url-handler-mapping: true\n        corsConfigurations:\n          \'[/**]\':\n            allowedHeaders: \"*\"\n            allowedOrigins: \"*\"\n            allowedMethods:\n              - GET\n              - POST\n              - DELETE\n              - PUT\n              - OPTION\n      routes:\n        # 平台管理\n        - id: leadnews-user\n          uri: lb://leadnews-user\n          predicates:\n            - Path=/user/**\n          filters:\n            - StripPrefix= 1','97ab644cc5d1539296476de14ad222e3','2023-07-22 21:02:26','2023-07-22 13:02:26',NULL,'127.0.0.1','I','dev'),(0,207,'leadnews-article-dev.yaml','leadnews-group','','1','c4ca4238a0b923820dcc509a6f75849b','2023-07-22 21:47:45','2023-07-22 13:47:45',NULL,'127.0.0.1','I','dev'),(187,208,'leadnews-article-dev.yaml','leadnews-group','','1','c4ca4238a0b923820dcc509a6f75849b','2023-07-22 21:49:06','2023-07-22 13:49:05','nacos','127.0.0.1','U','dev'),(186,209,'leadnews-app-gateway-dev.yaml','leadnews-group','','spring:\n  cloud:\n    gateway:\n      globalcors:\n        add-to-simple-url-handler-mapping: true\n        corsConfigurations:\n          \'[/**]\':\n            allowedHeaders: \"*\"\n            allowedOrigins: \"*\"\n            allowedMethods:\n              - GET\n              - POST\n              - DELETE\n              - PUT\n              - OPTION\n      routes:\n        # 平台管理\n        - id: leadnews-user\n          uri: lb://leadnews-user\n          predicates:\n            - Path=/user/**\n          filters:\n            - StripPrefix= 1','97ab644cc5d1539296476de14ad222e3','2023-07-22 22:22:44','2023-07-22 14:22:44','nacos','127.0.0.1','U','dev'),(0,210,'leadnews-wemedia-dev.yaml','leadnews-group','','1','c4ca4238a0b923820dcc509a6f75849b','2023-07-23 00:18:46','2023-07-22 16:18:46',NULL,'127.0.0.1','I','dev'),(190,211,'leadnews-wemedia-dev.yaml','leadnews-group','','1','c4ca4238a0b923820dcc509a6f75849b','2023-07-23 00:19:56','2023-07-22 16:19:56','nacos','127.0.0.1','U','dev'),(0,212,'leadnews-wemedia-gateway-dev.yaml','leadnews-group','','spring:\n  cloud:\n    gateway:\n      globalcors:\n        cors-configurations:\n          \'[/**]\': # 匹配所有请求\n            allowedOrigins: \"*\" #跨域处理 允许所有的域\n            allowedMethods: # 支持的方法\n              - GET\n              - POST\n              - PUT\n              - DELETE\n      routes:\n        # 平台管理\n        - id: leadnews-wemedia\n          uri: lb://leadnews-wemedia\n          predicates:\n            - Path=/wemedia/**\n          filters:\n            - StripPrefix= 1','962f3b419875f2a7b0a2ecdbb0b223c9','2023-07-23 00:42:49','2023-07-22 16:42:49',NULL,'127.0.0.1','I','dev'),(190,213,'leadnews-wemedia-dev.yaml','leadnews-group','','spring:\n  datasource:\n    driver-class-name: com.mysql.jdbc.Driver\n    url: jdbc:mysql://139.198.181.54:3306/leadnews_wemedia?useUnicode=true&characterEncoding=UTF-8&serverTimezone=UTC\n    username: root\n    password: Dcp#7ujm\n  redis:\n    host: 139.198.181.54\n    password: Dcp#7ujm\n    port: 6379\n# 设置Mapper接口所对应的XML文件位置，如果你在Mapper接口中有自定义方法，需要进行该配置\nmybatis-plus:\n  mapper-locations: classpath*:mapper/*.xml\n  # 设置别名包扫描路径，通过该属性可以给包中的类注册别名\n  type-aliases-package: com.heima.model.user.pojos\n\nswagger:\n  title: \"黑马头条API文档\"\n  description: \"黑马头条API文档自媒体管理进行业务管理数据\"\n  base-package: com.heima.article\n  enabled: true\n  version: 1.0.0','72970ac9d6a8e8c11a3b66fa9b3c2937','2023-07-23 11:22:25','2023-07-23 03:22:25','nacos','127.0.0.1','U','dev');
/*!40000 ALTER TABLE `his_config_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permissions` (
  `role` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `resource` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `action` varchar(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  UNIQUE KEY `uk_role_permission` (`role`,`resource`,`action`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `username` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `role` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  UNIQUE KEY `idx_user_role` (`username`,`role`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES ('nacos','ROLE_ADMIN');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tenant_capacity`
--

DROP TABLE IF EXISTS `tenant_capacity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tenant_capacity` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'Tenant ID',
  `quota` int unsigned NOT NULL DEFAULT '0' COMMENT '配额，0表示使用默认值',
  `usage` int unsigned NOT NULL DEFAULT '0' COMMENT '使用量',
  `max_size` int unsigned NOT NULL DEFAULT '0' COMMENT '单个配置大小上限，单位为字节，0表示使用默认值',
  `max_aggr_count` int unsigned NOT NULL DEFAULT '0' COMMENT '聚合子配置最大个数',
  `max_aggr_size` int unsigned NOT NULL DEFAULT '0' COMMENT '单个聚合数据的子配置大小上限，单位为字节，0表示使用默认值',
  `max_history_count` int unsigned NOT NULL DEFAULT '0' COMMENT '最大变更历史数量',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='租户容量信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tenant_capacity`
--

LOCK TABLES `tenant_capacity` WRITE;
/*!40000 ALTER TABLE `tenant_capacity` DISABLE KEYS */;
/*!40000 ALTER TABLE `tenant_capacity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tenant_info`
--

DROP TABLE IF EXISTS `tenant_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tenant_info` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `kp` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'kp',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '' COMMENT 'tenant_id',
  `tenant_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '' COMMENT 'tenant_name',
  `tenant_desc` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'tenant_desc',
  `create_source` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'create_source',
  `gmt_create` bigint NOT NULL COMMENT '创建时间',
  `gmt_modified` bigint NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_tenant_info_kptenantid` (`kp`,`tenant_id`) USING BTREE,
  KEY `idx_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='tenant_info';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tenant_info`
--

LOCK TABLES `tenant_info` WRITE;
/*!40000 ALTER TABLE `tenant_info` DISABLE KEYS */;
INSERT INTO `tenant_info` VALUES (3,'1','dev','开发环境','开发环境','nacos',1662865995686,1662865995686),(4,'1','test','测试环境','测试环境','nacos',1662867234159,1662867234159),(5,'1','prod','生产环境','生产环境','nacos',1662868015781,1662868015781);
/*!40000 ALTER TABLE `tenant_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `username` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `password` varchar(500) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  PRIMARY KEY (`username`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('nacos','$2a$10$EuWPZHzz32dJN7jexM34MOeYirDdFAZm2kuWj7VEOJhhZkDrxfvUu',1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-07-23 13:06:50
