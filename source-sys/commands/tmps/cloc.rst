cloc命令
########

安装::

    $ brew install cloc

源码<https://github.com/AlDanial/cloc>::

     开源协议: GPL-2.0 License
     开发语言: Perl

实例::

    client-go> cloc .
    1075 text files.
     995 unique files.                                          
     105 files ignored.

    github.com/AlDanial/cloc v 1.86  T=1.18 s (826.1 files/s, 104506.2 lines/s)
    -------------------------------------------------------------------------------
    Language                     files          blank        comment           code
    -------------------------------------------------------------------------------
    Go                             945          17019          22843          80830
    Markdown                        15            551              0           1025
    JSON                             1              0              0            382
    XML                              7              0              0            120
    Starlark                         1              1             19             18
    Bourne Shell                     1              2             13              3
    Dockerfile                       1              1             13              3
    -------------------------------------------------------------------------------
    SUM:                           971          17574          22888          82381
    -------------------------------------------------------------------------------







