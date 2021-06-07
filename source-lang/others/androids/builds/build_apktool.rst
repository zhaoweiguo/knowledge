apktool命令
=================
解压(d or decode)::

   // 解压foo.jar文件到foo.jar.out目录下
   $ apktool d foo.jar
   // 解压到bar目录下
   $ apktool d bar.apk
   // 解压到baz目录下
   $ apktool d bar.apk -o baz
   

Building(b or build)::

  // 把目录foo.jar.out编译到foo.jar.out/dist/foo.jar下
  $ apktool b foo.jar.out
  // 编译出bar/dist/bar.apk文件
  $ apktool b bar
  $ apktool b bar -o new_bar.apk
  // 把当前目录build到./dist中
  $ apktool b .

Frameworks(if or install-framework)()::

  // APP使用一些os的代码或资源统称为framework resources
  //正常这些文件apktool都是能正常使用的,但

  //当你想从htc设备decode文件HtcContacts.apk时,你会得到错误
  Can't find framework resources for package of id: 2.
  You must install proper framework files, see project website for more info.
  //你需要在decode文件HtcContacts.apk前先get HTC framework resources
  $ adb pull /path/com.htc.resources.apk
  $ apktool if com.htc.resources.apk
  //现在再编码就ok了

  //Frameworks位置
  大都在/system/framework
  部分在/data/system-framework or /system/app or /system/priv-app目录下
  一般命名都有"resources", "res" or "framework"


  //增加两参数
  // -p, --frame-path <dir> - Store framework files into <dir>
  // -t, --tag <tag> - Tag frameworks using <tag>
  $ apktool if framework-res.apk
  

其他::

  // debug模式decode
  $ apktool d -d -o out app.apk
  //debug模式下build新的apk
  $ apktool b -d out
  


  

  
   
http://ibotpeaches.github.io/Apktool/documentation/   
https://github.com/iBotPeaches/Apktool

