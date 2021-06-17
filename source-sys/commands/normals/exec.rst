.. _exec:

exec命令
###############


linux专用实例
------------------
::

    * 在当前目录下(包含子目录)，查找所有txt文件并找出含有字符串"bin"的行::

        find ./ -name "*.txt" -exec grep "bin" {} \;

    * 在当前目录下(包含子目录)，删除所有txt文件::

        find ./ -name "*.txt" -exec rm {} \;

    * 把目录folder下(包含子目录)的html文件打包::

        find <folder>/ -name "*.html" -type f -exec tar zcvf <abc>.tar.gz {} \;

    * 把目录folder下(包含子目录)的html文件拷贝到文件夹folder2中::

        find <folder>/ -name "*.html" -type f -exec cp {} <folder2>/ \;


* 替换相关功能::

    实例一:
    把当前目录下(包含子目录)的文件中的 ``($session[0]['id']`` 修改为 ``($session[0]['user_id']``
    find . -type f -exec sed -i "s/(\$session\[0]\['id']/(\$session\[0]\['user_id']/g" {} \;

    实例二:
    把文件中的class前面都加个回车
    find . type f -exec sed -i "s/class/\nclass/g" {} \;


mac专用实例
------------------

* 替换相关功能::

    实例一:    
    把当前目录下(包含子目录)的文件中的 ``($session[0]['id']`` 修改为 ``($session[0]['user_id']``
    //特例：mac os下sed多一个参数。原因是必须要备份一下原文件，创建存盘到"recordTxt"
    find . -name "txt[0-9].txt" -exec sed -i "recordTxt"  's/[0-9]/replace/g' {} \;
    //会在修改的文件后面加上recordTxt,如:
    // mysql.txt会变为mysql.txtrecordTxt

    实例二:
    把文件中的class前面都加个回车
    find . type f -exec sed -i "recordTxt" 's/class/\'$'\nclass/g' {} \;
    // \n改为\'$'\n代替回车














