recon info
###############


recon:info/1-2-3-4::

    % process_info的安全增强版本
    
    erl> recon:info(<Pid>). % 进程只需是调试节点的本地进程
    erl> process_info(Pid, Key).
    % 常用键值
    % 1.元信息(meta)
    %   dictionary: 进程字典
    %   group_leader: IO(文件，io:format的输出)的去向
    %   registered_name: 进程名
    %   status: 
    %     exiting 进程已经结束，但是还未被完全清除
    %     waiting 进程在 receive ... end 中等待
    %     running 运行中
    %     runnable 准备就绪，但是尚未被调度，因为另一个进程正在运行中
    %     garbage_collecting 垃圾回收中
    %     suspended 不管是因为 BIF 调用，还是因为 socket 或端口缓冲满，
    %       作为一种反压 机制的结果而被挂起，都是此值。仅当端口不忙时，进程才会再次变 成 runnable 的
    % 2.信号(signals)
    %   links: 会报告出进程所链接的所有其他进程以及端口(socket、文件描述符)列表
    %     注:对于一些大的 supervisor 要小心使用，因为返回的列表中会有成千上万的项
    %   monitored_by: 返回所有监控当前进程(通过 erlang:monitor/2)的进程列表
    %   monitors: 和 monitored_by 相反，返回所有被当前进程监控的进程列表
    %   trap_exit: 如果该进程捕获 exit，就返回 true，否则返回 false
    % 3.位置(location)
    %   current_function: 以 tuple 的形式({Mod, Fun, Arity})显示进程的当前运行函数
    %   current_location: 显示进程在模块中的位置，显示格式为:
    %         {Mod, Fun, Arity, [{file,FileName},{line, Num}]}
    %   current_stacktrace: 上一个选项(current_location)的更详细版本，会以“current_location”
    %         列表的形式显示当前的堆栈跟踪信息
    %   initial_call: 显示进程 spawn 时运行的函数，形式为:{Mod, Fun, Arity}
    % 4.内存使用(memory_used)
    %   binary: 显示所有refc binary90的引用及其大小
    %     注:如果此类binary分配过多，那么调用起来就不安全
    %   garbage_collection: 报告进程中有关垃圾回收的信息
    %     这部分信息在官方文档中被声明为“subject to change”，应当以此为准
    %     这部分内容往往会包括进 程已经执行的垃圾回收的次数，
    %     完整清理(full‐sweep)垃圾回收的 选项，堆大小等等
    %   heap_size: 会显示进程最新代的堆大小，通常也包 括堆栈大小。返回值的单位是 word
    %     典型的 Erlang 进程包含有一个“老”堆和一个“新”堆，并会经历分代型(generational)的垃圾回收
    %   memory: 进程占用内存的大小，单位为字节,包括:
    %     调用栈、堆以及作为进程的一 部分由 VM 使用的内部结构
    %   message_queue_len: 显示进程邮箱中等待的消息个数
    %   messages: 返回进程邮箱中的所有消息
    %     注: 在生产环境中，这个调用是极度危险的，比如，
    %       如果正在调试某个进程而导致它被锁住，那么其邮箱中会堆积上百万条消息
    %       一定要先调用 message_queue_len 以确保安全
    %   total_heap_size: 和 heap_size 类似，不过也会包含所有其他部分的堆，包括老堆。返回 值的单位是 word
    % 5.工作量(work)
    %   reductions: Erlang VM 基于 reduction 来进行调度，reduction 是一种规定的工作量单位
    %       用来保证调度实现的高度可移植性(基于时间的调度很难做到在所有 Erlang 运行的 OS 上都高效)
    %       进程的 reduction 值越高，表示其(在 CPU 和函数调 用意义上)所做的工作就越多

    erl> recon:info(Pid, work). % 取某组的信息
    erl> recon:info(Pid, [memory, status]). % 等同于process_info/2,不过会过滤不安全数据








