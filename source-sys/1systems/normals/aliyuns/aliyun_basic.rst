基本安装
==============

修改hostname::

  hostname <hostname>         // 修改hostname
  修改文件 /etc/hostname

修改 ``/etc/bash.bashrc`` 文件::

  # source ~/.bash_profile(使配置文件立即生效)
  alias la='ls -A'
  alias ll='ls -alhF'
  alias ls='ls -G'

  alias grep='grep --color=auto'
  alias diff=colordiff

  
  export LANGUAGE=en_US.UTF-8
  export LANG=en_US.UTF-8
  export LC_ALL=en_US.UTF-8
  
  # 定义svn editor为vim编辑
  export SVN_EDITOR=vim


安装必要工具::

  apt-get install tmux emacs vim git-core

  apt-get install curl

  apt-get install redis-server
  
  apt-get install emacs23-el
       php-elisp  # emacs support for php file

  # php脚本相关
  # apt-get install php5 php5-curl php5-mysqlnd php5-mcrypt php5-gd
  apt-get install php5
      php5-curl      // jpush会用到(或自己使用php的curl)
      php5-mysqlnd   // Native Driver(如不安装，默认php的int按float类型,默认php的int按string类型?)
      php5-mcrypt   // 加密相关(laraval需要)
      php5-gd       // 验证码相关

  # php-fpm相关
  apt-get install php5-fpm nginx

  # mysql相关
  apt-get install mysql-server mysql-common mysql-client

  # 其他
  apt-get install colordiff



增加普通用户::

  useradd -m -s /bin/bash <用户名>
  passwd <用户名>

修改ssh相关::

  // 修改文件
  /etc/sshd_config
  1. 修改port
  2. 禁止root登录(PermitRootLogin)







     
