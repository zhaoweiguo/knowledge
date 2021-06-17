.. _os_aptitude:

aptitude使用快速参考
======================

概述:

    aptitude 与 apt-get 一样，是 Debian 及其衍生系统中功能极其强大的包管理工具
    aptitude 是 Debian GNU/Linux 系统中, 非常神奇的的软件包管理器, 基于大名鼎鼎的 APT 机制, 整合了 dselect 和 apt-ge2 的所有功能, 并提供的更多特性, 特别是在依赖关系处理上


认识aptitude命令的CUI界面::

   输入命令:
   aptitude

如图:

  .. figure:: /images/linuxs/linux_os_ubuntu_aptitude_1.png
     :width: 80%

区域功能::

  第一行：是菜单栏
  第二行：显示操作提示：【C-T】(打开菜单)、 【?】(帮助手册)、【q】(退出)、【u】(更新源列表)、【g】(执行操作)
  第三行：显示aptitude软件版本
  第四行：软件列表
  第五行：信息框，可以用【a】和【z】实现滚屏，【i】在不同信息视图间切换，【D】则用于显示和隐藏信息区。

软件列表项::

  Security Updates(安全更新)
    系统漏洞补丁包
  Updated Packages(有升级的软件包)
    本机安装的软件包中有新的版本。
  New Packages（新增软件包）
    更新（【u】）软件库列表后所增加的软件包，让用户了解 Debian 软件库增加了哪些软件，您可以键入【f】将其清除显示;并将它们集合到软件库中。
  Installed Packages(已安装软件包) 
    这些软件包已经安装在您的机器上。
  Not Installed Packages(尚未安裝的软件包)
    这些软件包当前没有安装在您的机器上。
  Obsolete or Locally Created Packages(废弃或本地创建的软件包)
    这些软件包目前已安装在您的机器上;但是它们并未出现在APT软件库中。
  Virtual Packages(虚拟包)
    虚拟包是由一些软件包提供的逻辑概念。例如，mail-transport-agent 就是由 postfix 和 sendmail，以及其它等等软件包提供的。
  Tasks(任务)
    任务是一组软件包，它们提供了一种简单的方法来选择一组预定义的，完成特定任务的软件包。

supertux-data软件包,软件列表中每一项的意思::

    1、：v虚拟 B损坏 u解包 C预配置 H预安装 c卸载 p未安装（即清除） i已经安装 E内部错误（软件当前的状态，如i表示本机已经安装，p表示这个软件未在本机安装）
    2、：h保持 p清除(完全卸载) d删除(卸载) B损坏 i安装 r重装 u升级(这里是重点，这里的标记表示你将要干什么。例如i表示你将要安装这个软件)
    3、：自动手动设置，显示A的软件是由于依赖关系系统自动安装的，没有显示A的软件是手动安装的。
    4、：显示U表示软件源中的包比本机安装的包版本更新。

aptitude命令的简单操作介绍::

  基本操作:

    q(quit): 退出
    ?(help): 帮助信息
    u 类似于: apt-get update 操作
    f(forget that packages are new): 将它们列入到可用软件包中去
    i: 查看更详细的信息介绍

  软件包查询:

    /: 搜索软件包
    \: 反向搜索软件包
    l: 以某种标准限制软件包显示在窗口中


.. _table_os_ubuntu_aptitude-1:

.. csv-table:: aptitude用于搜索的关键字
   :widths: 10 90
   :header: 关键字, 用途

   ^, 匹配起始字符
   $,  匹配结束字符
   ~ahold,   保持现有版本的软件包
   ~b,       损坏的软件包
   ~d< text>,        描述中含有< text>内容
   ~g,  无用的软件包
   ~m< maint>,       由< maint>维护的软件包
   ~n< text>,        名称中含有< text>的软件包
   ~V< version>,     版本号中含有< version>的软件包

注::

  以上关键字可以组合使用: 
  ``~ahold~dmail`` 逻辑与(AND), 
  ``~v|~b`` 逻辑或(OR), 
  ``!~b`` 逻辑非(NOT)
  再注: 查询不会忽略两个关键字间的空格，请务必注意

软件包标记与执行(选择软件包，然后按下对应键进行标记):

.. _table_os_ubuntu_aptitude-2:

.. csv-table:: 软件包标记与执行
   :widths: 10 90
   :header: 操作,说明

       【+】,   选定要安装的软件包
       【-】,   选定要删除的软件包
       【_】,   选定要清除的软件包
       【=】,   保持软件包的当前版本;阻止其被升级
       【:】,   仅在aptitude会话期间锁定软件包.
       【L】,   请求重装软件包.
       【M】,   将软件包标记为自动安装. 自动安装的软件包在手动安装的包对其没有依赖需求时会自动删除.
       【m】,   将软件包标记为手动.
       【R】,   请求重新配置软件包.
       【I】,   请求立即安装软件包（以其依赖包）并暂时锁定其它升级和安装的软件包.
       【F】,   禁止安装某个版本的软件包.但是;对更高版本正常使用.
       【B】,   调用reportbug;申报一个软件包的错误.
       【C】,   下载并显示一个软件包的变更日志.
       【d】,   查询相关软件包: suggest/recommanded/depends
       【r】,   查询依赖包

注::

  Ctrl】+【u】组合键可用于取消上一步的动作
  再注:  当你标记好后，【g】会进入预览窗口，此时你还是可以编辑，再次【g】将执行操作

名词解释:

.. _table_os_ubuntu_aptitude-3:

.. csv-table:: 名词解释
   :widths: 20 80
   :header: 名词, 解释

       受损的软件包, 不能满足依赖关系的;或相互冲突的软件包。
       卸载和完全卸载,       卸载是删除软件程序，但保留其配置文件；完全卸载则是全部删除。
       虚拟包, 有时候，软件包可能需要其它必需选择的软件包提供一个概念。这种需求的一个典型例子可以在软件包的关联信息中找到。at被设计为依赖能发送电子邮件的程序。在Debian中，有不下十种邮件传输代理软件，并不是写死到at的依赖信息中，软件包只是简单的通过依赖于概念包mail-transport-agent 来实现。提供了所需功能的软件包都声明提供了这种概念，在Debian中，是通过所谓的“虚拟包”来实现的。在系统中安装了任意一个提供了mail-transport-agent虚拟包的软件包，Debian软件包工具都认为满足了依赖关系。
       任务的概念, 一个Debian系统通常用于完成某些任务。比如，您可能把它作为您的桌面系统，或数据库服务器，或 web 服务器，邮件服务器等等。Debian 提出的任务的概念是指满足某种需求的一系列典型的软件包；上边的任务，您可以通过安装一系列的软件包，来分别构建一个相应的服务器，或一个桌面环境。


命令行::

    aptitude提供了一个有趣的命令行模式，可以作为一个基本的嵌入模式来取代 apt-get 并具有 apt-cache 的查询能力，
      并在 aptitude 的交互接口增加了搜索判断。
    aptitude的命令行请求形如下:

        # aptitude action [arguments...]
        常用的一些操作:
        # aptitude update * 更新软件包列表, 同图形界面的[u]键 * 
        # aptitude upgrade * 升级软件包, 等同与 apt-get upgrade * 
        # aptitude dist-upgrade *升级系统, 等同与 apt-get dist-upgrade * 
        # aptitude [ install | remove | purge ] pkg1 [pkg2...] * …* 
        # aptitude search pattern1 [pattern2...] * …*

    就象 apt-get，可以在交互界面使用拼接字符将多个不同的查询动作置于同一命令行中。
    下面的情况中，安装A，删除B，清除C，保持D，’+’是冗余的，因为默认为安装:

        # aptitude install A+ B- C_ D=

aptitude命令的操作日志::

    aptitude将您所有的请求动作写入/var/log/aptitude。这个文件可以方便的用于安装和删除软件的跟踪。
    如果您使用apt-get 安装软件，用dpkg卸载软件，aptitude的日志很快就会同步。
    另外，aptitude只记录请求。如果某一动作失败了，它是不会记录的。










