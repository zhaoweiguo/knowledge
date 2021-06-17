tmux使用
################


安装::

    brew install tmux
    sudo port install tmux
    sudo apt-get install tmux


基本命令::

    tmux    //启动
    exit    // 退出
    PREFIX: Ctrl+b
    PREFIX ?   //打印帮助信息


Session相关::

    tmux new -s <tmuxName>   // tmux new-session -s <tmuxName>
    tmux new -s <tmuxName> -d   // 后台创建一新session
    tmux ls    // tmux list-sessions
    tmux attach -t <tmuxName>     // 连接指定session
    tmux kill-session -t <tmuxName>
    PREFIX d    //离开session
    PREFIX s    // 列出session列表

windows相关::

    tmux new -s <sessionName> -n <windowName>
    PREFIX c     // 在sesson中创建新的window
    PREFIX ,    //修改window名
    PREFIX n     //移动到下一个window下
    PREFIX p     //移动到前一个window下
    PREFIX <num>    //移动到第<num>个window下(<num>取值从0-9)
    PREFIX f      // 切换到指定window下
    PREFIX w      //把当前session下的window列表列出
    PREFIX &      // 同exit,有确认窗口

panel相关(挺好用)::

    PREFIX %     //vertically split into two panels
    PREFIX "     //horizontally split into two panels
    PREFIX o     //在不同panel间
    PREFIX q     // 显示window下不同panel对应的数值
    PREFIX x     // 关闭panel
    PREFIX Space   //切换layout




[copy mode] => 基本命令::

    PREFIX [       // 进入copy mode[一般是emacs模式]
    Ctrl_X Ctrl_C  // 退出copy mode

    // copy里面内容
    Ctrl_X @    //进入标记状态
    Alt_W       //拷贝里面内容,并退出copy mode
    sh> tmux show-buffer | less    //查看刚才copy的内容

    sh> tmux capture-pane && tmux save-buffer buffer.txt   //capture the current buffer to buffer.txt

    // buffer是共享的
    //你可以在一个tmux中copy后,再另一tmux中用


[copy mode] => 进入命令界面::

    PREFIX :   //进入命令界面
    
    tmux> capture-pane     //抓取当前页面
    tmux> show messages    // 展示消息列表
    tmux> show buffer      //
    tmux> ...


[copy mode] => 在linux和它的clipboard一起工作::

    sh> sudo apt-get install xclip
    // 修改.tmux.conf文件
    sh> edit .tmux.conf
    // PREFIX CTRL-c 变为拷贝
    bind C-c run "tmux save-buffer - | xclip -i -sel clipboard"
    // PREFIX CTRL-v 变为复制
    bind C-v run "tmux set-buffer \"$(xclip -o -sel clipboard)\"; tmux paste-buffer"

[copy mode] => 在mac和它的Clipboard一起工作::

     $ git clone https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard.git
     $ cd tmux-MacOSX-pasteboard/
     $ make reattach-to-user-namespace



tmux配置::

    /etc/tmux.conf
    ~/.tmux.conf

    //编辑文件tmux.conf:
    set -g prefix C-a    //把prefix绑定为Ctrl+a
    unbind C-b           //把Ctrl+b取消绑定
    set -g base-index 1    //window的索引,默认从0开始
    set -g pane-base-index 1    //panel的索引,默认从1开始


.. warning::

    修改tmux.conf文件后不会立即生效, 你需要关闭所有tmux窗口或键入 ``PREFIX :`` 并输入 ``source-file ~/.tmux.conf``



常见问题
'''''''''''

解决tmux启动「can't create socket」的问题::

    >> strace -e trace=file tmux
    open("/lib64/tls/libpthread.so.0", O_RDONLY) = 3
    access("/bin/bash", X_OK) = 0
    access("/home/xxx/.tmux.conf", R_OK) = -1 ENOENT (No such file or directory)
    mkdir("/tmp//tmux-501", 0700) = 0
    lstat("/tmp//tmux-501", {st_mode=S_IFDIR|0700, st_size=4096, ...}) = 0
    can't create socket
    Process 3171 detached

    「/tmp/tmux-501」这个目录出了问题，删掉这个目录，tmux就可以正常启动了

tmux莫名被终止::

    > grep "tmux" /var/log/messages
    Nov 21 21:52:28 idc-sm-udsp-pre-iot-engine-02 kernel: [12555373.306451] tmux[17348]: segfault at 7f58be1047b8 ip 00007f58be1047b8 sp 00007ffcbd210c38 error 15 in libc-2.17.so[7f58be104000+2000]

    原因:
    可能和glibc兼容性有问题




