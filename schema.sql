create database if not exists clusterdb; use clusterdb;

CREATE LOGFILE GROUP lg_1
    ADD UNDOFILE 'undo_1.log'
    INITIAL_SIZE 16M
    UNDO_BUFFER_SIZE 2M
    ENGINE NDBCLUSTER;

ALTER LOGFILE GROUP lg_1    ADD UNDOFILE 'undo_2.log'    INITIAL_SIZE 12M    ENGINE NDBCLUSTER;
ALTER LOGFILE GROUP lg_1    ADD UNDOFILE 'undo_3.log'    INITIAL_SIZE 12M    ENGINE NDBCLUSTER;
ALTER LOGFILE GROUP lg_1    ADD UNDOFILE 'undo_4.log'    INITIAL_SIZE 12M    ENGINE NDBCLUSTER;
ALTER LOGFILE GROUP lg_1    ADD UNDOFILE 'undo_5.log'    INITIAL_SIZE 12M    ENGINE NDBCLUSTER;
ALTER LOGFILE GROUP lg_1    ADD UNDOFILE 'undo_6.log'    INITIAL_SIZE 12M    ENGINE NDBCLUSTER;
ALTER LOGFILE GROUP lg_1    ADD UNDOFILE 'undo_7.log'    INITIAL_SIZE 12M    ENGINE NDBCLUSTER;
ALTER LOGFILE GROUP lg_1    ADD UNDOFILE 'undo_8.log'    INITIAL_SIZE 12M    ENGINE NDBCLUSTER;
ALTER LOGFILE GROUP lg_1    ADD UNDOFILE 'undo_9.log'    INITIAL_SIZE 12M    ENGINE NDBCLUSTER;
ALTER LOGFILE GROUP lg_1    ADD UNDOFILE 'undo_10.log'    INITIAL_SIZE 12M    ENGINE NDBCLUSTER;


CREATE TABLESPACE ts_1
    ADD DATAFILE 'data_1.dat'
    USE LOGFILE GROUP lg_1
    INITIAL_SIZE 32M
    ENGINE NDBCLUSTER;

alter tablespace ts_1 add datafile 'data_2.dat' initial_size 48m engine ndbcluster;

create table if not exists ndb_test (
       id int not null primary key,
       indexed_id varchar(32) not null unique,
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
       TABLESPACE ts_1 STORAGE DISK
       engine=ndbcluster;    
