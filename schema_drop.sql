use clusterdb;
DROP TABLE ndb_test;

 ALTER TABLESPACE ts_1     DROP DATAFILE 'data_1.dat'     ENGINE NDBCLUSTER;
 ALTER TABLESPACE ts_1     DROP DATAFILE 'data_2.dat'     ENGINE NDBCLUSTER;
 ALTER TABLESPACE ts_1     DROP DATAFILE 'data_3.dat'     ENGINE NDBCLUSTER;
 ALTER TABLESPACE ts_1     DROP DATAFILE 'data_4.dat'     ENGINE NDBCLUSTER;
 ALTER TABLESPACE ts_1     DROP DATAFILE 'data_5.dat'     ENGINE NDBCLUSTER;
 ALTER TABLESPACE ts_1     DROP DATAFILE 'data_6.dat'     ENGINE NDBCLUSTER;
 ALTER TABLESPACE ts_1     DROP DATAFILE 'data_7.dat'     ENGINE NDBCLUSTER;
 ALTER TABLESPACE ts_1     DROP DATAFILE 'data_8.dat'     ENGINE NDBCLUSTER;
 ALTER TABLESPACE ts_1     DROP DATAFILE 'data_9.dat'     ENGINE NDBCLUSTER;
 ALTER TABLESPACE ts_1     DROP DATAFILE 'data_10.dat'     ENGINE NDBCLUSTER;
 ALTER TABLESPACE ts_1     DROP DATAFILE 'data_11.dat'     ENGINE NDBCLUSTER;
 ALTER TABLESPACE ts_1     DROP DATAFILE 'data_12.dat'     ENGINE NDBCLUSTER;

 DROP TABLESPACE ts_1     ENGINE NDBCLUSTER;

 DROP LOGFILE GROUP lg_1     ENGINE NDBCLUSTER;