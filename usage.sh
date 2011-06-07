#!/bin/bash
cat datanodes.txt | sed s/mysql// | xargs -P0 -n1 -I{} ssh mysqlctr 'mysqlcluster-test/mysqlc/bin/ndb_mgm -e "{} report MemoryUsage"'

#see the state of storage files
ssh mysqld "\
     echo \
      \"select extra,sum(free_extents),sum(total_extents) from \
       (select file_name,extra,extent_size,free_extents,total_extents from information_schema.files where file_name like '%data%') foo \
        group by extra;\" |       mysqlcluster-test/mysqlc/bin/mysql -uroot -P5000 -hmysqld"
