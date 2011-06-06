#!/bin/bash
cd ~/mysqlcluster-test/
wget --continue -O mysqlcluster-7.1.13.tar.gz 'http://www.mysql.com/get/Downloads/MySQL-Cluster-7.1/mysql-cluster-gpl-7.1.13-linux-x86_64-glibc23.tar.gz/from/http://mysql.spd.co.il/'
md5sum mysqlcluster-7.1.13.tar.gz
if [ ! -d ~/mysqlcluster-test/mysql-cluster-gpl-7.1.13-linux-x86_64-glibc23 ] ; then
    tar -zxvf mysqlcluster-7.1.13.tar.gz
    ln -s mysql-cluster-gpl-7.1.13-linux-x86_64-glibc23 mysqlc
    fi
