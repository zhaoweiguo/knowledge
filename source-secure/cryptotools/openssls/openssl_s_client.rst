openssl s_client命令
########################

::

    openssl s_client -connect gateway.sandbox.push.apple.com:2195 -cert PushChatCert.pem -key PushChatKey.pem

    // 指定使用ssl3协议
    openssl s_client -connect 127.0.0.1:5000 -ssl3
    // 指定使用tls1协议
    openssl s_client -connect 127.0.0.1:5000 -tls1

证书信息 certificate/intermediate/root ca::

    $ openssl x509 -in example.com.crt -text -noout

key 信息::

    $ openssl rsa -in example.com.key -check 


证书有效期
==========

查看域名使用证书有效期::

    $ echo | openssl s_client -servername blog.zhaoweiguo.com -connect blog.zhaoweiguo.com:443 2>/dev/null | openssl x509 -noout -dates

批量验证证书有效期::

    #!/bin/bash

    domains='
    sentry.google.com
    console.google.com
    www.google.com
    m.google.com
    api.google.com
    '

    for domain in $domains
    do
      check_result=$(echo | openssl s_client -servername $domain -connect $domain:443 2>/dev/null | openssl x509 -noout -dates | grep After)
      echo "$domain\t $check_result" | awk -F"\t" '{sub(/^ /,"",$2);printf "%-40s%s\n",$1,$2}'
    done

或者通过第三方工具检查:
* https://www.ssllabs.com/ssltest/analyze.html
* https://whatsmychaincert.com/?jpuyy.com

检查 p12 证书过期时间::

    1. 先转为证书
    $ openssl pkcs12 -in certificate.p12 -out certificate.pem -nodes
    2. 验证过期时间
    $ cat certificate.pem | openssl x509 -noout -enddate



参考
====

* openssl shell 检验 ssl 证书过期时间: https://jpuyy.com/2017/05/openssl-%E6%A3%80%E9%AA%8C-ssl-%E8%AF%81%E4%B9%A6%E8%BF%87%E6%9C%9F%E6%97%B6%E9%97%B4.html


