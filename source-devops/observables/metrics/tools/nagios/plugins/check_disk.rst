.. _check_disk:

check_disk命令
===============

* 用法::

    check_disk -w limit -c limit [-W limit] [-K limit] {-p path | -x device}
      [-C] [-E] [-e] [-g group ] [-k] [-l] [-M] [-m] [-R path ] [-r path ]
      [-t timeout] [-u unit] [-v] [-X type]

* 选项::

    -h, --help
    -V, --version
    -w, --warning=INTEGER
       如果磁盘空闲容量小于INTEGER单位时、Exit with WARNING status
    -w, --warning=PERCENT%
       如果磁盘空闲容量百分比小于PERCENT%时、Exit with WARNING status
    -c, --critical=INTEGER
       如果磁盘空闲容量小于INTEGER单位时、Exit with CRITICAL status
    -c, --critical=PERCENT%
       如果磁盘空闲容量百分比小于PERCENT%时、Exit with CRITICAL status
    -W, --iwarning=PERCENT%
       如果inode空间空闲容量小于PERCENT时、Exit with WARNING status
    -K, --icritical=PERCENT%
       如果inode空间空闲容量百分比小于PERCENT%时，Exit with CRITICAL status
    -p, --path=PATH, --partition=PARTITION
       Path or partition (may be repeated)
    -x, --exclude_device=PATH <STRING>
       Ignore device (only works if -p unspecified)
    -C, --clear
       Clear thresholds
    -E, --exact-match
       For paths or partitions specified with -p, only check for exact paths
    -e, --errors-only
       Display only devices/mountpoints with errors
    -g, --group=NAME
        Group paths. Thresholds apply to (free-)space of all partitions together
    -k, --kilobytes
        Same as '--units kB'
    -l, --local
        Only check local filesystems
    -L, --stat-remote-fs
        Only check local filesystems against thresholds. Yet call stat on remote filesystems
        to test if they are accessible (e.g. to detect Stale NFS Handles)
    -M, --mountpoint
        Display the mountpoint instead of the partition
    -m, --megabytes
        Same as '--units MB'
    -A, --all
        Explicitly select all paths. This is equivalent to -R '.*'
    -R, --eregi-path=PATH, --eregi-partition=PARTITION
        Case insensitive regular expression for path/partition (may be repeated)
    -r, --ereg-path=PATH, --ereg-partition=PARTITION
        Regular expression for path or partition (may be repeated)
    -I, --ignore-eregi-path=PATH, --ignore-eregi-partition=PARTITION
        Regular expression to ignore selected path/partition (case insensitive) (may be repeated)
    -i, --ignore-ereg-path=PATH, --ignore-ereg-partition=PARTITION
        Regular expression to ignore selected path or partition (may be repeated)
    -t, --timeout=INTEGER
        Seconds before connection times out (default: 10)
    -u, --units=STRING
        可选值有bytes, kB, MB, GB, TB (默认为: MB)
    -v, --verbose
        Show details for command-line debugging (Nagios may truncate output)
    -X, --exclude-type=TYPE
        Ignore all filesystems of indicated type (may be repeated)


* 实例::

    check_disk -w 20% -c 10% -p /       ;检查磁盘,可用小于20时报警,小于10%时报错,检查的是"/"目录
    //正常返回
    DISK OK - free space: / 120156 MB (96% inode=98%);| /=4750MB;105272;118431;0;131591


