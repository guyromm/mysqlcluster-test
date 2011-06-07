create table ndb_test (
       id int not null primary key,
       indexed_id varchar(16) not null unique,
       field_1 varchar(4) not null,
       field_2 varchar(8) not null,
       field_3 varchar(12) not null,
       field_4 varchar(16) not null,
       field_5 varchar(20) not null,
       field_6 varchar(24) not null,
       field_7 varchar(28) not null,
       field_8 varchar(32) not null,
       field_9 varchar(36) not null,

       ) 
       
       engine=ndbcluster;