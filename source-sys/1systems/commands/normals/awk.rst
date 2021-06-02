.. _awk:

awk命令
###############


语法::

    #!/bin/awk -f

    awk [ -F fs ] [ -v var=value ] [ 'prog' | -f progfile ] [ file ...  ]

说明::

    $0表示整个行(记录)
    -v <var>=<value>   //赋值后可以d {}里面使用




内置变量 => NF：当前记录中的字段个数::

    >>cat c.txt
    1:2:3
    1:2
    >>awk -F ':' '{print NF}' c.txt
    3
    2
    #可用于字段数过滤
    >>awk -F ':' '{if(NF==3)print}' c.txt
    1：2：3

内置变量 => 分隔::

    RS:记录分隔符变量,缺省为"\n",
    缺省情况下，awk把一行看作一个记录；
    如果设置了RS，那么awk按照RS来分割记录:

    >>cat d.txt
    hello world;I am a boy;happy
    >>awk 'BEGIN{RS=";"}{print}' d.txt
    hello world
    I am a boy
    happy

内置变量 => ORS: 输出记录分隔符，缺省为换行符，控制每个print语句后的输出符号::

    >> cat c.txt
    1:2:3
    1:2
    >> awk 'BEGIN{ORS=";"}{print NF}' c.txt
    1;1;

内置变量 => NR: 已经读出的记录数, FNR: 当前文件的记录数::

    输入文件a.txt和b.txt，由于先扫描a.txt
    所以扫描a.txt的时候必然有NR==FNR，然后扫描b.txt的时候，FNR从1开始计数
    而NR则接着a的行数继续计数，所以NR > FNR
    awk 'NR==FNR{print} NR>FNR{print}' a.txt b.txt

内置变量 => FS:字段分隔符::

    awk -F ':' '{print}'a.txt
    和 
    awk 'BEGIN{FS=":"}{print}' a.txt
    是一样的

内置变量 => OFS：输出字段分隔符（缺省为:space:）::

    >>cat b.txt
    1:2:3
    4:5:6
    >>awk -F ':' 'BEGIN{OFS=";"}{print $1,$2,$3}' b.txt
    #那么把OFS设置成";"后就会输出
    1;2;3
    4;5;6

awk的内置函数::

    显示<testAwk>文件中行号与第1个字段:
    awk '{printf"%03d   %s\n",NR,$1}' <testAwk>

    显示文本文件<mydoc>匹配（含有）字符串"sun"的所有行:
    awk '/sun/{print}' <mydoc>
    or
    awk '/sun/' <mydoc>   # 显示整个记录（全行）是awk的缺省动作

    第一个匹配 ``Sun`` 或 ``sun`` 的行与第一个匹配 ``Moon`` 或 ``moon`` 的行之间的行，并显示到标准输出上:
    awk '/[Ss]un/,/[Mm]oon/ {print}' <myfile>

    下面的示例显示了内置变量和内置函数length:
    awk 'length($0)>80 {print NR}' <myfile>


    检查其中的passwd字段（第二字段）是否为"x",如不为"x", 则表示该用户没有设置密码:
    awk -F: '$2=="x" {printf "%s no password!\n", $1}' /etc/passwd

awk的流程控制::

    BEGIN和END(``<fileName>`` 文件字段间用 ``:`` 分隔):
    // 取出文件中的第三列字段, 并最終求和
    awk 'BEGIN \
    >{ FS=":";print "统计销售金额";total=0}
    >{print $3;total=total+$3;}
    >END
    >{printf "销售金额总计：%.2f",total}' <fileName>

    流程控制语句:
    if..else
    while
    do-while
    for(<1>;<2>;<3>)


实例::

    取出用户列表:
    cat /etc/passwd | awk -F: '{print $1}'

    分析nginx日志文件 ``access.log`` 获得访问前10位的ip地址:
    awk '{print $1}' access.log |sort|uniq -c|sort -nr|head -10

    for循环:
    awk 'BEGIN{for(i=1;i<=10;i++)print i;}'



其他小示例::

    打印所有以模式no或so开头的行:
    awk '/^(no|so)/' <fileName>

    如果记录以n或s开头，就打印这个记录:
    awk '/^[ns]/{print $1}' <filename>

    如果第一个域以两个数字结束就打印这个记录:
    awk '$1 ~/[0-9][0-9]$/{print $1} <filename>

    如果第一个等于100或不等于50或者第二个域小于50，则打印该行:
    awk '$1 ==100 || $1 != 50 || $2 < 50' <filename>

    如果记录包含正则表达式test，则第一个域加10并打印出来:
    awk '/test/{print $1 + 10}' <filename>

    如果第一个域大于5则打印前面的表达式值, 否则打印后面的表达式值:
    awk '{print ($1 > 5 ? "ok "$1: "error"$1)}' <filename>

    打印以正则表达式root开头的记录到以正则表达式mysql开头的记录范围内的所有记录:
    awk '/^root/,/^mysql/' <filename>

查出nginx日志中非200::

      tail -f access4.log | awk -F '-\^-' '{if($2!~"200"){printf("%s",$0);}}'
      // nginx日志如下
      zgapi4.taojoy.com.cn : 80 -^- 200 -^- [08/Jul/2016:20:11:32 +0800] -^- 180.97.88.2 \
        -^- /v5/goods/detail?aimuid=1602320&ghid=1063665&sign=4e8de70fc307e595d137222a994da2f9 -^- - -^- "-" -^- \
        "7color zeroshop_ios/5.0 (iPhone; iOS 9.3.2; Scale/2.00)" -^- "124.127.155.90" -^- 1241 -^- 0.036 -^- -\
        -^- http_headers:"app=zeroshop_ios&version=5.0&zgid=2E67E424-4181-4227-8BD8-AEA7F9DF23FC&os=ios&\
        timestamp=1\467979892&uid=1602320&token=a87513dd83fa7ff83d839eda1463555f&channel=appStore"

::

    find src/* | grep erl | awk -F'/' '{print "mv "$0 " apps/octopuscloud/"$0}'


实例:

.. literalinclude:: /files/linuxs/linux_awk_nginxlog.sh
   :language: sh
   :linenos:

