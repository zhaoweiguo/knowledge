.. _zip:

zip/unzip命令
====================

* 解压::

    unzip FileName.zip
    unzip  -o -d /home/sunny myfile.zip
    // -o:不提示的情况下覆盖文件
    // -d:-d /home/sunny 指明将文件解压缩到/home/sunny目录下

* 压缩::

    zip FileName.zip DirName
    zip -r ../myfile.zip ./*  //压缩当前目录到上级目录的myfile.zip中

* 其他::

    zip -d myfile.zip smart.txt
    删除压缩文件中smart.txt文件
    zip -m myfile.zip ./rpm_info.txt
    添加rpm_info.txt文件到压缩文件中myfile.zip中
    
* 查看zip文件内容（不解压）::

    unzip -v <name>.zip 
