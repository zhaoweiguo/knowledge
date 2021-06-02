cmp命令
#############

功能说明::

    比较两个文件是否有差异
      当相互比较的两个文件完全一样时，则该指令不会显示任何信息
      若发现有所差异，预设会标示出第一个不同之处的字符和列数编号
      若不指定任何文件名称或是所给予的文件名为”-”，则cmp指令会从标准输入设备读取数据

语法::

    cmp [-clsv][-i <字符数目>][--help][第一个文件][第二个文件]


参数::

  　-c或–print-chars 　除了标明差异处的十进制字码之外，一并显示该字符所对应字符。
  　-i<字符数目>或–ignore-initial=<字符数目> 　指定一个数目。
  　-l或–verbose 　标示出所有不一样的地方。
  　-s或–quiet或–silent 　不显示错误信息。
  　-v或–version 　显示版本信息。
  　–help 　在线帮助。


实例
========

1. 要确定两个文件是否相同，请输入::

    cmp prog.o.bak prog.o
    这比较 prog.o.bak 和 prog.o。如果文件相同，则不显示消息。如果文件不同，则显示第一个不同的位置
    例1:
    prog.o.bak prog.o differ: char 4, line 1

    例2,如果显示消息:
    cmp: EOF on prog.o.bak
    则 prog.o 的第一部分与 prog.o.bak 相同，但在 prog.o 中还有其他数据。

2. 要显示不同字节的每个对，请输入::

    cmp  -l prog.o.bak prog.o
    这比较文件，然后显示字节数（使用十进制格式）和每个不同的不同字节（使用八进制格式）。
    例如:
    如果第五个字节在 prog.o.bak 中是八进制 101，在 prog.o 中是 141，则 cmp 命令显示：

    5 101 141

3. 要比较两个文件，而不写任何消息，请输入::

    cmp  -s prog.c.bak prog.c
    这样，如果文件相同，则给出值 0
    如果不同，则给出值 1
    如果发生错误，则给出值 2

    该命令形式通常用在 shell 步骤中。例如:
    if cmp  -s prog.c.bak prog.c
    then
    echo No change
    fi
    如果两个文件相同，则该部分的 shell 步骤显示 No change。








