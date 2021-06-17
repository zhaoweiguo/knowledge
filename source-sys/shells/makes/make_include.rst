include相关
#################

1. 如果指示符“include”指定的文件不是以斜线开始（绝对路径，如/usr/src/Makefile...）
2. 而且当前目录下也不存在此文件；make将根据文件名试图在以下几个目录下查找::

    首先，查找使用命令行选项“-I”或者“--include-dir”指定的目录，如果找到指定的文件，则使用这个文件；
    否则继续依此搜索以下几个目录（如果其存在）:
    /usr/gnu/include
    /usr/local/include
    /usr/include

当在这些目录下都没有找到“include”指定的文件，且后续没有规则创建，会输出类似如下错误提示::

    Makefile:错误的行数：未找到文件名：提示信息（No such file or directory）
    Make： *** No rule to make target ‘<filename>’. Stop

可使用“-include”来代替“include”，来忽略由于包含文件不存在或者无法创建时的错误提示::

    “-”的意思是告诉make，忽略此操作的错误。make继续执行
    如:
    -include FILENAMES...
    使用这种方式时，当所要包含的文件不存在时不会有错误提示、make也不会退出

区别::

    include : 如果程序找不到include的文件，make就会停止
    -include: 找不到你所包含的文件时不停止执行，忽略该错误
    sinclude: 为了和其它的make程序进行兼容。也可以使用“sinclude”来代替“-include”（GNU所支持的方式）






