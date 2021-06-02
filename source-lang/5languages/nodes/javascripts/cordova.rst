cordova基本操作
########################

安装::

    sudo npm install -g cordova
    npm info cordova


基本命令::

    cordova create hello com.example.hello HelloWorld
    cordova platform add <platform>
    cordova platform remove/rm <platform>

    cordova platforms ls
    cordova plugin ls

    cordova build
    cordova build <platform>
    // cordova build is short for the two following command
    cordova prepare <platform>
    cordova compile <platform>

    cordova emulate android
    cordova run android

Add Features::

    cordova plugin add <plugin>
    // 实例:
    cordova plugin add org.apache.cordova.device   // Basic device information

    cordova plugin rm/remove <plugin>
    cordova plugin ls







