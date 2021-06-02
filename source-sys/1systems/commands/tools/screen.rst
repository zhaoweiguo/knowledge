screen命令使用
##############

::

   screen -ls
   
   // 恢复会话
   screen -r 16582
   screen -r <name>
   
   screen -x

   screen -R <name>

   // 启动一个开始就处于断开模式的会话，会话的名称是test
   screen -dmS test
   // 并记录日志
   screen -L -dmS test



每个screen session 下 [1]_::

   C-a ? -> 显示所有键绑定信息
   
   C-a c -> 创建一个新的运行shell的窗口并切换到该窗口

   C-a n -> Next，切换到下一个 window
   C-a p -> Previous，切换到前一个 window
   C-a 0..9 -> 切换到第 0..9 个 window
   Ctrl+a [Space] -> 由视窗0循序切换到视窗9
   C-a C-a -> 在两个最近使用的 window 间切换
   C-a x -> 锁住当前的 window，需用用户密码解锁
   C-a d -> detach，暂时离开当前session，将目前的 screen session (可能含有多个 windows) 丢到后台执行，并会回到还没进 screen 时的状态，此时在 screen session 里，每个 window 内运行的 process (无论是前台/后台)都在继续执行，即使 logout 也不影响。
   C-a z -> 把当前session放到后台执行，用 shell 的 fg 命令则可回去。
   C-a w -> 显示所有窗口列表
   C-a t -> Time，显示当前时间，和系统的 load

   C-a k -> kill window，强行关闭当前的 window

   C-a [ -> 进入 copy mode，在 copy mode 下可以回滚、搜索、复制就像用使用 vi 一样

其他::

   C-a :fit  适应屏幕



记录屏幕日志 [2]_ 
---------------------
基本::

   第一种方法:
    启动时添加选项-L（Turn on output logging.），会在当前目录下生成screenlog.0文件。

   第二种方法:
   不加选项-L，启动后，在screen session下按ctrl+a H, 同样会在当前目录下生成screenlog.0文件

   第一次按下ctrl+a H，屏幕左下角会提示Creating logfile "screenlog.0".，开始记录日志
   再次按下ctrl+a H，屏幕左下角会提示Logfile "screenlog.0" closed.，停止记录日志

改进::

   上面两个方法有个缺点:
      当创建多个screen会话的时候，每个会话都会记录日志到screenlog.0文件
      screenlog.0中的内容就比较混乱了。

   解决方法:让每个screen会话窗口有单独的日志文件
      在screen配置文件/etc/screenrc最后添加下面一行：
      logfile /tmp/screenlog_%t.log
      %t是指window窗口的名称，对应screen的-t参数
      所以我们启动screen的时候要指定窗口的名称
      $> screen -L -t window1 -dmS test
      意思是启动test会话，test会话的窗口名称为window1

dtach
=====

dtach 是用来模拟screen的detach的功能的小工具，其可以让你随意地attach到各种会话上 。下图为dtach+dvtm的样子。

byobu
=====

byobu是Ubuntu开发的，在Screen的基础上进行包装，使其更加易用的一个工具。最新的Byobu，已经是基于Tmux作为后端了。可通过“byobu-tmux”这个命令行前端来接受各种与tmux一模一样的参数来控制它。Byobu的细节做的非常好，效果图如下：





.. [1] http://www.cnblogs.com/mchina/archive/2013/01/30/2880680.html
.. [2] https://blog.51cto.com/qicheng0211/1549201









