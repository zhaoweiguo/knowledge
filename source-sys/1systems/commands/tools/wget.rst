.. _wget:

wget命令
======================
选项::

  -P
   把下载的文件转移到Package目录::

       wget www.programfan.info/download/mysql/mysql-5.5.21.tar.gz -P packages/

  -i
   批量下载，把要下载的文件地址放到 ``filename.txt`` 文件中::

       wget -i filename.txt

  -c
   断点续传:

       wget -c http://blog.programfan.info/abc.iso

* 下载网站上abc目录下的所有文件。其中， ``-np`` :不遍历父目录； ``-nd`` : 不在本机重新创建目录结构::

    wget -r -np -nd http://blog.programfan.info/abc/

* 和上面命令一样，不过只是下载 ``.iso`` 文件::

    wget -r -np -nd --accept=iso http://blog.programfan.info/abc/

* 镜像一个网站，wget将对链接进行转换，如果网站的图像是放在另外的站点，可以使用 ``-H`` 选项::

    wget -m -k (-H) http://blog.programfan.info





