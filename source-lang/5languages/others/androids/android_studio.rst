androidStudio使用
======================

新建工程项目后AS的Product目录结构如下::

   .idea：//AS生成的工程配置文件，类似Eclipse的project.properties。
   app：//AS创建工程中的一个Module。
   gradle：//构建工具系统的jar和wrapper等，jar告诉了AS如何与系统安装的gradle构建联系
   External Libraries：//不是一个文件夹，只是依赖lib文件，如SDK等

新建工程项目后AS的Module目录结构如下::

  build：//构建目录，相当于Eclipse中默认Java工程的bin目录，鼠标放在上面右键Show in Exploer即可打开文件夹，
          编译生成的apk也在这个目录的outs子目录，不过在AS的工程里是默认不显示out目录的，就算有编译结果也
          不显示，右键打开通过文件夹直接可以看。
  libs：//依赖包，包含jar包和jni等包。
  src：//源码，相当于eclipse的工程。
  main：//主文件夹
    java：//Java代码，包含工程和新建是默认产生的Test工程源码。
    res：//资源文件，类似Eclipse。
      layout：//App布局及界面元素配置，雷同Eclipse。
      menu：//App菜单配置，雷同Eclipse。
      values：//雷同Eclipse。
          dimens.xml：//定义css的配置文件。
          strings.xml：//定义字符串的配置文件。
          styles.xml：//定义style的配置文件。
          ......：//arrays等其他文件。
      ......：//assets等目录
    AndroidManifest.xml：//App基本信息（Android管理文件）
    ic_launcher-web.png：//App图标
  build.gradle：//Module的Gradle构建脚本



Android Studio构建系统基础
----------------------------
AS的工程根目录下的build.gradle文件::

  buildscript {       //设置脚本的运行环境
      repositories {  //支持java依赖库管理（maven/ivy等）,用于项目的依赖
          //mavenCentral()    //仅仅是不同的网络仓库而已
          jcenter()           //推荐使用这个仓库
      }
      //依赖包的定义。支持maven/ivy、远程、本地库、单文件
      //前面定义了repositories{}jcenter库，使用jcenter的依赖只需要按照
      //类似于com.android.tools.build:gradle:1.0.0-rc2，gradle就会自动的往远程库下载相应的依赖。
      dependencies {
          classpath 'com.android.tools.build:gradle:1.0.0-rc2'

          // NOTE: Do not place your application dependencies here; they belong
          // in the individual module build.gradle files
      }
  }
  //多项目的集中配置，多数构建工具，对于子项目的配置，都是基于继承的方式
  //Gradle除了提供继承方式设置子项目，还提供这种配置
  allprojects {
      repositories {
          jcenter()
      }
  }
  
AS的工程根目录下的settings.gradle文件::

  include ':app'      //module
  include ':my_lib'   //module(build as lib)

AS的工程根目录下的Module的build.gradle文件(此处以一个简单的Lib module的gradle为例)::

  //plugin在AS里取值一般为'com.android.library'或者'com.android.application'
  apply plugin: 'com.android.library' //构建为lib
  
  android {
      compileSdkVersion 17            //编译需要SDK版本
      buildToolsVersion "19.1.0"      //SDK Manager确定本地安装该版本才可以
      
      defaultConfig {
          minSdkVersion 8         //最小版本
          targetSdkVersion 17     //目标版本
      }
      
      buildTypes {                //编译项
          release {
              minifyEnabled false
              proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.txt'
          }
      }
  }

  dependencies {                  //依赖支持
      compile 'com.android.support:support-v4:18.+'
  }

Gradle打包APP签名::

  android {
     ......
     signingConfigs {
        myConfig{
           storeFile file("yanbober.keystore")
           storePassword "gradle"
           keyAlias "gradle"
           keyPassword "gradle"
        }
     }

     buildTypes{
        release {
           runProguard true
           zipAlignEnabled true
           // 移除无用的resource文件
           shrinkResources true
           proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'

           signingConfig  signingConfigs.myConfig
        }
     }
  }

Gradle构建Android应用多渠道包(批量打包)
------------------------------------------
在AndroidManifest.xml里配置所谓的PlaceHolder::

   <meta-data
      android:name="CHANNEL"
      android:value="${CHANNEL_VALUE}" />


在模块build.gradle文件的defaultConfig加上PlaceHolder，作用是声明CHANNEL_VALUE是可替换值的PlaceHolder，同时为其设置gordon默认值::

  android {
     ......

     defaultConfig {
        ......
        manifestPlaceholders = [ CHANNEL_VALUE:"gordon" ]
     }
     productFlavors {
        yanbober{}
        wandoujia{}
        xiaomi{}
        baidu{}
     }
     productFlavors.all { flavor ->
        flavor.manifestPlaceholders = [ CHANNEL_VALUE:name ]
     }
  }

  //进入工程目录下运行gradlew assembleRelease
  //可以看到编译一共产生了4个apk，分别对应在productFlavors段定义的4个渠道
  //用命令行单独生成xiaomi渠道使用gradlew assemblexiaomiRelease

  
摘自
------
http://blog.csdn.net/yanbober/article/details/45306483


Android SDK::

  //在线更新镜像服务器资源

  大连东软信息学院镜像服务器地址:
  - http://mirrors.neusoft.edu.cn 端口：80
  北京化工大学镜像服务器地址:
  - IPv4: http://ubuntu.buct.edu.cn/ 端口：80
  - IPv4: http://ubuntu.buct.cn/ 端口：80
  - IPv6: http://ubuntu.buct6.edu.cn/ 端口：80
  上海GDG镜像服务器地址:
  - http://sdk.gdgshanghai.com 端口：8000

  <COMMAND> + , //打开配置页面
  找到"Appearance & Behavior" -> "System Settings" -> Android SDK
  『HTTP Proxy Server」和「HTTP Proxy Port』输入框内填入上面镜像服务器地址和端口，并且选中『Force https://... sources to be fetched using http://...』复选框
  依次选择『Packages』、『Reload』


Disable Instant Run::

  // 实际遇到的问题,总出现安装好app后，打开就死掉,关掉这儿之后就好了
  // 据说,这个是热更新,加快修改后的编译速度的
  1.Open the Settings or Preferences dialog.
  2.Navigate to Build, Execution, Deployment > Instant Run.
  3.Uncheck the box next to Enable Instant Run.
  
