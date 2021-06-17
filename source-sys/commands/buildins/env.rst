.. _env:

env命令
#######

结构::

    usage: env [-iv] [-P utilpath] [-S string] [-u name]
               [name=value ...] [utility [argument ...]]

::

    env

常见的环境变量::

    ◆ PATH:             path目录
    ◆ HOME:             主用户目录
    ◆ HISTSIZE:         是指保存历史命令记录的条数
    ◆ LOGNAME:          是指当前用户的登录名
    ◆ HOSTNAME:         是指主机的名称，许多应用程序如果要用到主机名的话，通常是从这个环境变量中来取得的
    ◆ SHELL:            是指当前用户用的是哪种Shell
    ◆ LANG/LANGUGE:     是和语言相关的环境变量，使用多种语言的用户可以修改此环境变量
    ◆ MAIL:             是指当前用户的邮件存放目录
    ◆ PS1是基本提示符，对于root用户是#，对于普通用户是$
    ◆ PS2是附属提示符，默认是“>

其他::

    1. java相关
    JAVA_HOME: 
    CLASSPATH: 

    2. golang相关
    GO111MODULE:
    GOPATH:
    GOROOT:
    GOPROXY:

set,env和export命令
-------------------

::

    set     显示当前shell的定义的私有变量，包括用户的环境变量，按变量名称排序
    env     显示用户的环境变量
    export  显示当前导出成用户变量的shell变量，并显示变量的属性(是否只读)，按变量名称排序
    declare 同set 一样，显示当前shell的定义的变量，包括用户的环境变量；


shell变量包括两种变量::

    1. 本shell私有的变量:
    A1="1234"
    delcare A2="2345"

    2. 用户的环境变量:
    A1="1234"
    export A1  #先定义再导出
    export A3="34"








