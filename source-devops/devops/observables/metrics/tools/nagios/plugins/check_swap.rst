.. _check_swap:

check_swap命令
===============

用法::

    check_swap [-av] -w <percent_free>% -c <percent_free>%
    check_swap [-av] -w <bytes_free> -c <bytes_free>

选项::

    -h, --help
    -V, --version
    -w, --warning=INTEGER     详见:check_disk
    -w, --warning=PERCENT%%   详见:check_disk
    -c, --critical=INTEGER    详见:check_disk
    -c, --critical=PERCENT%%  详见:check_disk
    -a, --allswaps
        Conduct comparisons for all swap partitions, one by one
    -v, --verbose
        Show details for command-line debugging (Nagios may truncate output)

