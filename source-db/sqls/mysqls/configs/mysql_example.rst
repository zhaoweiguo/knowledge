   

文件詳細说明
==================

.. literalinclude:: /files/mysqls/mysql_my.cnf
    :emphasize-lines: 12,15-18
    :linenos:



2014-02-20 mysql 配置::

  max_connections = 5000
  max_connect_errors = 30000


  table_open_cache = 2048
  max_allowed_packet = 16M
  binlog_cache_size = 4M
  max_heap_table_size = 128M
  read_buffer_size = 128M
  read_rnd_buffer_size = 64M
  sort_buffer_size = 128M
  join_buffer_size = 128M
  thread_cache_size = 16
  thread_concurrency = 64
  query_cache_limit = 128M
  ft_min_word_len = 4
  thread_stack = 512K

  tmp_table_size = 1024M

  binlog_format=mixed

  innodb_additional_mem_pool_size = 4096M                  
  innodb_buffer_pool_size = 64G
  innodb_buffer_pool_instances = 16
  innodb_write_io_threads = 16
  innodb_read_io_threads = 16
  innodb_thread_concurrency = 64

  innodb_lock_wait_timeout = 120
  innodb_io_capacity = 500


  innodb_page_size = 16k



  




