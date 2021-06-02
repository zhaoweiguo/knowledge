配置参数查询优化
====================

::

  mysql> show variables like '%slow%';

  +---------------------+----------------------------+

  | Variable_name       | Value                      |

  +---------------------+----------------------------+

  | log_slow_queries    | ON                         |

  | slow_launch_time    | 2                          |

  | slow_query_log      | ON                         |

  | slow_query_log_file | /var/db/mysql/db1-slow.log |

  +---------------------+----------------------------+

  4 rows in set (0.01 sec)



  mysql>  show global status like '%slow%';

  +---------------------+-------+

  | Variable_name       | Value |

  +---------------------+-------+

  | Slow_launch_threads | 0     |

  | Slow_queries        | 8189  |

  +---------------------+-------+

  2 rows in set (0.00 sec)



  mysql> show variables like 'max_connections';

  +-----------------+-------+

  | Variable_name   | Value |

  +-----------------+-------+

  | max_connections | 1000  |

  +-----------------+-------+

  1 row in set (0.01 sec)



  mysql> show global status like 'max_used_connections';

  +----------------------+-------+

  | Variable_name        | Value |

  +----------------------+-------+

  | Max_used_connections | 200   |

  +----------------------+-------+

  1 row in set (0.00 sec)



  mysql> show variables like 'key_buffer_size';

  +-----------------+----------+

  | Variable_name   | Value    |

  +-----------------+----------+

  | key_buffer_size | 33554432 |

  +-----------------+----------+

  1 row in set (0.00 sec)



  mysql> show global status like 'key_read%';

  +-------------------+-------+

  | Variable_name     | Value |

  +-------------------+-------+

  | Key_read_requests | 3727  |

  | Key_reads         | 47    |

  +-------------------+-------+

  2 rows in set (0.00 sec)



  mysql> show global status like 'key_blocks_u%';

  +-------------------+-------+

  | Variable_name     | Value |

  +-------------------+-------+

  | Key_blocks_unused | 26745 |

  | Key_blocks_used   | 47    |

  +-------------------+-------+

  2 rows in set (0.00 sec)



  mysql> show global status like 'created_tmp%';

  +-------------------------+-------+

  | Variable_name           | Value |

  +-------------------------+-------+

  | Created_tmp_disk_tables | 3557  |

  | Created_tmp_files       | 740   |

  | Created_tmp_tables      | 67587 |

  +-------------------------+-------+

  3 rows in set (0.00 sec)



  mysql> show global status like 'open%tables%';

  +---------------+-------+

  | Variable_name | Value |

  +---------------+-------+

  | Open_tables   | 776   |

  | Opened_tables | 1125  |

  +---------------+-------+

  2 rows in set (0.01 sec)



  mysql> show variables like 'table_open_cache';

  +------------------+-------+

  | Variable_name    | Value |

  +------------------+-------+

  | table_open_cache | 2048  |

  +------------------+-------+

  1 row in set (0.00 sec)



  mysql> show global status like 'thread%';

  +-------------------+-------+

  | Variable_name     | Value |

  +-------------------+-------+

  | Threads_cached    | 8     |

  | Threads_connected | 26    |

  | Threads_created   | 16033 |

  | Threads_running   | 3     |

  +-------------------+-------+

  4 rows in set (0.00 sec)



  mysql> show variables like 'thread_cache_size';

  +-------------------+-------+

  | Variable_name     | Value |

  +-------------------+-------+

  | thread_cache_size | 8     |

  +-------------------+-------+

  1 row in set (0.00 sec)



  mysql> show global status like 'qcache%';

  +-------------------------+-----------+

  | Variable_name           | Value     |

  +-------------------------+-----------+

  | Qcache_free_blocks      | 719       |

  | Qcache_free_memory      | 132986888 |

  | Qcache_hits             | 70172087  |

  | Qcache_inserts          | 20107107  |

  | Qcache_lowmem_prunes    | 15130405  |

  | Qcache_not_cached       | 435001    |

  | Qcache_queries_in_cache | 846       |

  | Qcache_total_blocks     | 2439      |

  +-------------------------+-----------+

  8 rows in set (0.00 sec)



  mysql> show variables like 'query_cache%';

  +------------------------------+-----------+

  | Variable_name                | Value     |

  +------------------------------+-----------+

  | query_cache_limit            | 2097152   |

  | query_cache_min_res_unit     | 4096      |

  | query_cache_size             | 134217728 |

  | query_cache_type             | ON        |

  | query_cache_wlock_invalidate | OFF       |

  +------------------------------+-----------+

  5 rows in set (0.00 sec)



  mysql> 

  mysql> show global status like 'sort%';

  +-------------------+----------+

  | Variable_name     | Value    |

  +-------------------+----------+

  | Sort_merge_passes | 367      |

  | Sort_range        | 6229816  |

  | Sort_rows         | 22832911 |

  | Sort_scan         | 34523    |

  +-------------------+----------+

  4 rows in set (0.00 sec)



  mysql> show global status like 'open_files';

  +---------------+-------+

  | Variable_name | Value |

  +---------------+-------+

  | Open_files    | 81    |

  +---------------+-------+

  1 row in set (0.00 sec)



  mysql> show variables like 'open_files_limit';

  +------------------+-------+

  | Variable_name    | Value |

  +------------------+-------+

  | open_files_limit | 11095 |

  +------------------+-------+

  1 row in set (0.01 sec)

  mysql> show global status like 'table_locks%';

  +-----------------------+----------+

  | Variable_name         | Value    |

  +-----------------------+----------+

  | Table_locks_immediate | 27084296 |

  | Table_locks_waited    | 2787     |

  +-----------------------+----------+

  2 rows in set (0.00 sec)



  mysql> show global status like 'handler_read%';

  +-----------------------+-------------+

  | Variable_name         | Value       |

  +-----------------------+-------------+

  | Handler_read_first    | 122428      |

  | Handler_read_key      | 3266127950  |

  | Handler_read_last     | 100         |

  | Handler_read_next     | 1208736117  |

  | Handler_read_prev     | 42526108    |

  | Handler_read_rnd      | 22443206    |

  | Handler_read_rnd_next | 15328993696 |

  +-----------------------+-------------+

  7 rows in set (0.00 sec)



  mysql> show global status like 'com_select';

  +---------------+----------+

  | Variable_name | Value    |

  +---------------+----------+

  | Com_select    | 20573518 |

  +---------------+----------+

  1 row in set (0.00 sec)




