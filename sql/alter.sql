set names utf8;
use n9e_uic;
ALTER TABLE User ADD COLUMN user_id int unsigned;

use n9e_mon;
ALTER TABLE sa ADD COLUMN sid int unsigned;
ALTER TABLE node_endpoint ADD COLUMN id int unsigned not null auto_increment, add primary key(id);
alter table stra modify  callback varchar(1024)  DEFAULT "" COMMENT 'callback url'
