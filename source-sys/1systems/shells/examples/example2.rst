shell实例收集
##################
实例::

  case $UNAME in
    "Linux")
        HOST=`hostname -s 2>/dev/null`
        RET=$?
        if [ $RET != 0 ]; then
            HOST=`hostname`
            echo "WARN: hostname -s failed, use '$HOST' as hostname" > /dev/stderr
        fi
        ;;
  case


set命令::

    说明:
        The -- is the standard "don't treat anything following this as an option"
        parameters which follow this option do not set shell flags, but are assigned to positional parameters

    实例:
    $ set a b c
    $ echo $1,$2,$3
    a,b,c
    ======
    $ echo $1,$2,$3
    a,b,c
    $ set -- haproxy "$@"
    $ echo $1,$2,$3,$4   
    haproxy,a,b,c
    ======
    $ set -a b
    $ echo $1
    b
    ----
    $ set -- -a b
    $ echo $1
    -a










