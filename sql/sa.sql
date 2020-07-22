set names utf8;
use n9e_mon;
create table IF NOT EXISTS `sa`   (
  `id` bigint(20) unsigned not null AUTO_INCREMENT comment 'id',
  `sid` bigint(20) unsigned not null default 0 comment 'sid',
  `endpoint` varchar(255) not null default '' comment 'endpoint',
  `endpoint_alias` varchar(255) not null default '' comment 'endpoint alias',
  `hashid` varchar(128) not null default '' comment 'sid+counter hash',
  `uuid` varchar(128) not null default '0' comment '生成uuid用于标识此报警是否为同一条记录',
  `metric` varchar(128) not null default '' comment 'metric info',
  `alert_time` bigint(20) not null default 0 comment 'alter time',
  `recover_time` bigint(20) not null default 0 comment 'recover time',
  `time_interval` int(10) NOT NULL default 0  comment '报警持续时间',
  `effective` int(2) NOT NULL default 1  comment '0 无效 1 有效',
  `reason_info` varchar(128) not null default '' comment '当设置此条报警不计算时得原因',
  `user` varchar(32) not null default '' comment '设置reason info 得用户',
  `created` DATETIME not null default '1971-1-1 00:00:00' comment 'created',
  PRIMARY KEY (`id`),
  KEY `idx_id` (`id`),
  KEY `idx_hashid` (`hashid`)

) engine=innodb default charset=utf8 comment 'sa';

create table  if not exists `sa_saconfigmodel`   (
  `id` bigint(20) unsigned not null AUTO_INCREMENT comment 'id',
  `name` varchar(255) not null unique comment 'name',
  `stra` varchar(8192),
  `nid` bigint(20) not null default 0 comment 'alter time',
  `user` varchar(32) not null default '' comment '设置reason info 得用户',
  `create` DATETIME not null default '1971-1-1 00:00:00' comment 'created',
  PRIMARY KEY (`id`),
  KEY `idx_id` (`id`)


) engine=innodb default charset=utf8 comment 'sa_saconfigmodel';