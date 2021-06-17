cat命令
-------------
cat <文件名>
输出文件内容。用空格分隔多个文件名,可以将多个文件内容连接到一起输出。使用复位向合并为一个文件::

     -n 在输出中添加行号
     -b 在输出中添加行号,空行不编号
     -s 将两行或以上的空行,合并为一个空行

示例::

     cat xaa xab xac > file.split

     cat << EOF > newfile.txt
        > content1
        > content2
        > EOF

给所有输出加上行号::

   cat -n file.txt

