.. _shell_if:

shell的if語句
#######################

实例1::

    if [ 2 -eq 5 ] then
        echo "2==5";
    fi

实例2>文件是否存在::

  if [ ! -f "build/env.sh" ]; then
    echo "$0 must be run from the root of the repository."
    exit 2
  fi

  说明@todo:
  -f:
  -L:

注意事项::

  1.注意判断表达式两中括号间一定有空格
  2.