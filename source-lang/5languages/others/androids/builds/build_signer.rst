签名相关
==============

命令行下对apk签名::

  创建key，需要用到keytool (位于jdk1.6.0_24\jre\bin目录下)
  使用产生的key对apk签名用到的是jarsigner (位于jdk1.6.0_24\bin目录下)

产生密钥::

  keytool -genkey -alias demo.keystore -keyalg RSA -validity 40000 -keystore demo.keystore
  -genkey 产生密钥
  -alias demo.keystore 别名 demo.keystore
  -keyalg RSA 使用RSA算法对签名加密
  -validity 40000 有效期限4000天
  -keystore demo.keystore

签名::

  jarsigner -verbose -keystore demo.keystore -signedjar <signed>.apk <origin>.apk demo.keystore
  -verbose 输出签名的详细信息
  -keystore  demo.keystore 密钥库位置
  -signedjar demor_signed.apk demo.apk demo.keystore 正式签名
  三个参数中依次为签名后产生的文件demo_signed，要签名的文件demo.apk和密钥库demo.keystore

  // 另外方法,直接给指定apk签名,操作后原来未签名的文件变成签名文件
  jarsigner -digestalg SHA1 -sigalg MD5withRSA -keystore ./demo.keystore -storepass <pwd> -keypass <pwd> ./<name>.apk demo.keystore


签名之后，用zipalign(压缩对齐)优化你的APK文件::

  // 签名之后的apk谷歌推荐使用zipalign.exe(位于android-sdk-windows\tools目录下)工具对其优化
  zipalign -v 4 demo_signed.apk final.apk


签名对你的App的影响::

   App升级。 使用相同签名的升级软件可以正常覆盖老版本的软件，否则系统比较发现新版本的签名证书和老版本的签名证书不一致，不会允许新版本安装成功的
   App模块化。android系统允许具有相同的App运行在同一个进程中，如果运行在同一个进程中，则他们相当于同一个App，但是你可以单独对他们升级更新，这是一种App级别的模块化思路
   允许代码和数据共享。android中提供了一个基于签名的Permission标签。通过允许的设置，我们可以实现对不同App之间的访问和共享，如下
   AndroidManifest.xml：<permission android:protectionLevel="normal" />
   
   其中protectionLevel标签有4种值：normal(缺省值),dangerous, signature,signatureOrSystem
   normal是低风险的，所有的App不能访问和共享此App
   dangerous是高风险的，所有的App都能访问和共享此App
   signature是指具有相同签名的App可以访问和共享此App
   signatureOrSystem是指系统image中App和具有相同签名的App可以访问和共享此App,谷歌建议不要使用这个选项，因为签名就足够了,一般这个许可会被用在在一个image中需要共享一些特定的功能的情况下

