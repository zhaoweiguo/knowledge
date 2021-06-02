---
title: 网站证书过期导致的一系列问题
date: 2019-01-12 13:22:09
categories:
- question
tags:
- 证书
- ECC
- question
---

## 前言

谷歌提议将证书有效期缩短到13个月，被其他CA和浏览器厂商无情拒绝，但缩短有效期是人心所向
于是，CAB Forum第193号投票确定最长SSL证书有效期由原来的3年(39个月)改为2年(825天)

## 问题描述

这一个项目是物联网相关的，有app和硬件设备两种类型的client
因历史原来，两种client用的是一个域名，都使用了ssl证书
证书有效期可能很长，但最近到期了
因为设备没办法强制升级，一是设备可能没联网，二是有些设备还没销售出去，三是设备没有用ca对证书校验
于是解决方案是，app强制升级，升级后使用新域名，新证书
但到了域名过期那天，才发现这么一个问题:

```
    之前宣传部门印制了许多二维码，用的是原来老域名
    所以这些二维码现在不可用了
```

当然，以后二维码使用专门的短域名、app和设备域名不应该用同一个……
未来如何做是另一码事，现在要想如何解决问题

要想达到的结果是:

```
    在不影响设备使用的前提下，让一指定uri可用
```

举例说明:

```
    1.如有一个域名www.abc.com，给硬件设备用，也给app用
    2.最近域名证书过期了，要换证书，但硬件设备没法保证用户升级，于是让app强制升级启用新域名
    3.但有一批二维码，已经发出去了，请求地址为: www.abc.com/a/b/c
```

现在想有没有方法，让:

```
    1.www.abc.com/a/b/c 使用新证书，或不用证书，只要在浏览器中打开就行
    2.www.abc.com其他地址使用老证书，保证设备的可用
```

## 问题解决方案

#### 方案1:双证书方案

原理:

```
    Nginx支持ECC、RSA双证书. 
    ECC签个最新的，保障较新设备能够正常访问
    RSA依旧保留过期的旧证书，给未更新的设备访问

    1.设备使用的一般是乐鑫ESP8266或庆科EMW3162的板子实现ssl
        而这些板子下的ssl库一般都不支持ECC
    2. 除非很古老的浏览器，其他都支持ECC

    所以使用Nginx判断:
      如果支持ECC则使用新的ECC证书
      如果不支持ECC则使用老的RSA证书
```

说明:
  
    Windows XP 中，使用 ECC 证书的网站时需要浏览器自行 TLS
    Android 平台中，也需要 Android 4+ 才支持 ECC 证书

如果此方案能生效，可以保证:

    1.所有的请求都可以完美成功
    2.甚至都不需要更换域名

#### 方案2:使用openResty

原理:

```
    1.所有的设备请求第1次失败后会再次请求
    2.证书错误时，请求快速失败

    所以在openResty中做一个k/v表
    第一次请求给他返回新证书，并以ip为key插入一条数据，5秒失效
    第二次请求过来，一查k/v表，有数据，返回老证书
```

说明:

    此方案会有一定误杀的情况

#### 结论

我们的设备中有一部分用带有OS的系统，是支持ECC的
这些设备对我们来说是很重要的，所以最后我们采用了方案2


## 双证书的一些简单操作

生成证书:

```
    openssl ecparam -genkey -name prime256v1 -out 证书名.key
    openssl req -new -key 证书名.key -nodes -out 证书名.csr
    例:
    openssl ecparam -genkey -name prime256v1 -out www.zhaoweiguo.com.key
    openssl req -new -sha256 -key www.zhaoweiguo.com.key -nodes -out www.zhaoweiguo.com.csr
```

Nginx配置双证书rsa+ecc:

```
    # 它的实现原理是:
    # 分析在 TLS 握手中双方协商得到的 Cipher Suite
    # 若支持 ECDSA 就返回 ECC 证书，反之返回 RSA 证书
    server{
        listen 443 ssl;
        server_name www.zhaoweiguo.com;
        root /var/www/zhaoweiguo.com/www.zhaoweiguo.com;
        index index.php index.html;

        ssl_certificate  /home/wei64/www.zhaoweiguo.com.crt;
        ssl_certificate_key  /home/wei64/nginx/ca/www.zhaoweiguo.com.key;

        ssl_certificate  /home/wei64/nginx/ca/www.zhaoweiguo.com.ecc.crt;
        ssl_certificate_key  /home/wei64/nginx/ca/www.zhaoweiguo.com.ecc.key;

        ssl_prefer_server_ciphers on;
        ## Cipher Suites 一定要配置好，不然双证书并不会生效
        ssl_ciphers "EECDH+CHACHA20:EECDH+CHACHA20-draft:EECDH+ECDSA+AES128:EECDH+aRSA+AES128:RSA+AES128:EECDH+ECDSA+AES256:EECDH+aRSA+AES256:RSA+AES256:EECDH+ECDSA+3DES:EECDH+aRSA+3DES:RSA+3DES";
    }
```




