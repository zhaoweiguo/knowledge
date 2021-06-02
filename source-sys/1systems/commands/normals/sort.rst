.. _sort:

sort命令使用
#####################
* 作用: sort [-o <输出文件>] [-t <分隔字符>] [+<起始字段> - <结束字段>] [文件] 对文本内容排序

* 命令::

    sort [-o <输出文件>] [-t <分隔字符>] [+<起始字段> - <结束字段>] [文件]


选项::

   -n, --numeric-sort
   以数值的顺序排序，防止出现10<2的情况
   -r, --reverse
   排序反转
   -o
   sort -r number.txt -o number.txt    // 正确
   sort -r number.txt > number.txt     // 文件内容为空

   -k, --key=POS1[,POS2]
   
   -t, --field-separator=SEP
   设定分隔符
   -f, --ignore-case
   会将小写字母都转换为大写字母来进行比较，亦即忽略大小写
   

实例::

   sort     // 从小到大
   sort -r

   // 实例介绍 -t, -k选项
   $ cat facebook.txt
   banana:30:5.5
   apple:8:2.5
   pear:90:2.3
   orange:20:3.4

   $ sort -n -k 2 -t : facebook.txt   // 按:分隔,按第2个排序,按数字排序
   apple:8:2.5
   orange:20:3.4
   banana:30:5.5
   pear:90:2.3


统计文件中出现次数最多的前10个单词::

     cat words.txt | sort | uniq -c | sort -k1,1nr | head -10

     // 说明
     sort -k1,1nr:  按照第一个字段，数值排序，且为逆序
     



     
