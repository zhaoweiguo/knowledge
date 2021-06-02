centos桌面相关
===================

中文环境::

    yum -y groupinstall chinese-support
    %% 修改/etc/sysconfig/i18n
    %% 将LANG修改为LANG="zh_CN.UTF-8"
    %% 重启，生效



如何解决centos系统汉字乱码问题(?????)::

    yum -y install fonts-chinese
    yum install fonts-chinese.noarch # 安装中文字体
    sudo yum install fonts-ISO8859-2-75dpi.noarch # 字体显示包




**输入法安装**

    * 使用yum group "Chinese Support"::

        yum groupinfo 'Chinese Support'
        // 如没有安装使用如下命令安装
        yum groupinstall 'Chinese Support'

    * 安装中文支持::

        yum install fonts-chinese
        yum install fonts-ISO8859-2

    * 安装scim中文输入法::

        yum install scim
        yum install scim-pinyin
        yum install scim-tables
        yum install scim-tables-additional
        yum install scim-tables-chinese
        reboot





    