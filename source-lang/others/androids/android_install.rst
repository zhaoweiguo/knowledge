安装步骤
########

下载SDK Starter包::

    * SDK starter包不是一个完整的开发环境(它只包含核心的SDK工具，你可以用它来下载最新的SDK部件[如最新的android平台])。
    * 下载地址: `SDK Starter包下载地址 <https://developer.android.com/sdk/index.html>`_
    * 解压包文件 ``android-sdk-<machine-platform>``
    * **记住SDK在你系统中的名字和目录** (在安装ADT插件或在命令行下用SDK工具)

为Eclipse安装ADT(Android Development Tools)插件::

    1. 下载ADT插件:
        * 启动eclipse选择 ``Help > Install New Software...``
        * 点击 **Add**
        * 在 ``Add`` 对话框中，在Name框中输入 ``ADT Plugin`` ,在对应的URL中输入::

            https://dl-ssl.google.com/android/eclipse/

        * 点击 **OK**
            注:如果在获取插件时出现问题，可以把https换成http再测试
        * 在Available Software对话框中，选中开发工具前的复选框，然后点击 **Next**
        * 在下一个对话框中你可以看到要下载的工具列表，点击 **Next**
        * 读取开源协议，点击 **Finish**
            注意:你可能会遇到软件不能认证或确认不能建立的对话框，点击**OK**
        * 安装完成，重启eclipse

    2. 配置ADT插件
        按上面描述下载ADT成功后，下一步就是修改eclipse中ADT的属性，步骤如下:

        * 选择 ``Window > Preferences...`` ,打开属性面板
        * 在左边面板树上选择 **Android** ，这儿你会遇到一个对话框(选择不帮助google[邪恶一下],这个对话框只会出现一次,如果你之后想改变，重现命令为: ``File > Preferences > Usage Stats`` )，然后点击 **Proceed**
        * 在主面板 *SDK Location* ，点击 **Browse...** ，选择你之前安装的SDK目录
        * 点击 **Apply** , 然后点击 **OK**

增加平台或其他组件::

    用 *Android SDK and AVD Manager* (SDK starter包的一个工具)安装SDK的最后一步是: 下载必须的SDK组件到你的开发环境中。
    SDK模块化结构，每个目录存放对应的内容:

        * Android platform versions
        * add-ons
        * tools
        * samples
        * documentation

    我们上一节已经说过了，下载的 *SDK starter包* 只有最新的SDK工具。 为开发一个android应用，你需要下载至少一个 *Android platform* 并相关 *platform tools* 。建议你也下载其他的组件和平台。
    你可以用如下两种方法中有一种来打开 **Android SDK and AVD Manager**

        * Eclipse方式: ``Window > Android SDK and AVD Manager``
        * 命令行方式:首先进入Android SDK目录，运行::

            ./tools/android

执行如上命令后，会打开 **Android SDK and AVD Manager** 管理页面，见下图:

.. figure:: /images/languages/androids/android_SDK_and_AVD_Manager.png
   :width: 100%

可用组件(Available Components)::

    默认SDK有两个资源库: *Android资源库(Android Repository)* 和 *第三方插件(Third party Add-ons)*

    1. *Android资源库(Android Repository)* 提供以下几种内容的组件:

        * **SDK工具(SDK Tools)** : 存放用于应用调试、测试或其他实用工具。这些工具是和 *Android SDK starter包* 一起安装并接受定期更新。本地目录地址为: ``<sdk>/tools/`` , `详情察看SDK Tools开发指南(developer guide) <http://developer.android.com/guide/developing/tools/index.html#tools-sdk>`_
        * **SDK平台工具(SDK Platform-tools)** :存放开发和调试应用的平台信赖工具。这些工具支持 *Android platform* 最新特征并且只有在有一新平台可用时才更新。本地目录地址为: ``<sdk>/platform-tools/`` , `详情察看SDK Platform-tools开发指南(developer guide) <https://developer.android.com/guide/developing/tools/index.html#tools-platform>`_
        * **Android平台(Android platforms)** :就是一个Android平台的虚拟机。里面有齐全的Android库，系统图片，事例代码，模拟器皮肤。
        * **USB Driver for Windows**:只用于windows中
        * **Samples**
        * **Documentation**

    2. 第三方插件:
        第三方的扩展( *Third party Add-ons* )提供你可以创建开发环境[用一个指定Android扩展库(如Google Maps库)或个性化的Android系统图片]。你可以点击 **Add Add-on Site** 来增加第三方资源库(当然是在 *Android SDK and AVD Manager* 对话框中点击)。


**推荐组件(Recommended Components)**
    SDK仓库(repository)包含你下载的一系列组件。用下面的表来展示你需要环境三种级别及各级别对应所需的组件，分别是基本环境、推荐环境和开发环境:
      1. 基本环境

       .. _install-1:    
       .. csv-table:: [install-1]Android基本环境
           :widths: 20 80
           :header: SDK 组件, 简介

           SDK工具,     如果你安装过SDK starter package，你就已经有了这个组件最新版本了。注意:要保持这个组件最新
           SDK平台工具, 这儿包含你应用开发时更多的工具。它是平台信赖的，你可以用这儿的工具来安装下面的SDK平台。注意:不同的SDK平台需要通过不同的SDK平台工具生成
           SDK平台,     你需要至少下载一个SDK平台来编译你的应用并安装AVD。

      2. 推荐环境

        .. _install-2:
        .. csv-table:: [install-2]Android推荐环境
            :widths: 20 80
            :header: SDK 组件, 简介

            文档,        离线文档
            实例, 
            Usb驱动,      windows专用

      3. 全部环境

        .. _install-3:
        .. csv-table:: [install-3]Android全部环境
            :widths: 20 80
            :header: SDK 组件, 简介

            Google APIs,        进入Maps external library的API
            附加SDK平台,        如果你计划发布你的应用，你可能要下载你的应想要运行的Android其他版本的平台(在Android基本环境中，有一个必须的SDK平台)。建议:在你应用打算支持的最低版本的平台上编译，然后在你打算支持的最高版本上进行测试。


**探索SDK(可选)Exploring the SDK (Optional)**
    你按上面步骤操作完成之后，建议你看下SDK目录里面都有什么东东，下面这个表展示了SDK目录中各子目录(文件)中包含的内容:

      .. csv-table::
          :widths: 20 80
          :header: 目录名, 描述

          add-ons/,        Android SDK开发环境的附加环境
          docs/,           离线文档
          platform-tools/, 平台工具
          platforms/,      平台集，下面是你下载的几个平台
          samples/,        实例






 To simplify ADT setup, we recommend installing the Android SDK prior to installing ADT.

