ca证书相关
##############

导入根证书
----------

证书系统安装::

    yum install ca-certificates
    apk add ca-certificates

证书操作 [1]_ ::

    // Mac OS X
    添加证书：
    $> sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain ~/new-root-certificate.crt
    移除证书：
    $> sudo security delete-certificate -c "<name of existing certificate>"

    // Linux (Ubuntu, Debian)
    添加证书：
    1.复制 CA 文件到目录： /usr/local/share/ca-certificates/
    $> sudo cp foo.crt /usr/local/share/ca-certificates/foo.crt
    2.更新 CA 证书库:
    $> sudo update-ca-certificates
    移除证书：
    1.Remove your CA.
    2.Update the CA store:
    $> sudo update-ca-certificates --fresh
    Restart Kerio Connect to reload the certificates in the 32-bit versions or Debian 7.

    // Linux (CentOs 6)
    添加证书：
    1.安装 ca-certificates package:
    yum install ca-certificates
    2.启用dynamic CA configuration feature:
    update-ca-trust force-enable
    3.Add it as a new file to /etc/pki/ca-trust/source/anchors/:
    cp foo.crt /etc/pki/ca-trust/source/anchors/
    4.执行:
    update-ca-trust extract
    Restart Kerio Connect to reload the certificates in the 32-bit version.

    // Windows
    添加证书：
    certutil -addstore -f "ROOT" new-root-certificate.crt
    移除证书：
    certutil -delstore "ROOT" serial-number-hex













.. [1] http://www.linuxdiyf.com/linux/26001.html