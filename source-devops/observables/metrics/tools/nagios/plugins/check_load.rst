.. _check_load:

check_load命令
================

* 用法::

    check_load [-r] -w WLOAD1,WLOAD5,WLOAD15 -c CLOAD1,CLOAD5,CLOAD15

* 选项::

    -h, --help
    -V, --version
    -w, --warning=WLOAD1,WLOAD5,WLOAD15
        如果平均负载超过WLOADn、Exit with WARNING status
    -c, --critical=CLOAD1,CLOAD5,CLOAD15
        如果平均负载超过CLOADn、Exit with CRITICAL status
        这个平均负载和命令"w"还有"uptime"一样
    -r, --percpu
        把平均负载按cpu个数平分(需要时)

* 实例::

    check_load -w 15,10,5 -c 30,25,20

* 说明:

    * 当1分钟多于15个进程等待,5分钟多于10个,15分钟多于5个则为warning状态
    * 当1分钟多于30个进程等待,5分钟多于25个,15分钟多于20个则为critical状态
