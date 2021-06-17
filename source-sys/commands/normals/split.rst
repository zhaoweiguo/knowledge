.. _split:

split命令使用
===================

split <源文件> [目标文件名前缀]
将源文件按一定规则分割成若干个目标文件。默认文件名前缀为x::

     -<行数> 按行数分割文件
     -l <行数> 同上
     -b <字节> 按大小分割文件。可以使用 b、k、m 作单位,不指定单位的情况下,默
     认单位为 b
     -C <字节> 按大小分割文件,并尽量保持每行的完整

示例::

     split -C 100k file.split x


按行数分割::

  split -l 300 access.log new_file_prefix


按字节大小分割::

  split -b 10m access.log new_file_prefix

 




