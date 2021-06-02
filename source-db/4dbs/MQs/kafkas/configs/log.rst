日志相关
########

分段策略属性(详见 :ref:`Kafka存储机制<kafka_storage>`)::

    log.roll.{hours,ms}:
       日志滚动的周期时间，到达指定周期时间时，强制生成一个新的segment 
       默认值: 168（7day）
    log.segment.bytes:
       每个segment的最大容量。到达指定容量时，将强制生成一个新的segment 
       默认值: 1G(-1为不限制)
    log.retention.check.interval.ms:
       日志片段文件检查的周期时间 
       默认值: 60000



日志刷新策略::

    Kafka的日志实际上是开始是在缓存中的，然后根据策略定期一批一批写入到日志文件中去，以提高吞吐率

    log.flush.interval.messages 
        消息达到多少条时将数据写入到日志文件  
        默认值: 10000
    log.flush.interval.ms 
        当达到该时间时，强制执行一次flush 
        默认值: null
    log.flush.scheduler.interval.ms 
        周期性检查，是否需要将信息flush  
        默认值: 很大的值

日志保存清理策略::

    log.cleaner.enable=true

    log.cleanup.polict  
        日志清理保存的策略只有delete和compact两种 
        默认值: delete
    log.retention.hours 
        日志保存的时间，可以选择hours,minutes和ms  
        # log.retention.{hours,minutes,ms} 超出保留时间的日志执行cleanup.policy定义的操作
        默认值: 168(7day)
    log.retention.bytes 
        删除前日志文件允许保存的最大值 
        默认值: -1
    log.segment.delete.delay.ms 
        日志文件被真正删除前的保留时间 
        默认值: 60000
    log.cleanup.interval.mins 
        每隔一段时间多久调用一次清理的步骤 
        默认值: 10
    log.retention.check.interval.ms 
        周期性检查是否有日志符合删除的条件（新版本使用）  
        默认值: 300000ms


.. note:: 这里特别说明一下，日志的真正清楚时间。当删除的条件满足以后，日志将被“删除”，但是这里的删除其实只是将该日志进行了“delete”标注，文件只是无法被索引到了而已。但是文件本身，仍然是存在的，只有当过了log.segment.delete.delay.ms 这个时间以后，文件才会被真正的从文件系统中删除。










参考::
    
    https://www.cnblogs.com/angellst/p/9368493.html


