.. _locale:

locale命令
=======================

* 有时会遇到打到文件时，汉字不显示，显示3个整形。原因是字符语言环境的原因,察看方法::

    $ locale;  #查看字符集显示(locale的书写格式为: 语言[_地域[.字符集]])
    LANG=en_US.UTF-8
    LC_CTYPE="en_US.UTF-8"
    LC_NUMERIC="en_US.UTF-8"
    LC_TIME="en_US.UTF-8"
    LC_COLLATE="en_US.UTF-8"
    LC_MONETARY="en_US.UTF-8"
    LC_MESSAGES="en_US.UTF-8"
    LC_PAPER="en_US.UTF-8"
    LC_NAME="en_US.UTF-8"
    LC_ADDRESS="en_US.UTF-8"
    LC_TELEPHONE="en_US.UTF-8"
    LC_MEASUREMENT="en_US.UTF-8"
    LC_IDENTIFICATION="en_US.UTF-8"
    LC_ALL="en_US.UTF-8"

* 修改方法(一般默认改为zh_CN.UTF-8就好了)::

    $ emacs /etc/sysconfig/i18n; #修改这个文件中的值

* locale中字符集的优先顺序是:

    * LC_ALL
    * LC_*
    * LANG

* locale中各选项的说明:

    * 语言符号及其分类(LC_CTYPE) 
    * 数字(LC_NUMERIC)
    * 比较和排序习惯(LC_COLLATE) 
    * 时间显示格式(LC_TIME) 
    * 货币单位(LC_MONETARY) 
    * 信息主要是提示信息,错误信息, 状态信息, 标题, 标签, 按钮和菜单等(LC_MESSAGES) 
    * 姓名书写方式(LC_NAME) 
    * 地址书写方式(LC_ADDRESS) 
    * 电话号码书写方式(LC_TELEPHONE) 
    * 度量衡表达方式(LC_MEASUREMENT) 
    * 默认纸张尺寸大小(LC_PAPER) 
    * 对locale自身包含信息的概述(LC_IDENTIFICATION)。 


方法 ::

    locale [options] [name...]

说明 :
    得到指定的locale-specific信息

选项 :

    使用命令 ``locale --help`` 察看

范例 ::

    locale -ck LC_TIME  //针对日期与时间的設定,打印目录名称与所有关键字
    locale day mon      //显示用于周、月的字符串

    // 当遇到问题时可执行下面步骤
    export LANGUAGE=en_US.UTF-8
    export LANG=en_US.UTF-8
    export LC_ALL=en_US.UTF-8
    locale-gen en_US.UTF-8
    dpkg-reconfigure locales   // 设定默认locale


    


    
