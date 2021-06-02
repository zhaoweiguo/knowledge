.. _shell_for:

shell的for循环
====================

类型一::

    gitcontents=1 2 3
    for gitcontent in $gitcontents
    do
        echo $gitcontent
    done

类型二::

    for((i=1;i<10;i++))
    do
        if((i%3==0)); then
            echo $i;
            continue;
        fi
    done;

类型三(由于调用expr运行速度会慢很多,可以使用 ``i=$(($i+1)))`` 稍提速,不过有shell不支持::

    i=1;
    while(($i<100));do
      echo $i
      i=`expr $i+1`
    done

类型四::

    for i in {1..10}; do
    echo $i
    done

类型五::

    arr=(1 2 3);
    echo "arr is (${arr[@]})"
    for i in ${arr[@]}
    do
      echo $i
    done



具体的实例
------------------

实例一::

    folders=`ls`
    for folder in $folders
    do
        echo $folder
    done





