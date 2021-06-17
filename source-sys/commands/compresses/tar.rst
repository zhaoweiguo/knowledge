.. _tar:

tar命令
============


tar -c|x|u|r|t[z|j][v] -f <归档文件> [未打包文件]
将多个文件打包为一个归档文件, 可以在打包的同时进行压缩。支持的格式为 tar(归档)、gz(压缩)、bz2(压缩率更高,比较耗时)、zip [参数] <压缩包> <源文件>

::

    -f: 表示强迫创建归档，即如果已经有一个同名文件，它会被替换
    -c表示创建一个归档
    -v表示交互，即命令更具交互性
    -z表示使用gzip滤波器
    -X表示含在指定文件名列表中的文件会被排除在备份之外
    -t, --list: list the contents of an archive
    -f, --file=ARCHIVE:use archive file or device ARCHIVE

* 解压到指定目录::

    tar -C <folder> -zxf <file>.tar.gz


* 查看压缩文件内容::

    tar --list --verbose --file=<tarname.tar.gz> | less

* 把解压后的文件释放到指定目录::

    tar zxvf test.tar.gz -C folder/

* .tar

    * 解包::

        tar xvf FileName.tar

    * 打包::

        tar cvf FileName.tar DirName

（注：tar是打包，不是压缩！）


* .tar.bz2

    * 解压::

        tar jxvf FileName.tar.bz2

    * 压缩::

        tar jcvf FileName.tar.bz2 DirName


* .tar.bz

    * 解压::

        tar jxvf FileName.tar.bz

    * 压缩:未知


* .tar.Z

    * 解压::

        tar Zxvf FileName.tar.Z

    * 压缩::

        tar Zcvf FileName.tar.Z DirName



* 排除某个文件(这儿是 ``*~``)::

    tar zcvf <fileName>.tar.gz <sourceList> -X *~



