.. _compress_other:

其他压缩命令
==================

* .xz

    * 解压::

        xz -d FileName.tar.xz  //结果为FileName.tar


* .Z

  * 解压::

      uncompress FileName.Z

  * 压缩::

      compress FileName


* .lha

  * 解压::

      lha -e FileName.lha

  * 压缩::

      lha -a FileName.lha FileName

  * lha请到：http://www.infor.kanazawa- it.ac.jp/~ishii/lhaunix/下载！解压后请将lha拷贝到/usr/bin目录(其他由$PATH环境变量指定的目录也可以)::

    [root@www2 tmp]# cp lha /usr/bin/


* .rpm

    * 解包::

        rpm2cpio FileName.rpm | cpio -div




