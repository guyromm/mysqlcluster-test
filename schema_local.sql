create database if not exists clusterdb; use clusterdb;

create table if not exists ndb_test (
       id int not null primary key,
       indexed_id varchar(32) not null, -- unique,
       field_4 varchar(4) not null,
       field_8 varchar(8) not null,
       field_12 varchar(12) not null,
       field_16 varchar(16) not null,
       field_20 varchar(20) not null,
       field_24 varchar(24) not null,
       field_28 varchar(28) not null,
       field_32 varchar(32) not null,
       field_36 varchar(36) not null,
       field_40 varchar(40) not null
       ) 
       engine=innodb;    
