redis的优化
=================

性能测试::

   redis-benchmark -h ***********.m.cnsza.kvstore.aliyuncs.com -p 6379 -a password -t set -c 50 -d 128 -n 25000000 -r 5000000

