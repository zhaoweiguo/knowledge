shell调试
##############


Bash 的错误处理
---------------

命令::

    command || exit 1


实例::

    # 写法一
    command || { echo "command failed"; exit 1; }

    # 写法二
    if ! command; then echo "command failed"; exit 1; fi

    # 写法三
    command
    if [ "$?" -ne 0 ]; then echo "command failed"; exit 1; fi


