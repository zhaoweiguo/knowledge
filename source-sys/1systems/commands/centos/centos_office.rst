.. _centos_office:

office及中文输入法安装
#################################

查询是否安装openoffice::

    #rpm -qa openoffice*        查询是否已经安装openoffice包

若没有出现任何信息则说明没有安装office包。
安装组件及中文包::

    #yum install openoffice.org-writer                  文本文档的安装
    #yum install openoffice.org-impress                演示文稿的安装
    #yum install openoffice.org-calc                     电子表格的安装
    #yum install openoffice.org-Draw                   绘图工具安装
    #yum install openoffice.org-Math                   公式工具的安装
    #yum install openoffice.org-Base                   数据库的安装
    #yum install openoffice.org-langpack-zh_CN.i686   安装中文包

中文输入法::

    #yum list ibus                                 列出ibus的包信息
    #yum list ibus-pinyin                      列出拼音输入法的包信息
    #yum install ibus   ibus-pinyin         安装输入法的框架ibus及拼音输入法




