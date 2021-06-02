.. _android_requirement:

####################
系统需求(安装前准备)
####################

**操作系统支持**
    1. GNU C Library (glibc) 2.7 or later
        察看glibc版本方法::

            dpkg-query -l glibc*

    2. On Ubuntu Linux, version 8.04 or later
    3. 64-bit系统必须能运行32位应用,在64位系统下需要运行下面命令::

        sudo apt-get install ia32-libs

    4. 安装Java::

        sudo apt-get install sun-java6-jdk

    5. 安装Eclipse:
        见下面 **支持的开发环境**

**支持的开发环境**
    1. Eclipse 3.6 (Helios) or greater
    2. Eclipse JDT plugin(大多数eclipse都有)
    3. Eclipse下载地址: `这儿 <http://www.eclipse.org/downloads/>`_ , 开发应用最好使用如下包:
        * Eclipse IDE for Java Developers
        * Eclipse Classic
        * Eclipse IDE for Java EE Developers
            注:**推荐"Eclipse Classic"版本. 否则的话, 推荐使用一个Java or RCP 的Eclipse版本**
    4. JDK 5 or JDK 6 (不能只有JRE)
    5. Android 开发工具插件(推荐)
    6. 和GNU的java编译器不兼容(gcj)

**硬件需求**
    .. _table-1:

    .. csv-table:: 表1 各部件占硬盘空间
        :widths: 35 30 35
        :header: 部件类型, 占用空间, 备注

        SDK Tools,                   35 MB,    Required.
        SDK Platform-tools,          6 MB,     Required.
        Android platform (each),     150 MB,   At least one platform is required.
        SDK Add-on (each),           100 MB,   Optional.
        USB Driver for Windows,      10 MB,    Optional. For Windows only.
        Samples (per platform),      10M,      Optional.
        Offline documentation,       250 MB,   Optional.


