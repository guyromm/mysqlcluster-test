#!/bin/bash
cd ~/mysqlcluster-test/
if [ ! -d ~/mysqlcluster-test/mysql-cluster-gpl-7.1.13-linux-x86_64-glibc23 ] ; then
    wget --continue -O mysqlcluster-7.1.13.tar.gz 'http://www.mysql.com/get/Downloads/MySQL-Cluster-7.1/mysql-cluster-gpl-7.1.13-linux-x86_64-glibc23.tar.gz/from/http://mysql.spd.co.il/'
    tar -zxvf mysqlcluster-7.1.13.tar.gz
    md5sum mysqlcluster-7.1.13.tar.gz
    fi
