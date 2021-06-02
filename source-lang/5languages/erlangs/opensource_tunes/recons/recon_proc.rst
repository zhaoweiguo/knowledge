recon proc
################


找出当前节点Attr属性最大的N个进程::

    recon:proc_count(Attr, N).
    说明:
    主要调用process_info/2函数

    实例:
    // 内存
    recon:proc_count(memory, 10).
    // 消息队列
    recon:proc_count(message_queue_len, 10).
    // binary memory
    recon:proc_count(binary_memory, 10).

    erl> recon:proc_count(Attr, N).  % 列出前N个Attr进程
    如:
    erl> recon:proc_count(memory, 3).
    % 使用工具观察一段时间(在Milliseconds时间内，前Num位的情况)
    erl> recon:proc_window(Attribute, Num, Milliseconds)
    如:
    erl> recon:proc_window(memory, 3, 10000).
    警告:
      这个函数会采集2个快照间数据，构造进程字典来取差值，当进程数目很多时（上万）会耗费大量的内存和不少时间







