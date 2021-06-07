优化相关
==============

数据库的优化信赖数据库层面的几个因素: 如表、請求和配置文件設定！
这些软件结构上问题最終在硬件层面都反映为CPU和I/O操作！

* 在数据库层面进行优化:

    * 数据库结构
    * 索引使用是否正确
    * 每个表是否都使用了正确的存储引擎
    * 每个表是否使用的合适的行格式
    * 应用是否使用的合适的锁机制
    * 是否所有的用于缓存的内存区域大小合适(要足够以能hold住频繁访问数据而又不至于超过物理、引起分页)

* 硬件层面的优化:

    * 磁盘寻道: 对磁盘来说寻找一块数据是需要时间的。对现代磁盘，平均时间低于10ms，所以理论上来说每秒钟可以做大约100次寻道。优化查询的方法是把数据分发到多个磁盘上。
    * 磁盘读写: 当磁盘在一正确位置时，我们需要读写数据。对现代磁盘来说，一个磁盘传输至少10-20M的吞吐量。比磁盘寻道容易优化的原因是，你可以并行的从多个磁盘上读写数据
    * CPU转速: 当数据在内存中，我们就需要计算出結果。内存充足，需要计算的多时，CPU转速常制约因素。
    * 内存带宽: 当cpu需要比CPU cache更多数据时，主存带宽就变成瓶颈！

* 平衡可用和性能


详看:
http://dev.mysql.com/doc/refman/5.5/en/optimize-overview.html


8.2.4 优化INFORMATION_SCHEMA請求
-------------------------------------

http://dev.mysql.com/doc/refman/5.5/en/information-schema-optimization.html

8.2.5 其他优化小节
-----------------------
http://dev.mysql.com/doc/refman/5.5/en/miscellaneous-optimization-tips.html



网址: http://dev.mysql.com/doc/refman/5.5/en/statement-optimization.html


innodb_flush_log_at_trx_commit 参数很重要
