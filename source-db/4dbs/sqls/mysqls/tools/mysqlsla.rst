.. _mysqlsla:

慢查询日志分析工具
#############################
安装::

    wget http://hackmysql.com/scripts/mysqlsla-2.03.tar.gz
    tar xzf mysqlsla-2.03.tar.gz
    cd mysqlsla-2.03
    perl Makefile.PL
    make
    make install

实例::

    mysqlsla -lt slow /var/log/mysql-slow.log -top 10 -sort c_sum > top10_count_sum.log

    #统计出现次数最多的前10条慢查询
    mysqlsla -lt slow /var/log/mysql-slow.log -top 10 -sort c_sum > top10_count_sum.log
    #统计执行时间的总和前10条慢查询
    mysqlsla -lt slow /var/log/mysql-slow.log -top 10 -sort t_sum > top10_time_sum.log
    #统计平均执行时间最长的前10条慢查询(常用)
    mysqlsla -lt slow /var/log/mysql-slow.log -top 10 -sort t_avg > top10_time_avg.log

高级:

如果需要做更复杂的统计，可以参考官方文档：http://hackmysql.com/mysqlsla_guide





