xargs命令
############
将前一个命令的标准输出传递给下一个命令，作为它的参数
xargs的默认命令是echo

xargs与管道|的区别::

  | 用来将前一个命令的标准输出传递到下一个命令的标准输入
  xargs 将前一个命令的标准输出传递给下一个命令，作为它的参数

xargs与exec的区别::

  1.exec参数是一个一个传递的，传递一个参数执行一次命令
  xargs一次将参数传给命令，可以使用-n控制参数个数
  2.exec文件名有空格等特殊字符也能处理
  xargs不能处理特殊文件名，如果想处理特殊文件名需要特殊处理


-d, -n选项::

  -d: 指定分隔符, 默认按「空格」分隔
  -n: 指定一行显示个数
  % 按:分隔,每行显示3个
  $> echo "a:b:c:d:e" | xargs -d : -n 3
  a b c
  d e

-p选项::

  输出即将要执行的完整的命令,询问是否执行
  执行输入y
  否则输入n
  注: 主要用于检查命令是否正确

-0 选项::

  表示以 '\0' 为分隔符，一般与find结合使用
  % -print0: find输出的每条结果后面加上 '\0' 而不是换行
  $> find . -name "*.txt" -print0 | xargs -0 echo 

  % 统计目录中所有php文件列表中每个文件的行数
  $>find . -type f -name "*.php" -print0 | xargs -0 wc -l


-I选项::

  -I:指定一个替换字符串{}
  $> cat arg.txt
  aaa
  bbb
  ccc
  $> cat arg.txt | xargs -I {} ls -p {} -l
  等同于执行以下3条命令
  ls -p aaa -l
  ls -p bbb -l
  ls -p ccc -l



其他::

  -E 选项(有的系统的xargs版本可能是-e  eof-str)::

  只会将-e指定的命令行参数之前的参数(不包括-e指定的这个参数)传递给xargs后面的命令
  注: 指定-d选项时，此选项失效

实例::

  % 如有src目录下有子目录, 在apps/octopuscloud/src中也新建目录
  find src/ -name *.erl | xargs -I {} dirname {} | xargs -I {} mkdir -p apps/octopuscloud/{}
  % 把src目录下各级目录下的所有.erl文件，移动到 apps/目录下，并保持原目录结构不变
  find src -name *.erl | xargs -I {} mv {} apps/octopuscloud/{}


  % 查找所有的jpg 文件，并且压缩它们：
  $> find . -type f -name "*.jpg" -print | xargs tar -czvf images.tar.gz

  % 假如你有一个文件包含了很多你希望下载的URL，你能够使用xargs下载所有链接：
  cat url-list.txt | xargs wget -c

  % 删除指定进程
  ps aux |grep "device_attribute_update" |grep tmp | awk -F' ' '{print $2}' | xargs  -I {} kill {}

  % 把所有的压缩文件解压出来
  ls *.rar | xargs -I {} unrar x -o- -y {}













