apk反编译
================

重新签名apk::

   1.unzip -d <folder> <name>.apk    //解压apk文件到目录
   2.删除目录中的META-INF目录（里面有加密信息）
   3.zip -r ../<newname>.apk ./*
   or
   zip -d <name>.apk META-INF   // 直接从此压缩文件中删除指定文件夹
   
   4.jarsigner -verbose -keystore demo.keystore -signedjar <signed>.apk <origin>.apk demo.keystore   // 重新签名
   5.adb install <signed>.apk

反编译1::

  1.unzip -d <folder> <name>.apk    //解压apk文件到目录
  2.找到xxxx.dex文件,并用dex2jar项目中的d2j-dex2jar.sh命令把dex文件转化为jar文件
  3.使用jd-gui项目打开jar包可以看到jar包里的class文件对应的java文件
  //注:以下步骤可行性不高
  4.把其中的class文件转为java文件,修改里面内容再转为class文件
  5.重新生成jar包,再用dex2jar项目中的d2j-jar2dex.sh命令把jar文件转化为dex文件
  6.zip重新打包成apk文件并加签名


反编译::

  1.apktool d testapp.apk
  



http://jd.benow.ca/   Java Decompiler
http://sourceforge.net/projects/dex2jar   dex2jar
http://varaneckas.com/jad/    jad(Java Decompiler Download)可以把class转为java
