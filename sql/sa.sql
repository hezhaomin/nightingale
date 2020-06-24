set names utf8;
use n9e_mon;
create table `sa` (
  `id` bigint(20) unsigned not null AUTO_INCREMENT comment 'id',
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