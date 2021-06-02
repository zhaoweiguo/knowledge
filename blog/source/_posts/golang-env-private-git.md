---
title: 使用go get获取私有git项目
date: 2019-09-24 12:21:12
tags:
- golang
- private git
categories:
- golang
---

## 前情提要

本人使用Idea做Golang开发，之前一直是用公有项目，可通过快捷键自动获取(如下图)，但私有git项目则不能如此顺利

不使用Go Modules(vgo)界面:
![不使用Go Modules(vgo)](/images/golangs/go-get-git-private1.png)

使用Go Modules(vgo):
![使用Go Modules(vgo)](/images/golangs/go-get-git-private2.png)

<!--more-->

## 方法1: 切换成ssh协议免密

使用ssh协议clone代码，可能通过配置私钥实现免密登录。但go get命令默认是走https协议，那想办法让go get走ssh协议就解决这个问题了，网上查到的解决方案大多数是这种解法。

命令:
```
// 增加如下代码到文件~/.gitconfig文件中:
[url "ssh://git@gitlab.com/"]
  insteadOf = https://gitlab.com/
```
或者
```
// 执行如下命令:
git config --global url."git@gitlab.com:".insteadof "https://gitlab.com/"
```


## 问题解决1: 搭建的gitlab提供的是http协议

本来上面的操作基本就解决问题了，但我本人使用的私有git仓库(gitlab版)搭建时没有用https协议，是直接用http协议，而go get默认是请求https协议，所以在要加上-insecure参数:
```
go get -insecure gitlab.com/zhaoweiguo/private
```

并且协议替换要使用如下命令:
```
git config --global url."git@gitlab.com:".insteadof "http://gitlab.com/"
```

这样就导致我不能通过Idea的快捷键直接获取命令，但问题暂时解决了，只是麻烦一些，每次都需要在命令行执行一次go get -insecure命令

## 问题解决2: 证书不可信问题

使用上面的方法用了一段时间，但我每次使用都很不爽，得想办法解决它。于是抽时间给git服务器增加了https协议，再执行go get命令，报下面错误
```
$> $ go get gitlab.com/zhaoweiguo/private
go get gitlab.com/zhaoweiguo/private: unrecognized import path "gitlab.com/zhaoweiguo/private" 
(https fetch: Get https://gitlab.com/zhaoweiguo/private?go-get=1: 
    x509: certificate signed by unknown authority)
```

证书不可信，我们gitlab使用的签名证书的ca没有在可信证书里面，使用如下命令查看ca证书:
```
$> openssl s_client -connect gitlab.com:443 -showcerts
... ...
Certificate chain
 0 s:/C=CN/L=Beijing/O=Xinxi (Beijing) Limited/OU=IT/CN=*.zhaoweiguo.com
   i:/C=US/O=DigiCert Inc/CN=DigiCert SHA2 Secure Server CA
... ...
```
找到关键信息
```
i:/C=US/O=DigiCert Inc/CN=DigiCert SHA2 Secure Server CA
```
打开Keychain Access.app(Mac专用，其他系统请自行search)，搜索关键词找到 DigiCert SHA2 Secure Server CA:

![默认](/images/golangs/go-get-git-private3.png)

修改成可信任(Always Trust):

![修改成可信任](/images/golangs/go-get-git-private4.png)


## 方法2: 使用https协议（用户名+密码）

再次执行go get证书问题就解决了，又遇到一个新问题，如下:
```
$> go get gitlab.com/zhaoweiguo/private
go get gitlab.com/zhaoweiguo/private: git ls-remote -q http://gitlab.com/zhaoweiguo/private.git in /Users/zhaoweiguo/9tool/go/pkg/mod/cache/vcs/a74feb48fc5c4467059eb529fa3d37b6fadb8b6dab2137401e7f1bd194240d07: exit status 128:
  fatal: could not read Username for 'http://gitlab.com': terminal prompts disabled
If this is a private repository, see https://golang.org/doc/faq#git_https for additional information.
```
这儿打印信息上已经给出解决方案，打开网页: https://golang.org/doc/faq#git_https ，找到解决方案:
```
// 增加一文件: $HOME/.netrc, 写入如下内容
$> tee ~/.netrc <<-'EOF'
machine gitlab.com login USERNAME password APIKEY
EOF
```
他上面给的解释说是，有些公司安全部门会禁止git(9418)和ssh(22)协议，只开放http和https协议，又因为http协议不安全，所以提供了https协议的方法，这点正好解决了我的问题



## 踩到的坑

#### 坑1: gitlab安装时只使用http协议

执行go get命令时，本质是先提交一个HTTP GET 到网址https://gitlab.com/zhaoweiguo/private?go-get=1 ，得到的内容中head下有个meta标签，里面有go client应该从哪获取仓库:
```
<html>
    <head>
        <meta content="https://gitlab.com/zhaoweiguo/private git https://gitlab.com/zhaoweiguo/private.git" name="go-import">
    </head>
</html>
```
因为最开始安装gitlab时用的是http协议，虽然后来增加了https协议，但这儿的meta返回值还是http协议

#### 坑2: 证书相关坑

查找证书问题时，最开始是怀疑go get是使用go内部自己定义的ca证书，因为此证书在浏览器中是可信任的。所以想使用curl -v命令查看详细过程，发现如下可能的问题点:
```
1. x509: certificate signed by unknown authority
2. ALPN, server did not agree to a protocol
3. Mark bundle as not supporting multiuse
4. No client certificate CA names sent
```
这些问题点每个都花费精力去验证是否是引起问题的原因，最后其实本质就是第一条问题。

## 其他解决方案


修改gitlab让gitlab返回https://gitlab.com/zhaoweiguo/private?go-get=1 的请求meta信息直接返回ssh协议的地址，参考: 
https://www.szyhf.org/2017/07/12/%E5%BD%93go-get%E9%81%87%E4%B8%8Agitlab/

## 2019-09-25更新

关于证书不可信的问题，因为我们的证书是Digi签发的证书，正常应该不需要再手动信任证书。出现这种问题的原因是因为我在配置gitlab服务器的证书时，没有把中间CA证书上传的原因。

#### 验证的经过

在docker上使用curl请求时，发现同样的证书的另一个域名在请求时成功，而这个域名每次都是报这个错误:
```
$> apk add ca-certificates    // 安装ca-certificates
$> curl -v https://gitlab.com
...
* SSL certificate problem: unable to get local issuer certificate
* Closing connection 0
...
```

我把中间CA证书导入到docker上后成功时，可以看到:
```
$> openssl s_client -connect gitlab:443 --showcerts
CONNECTED(00000003)
depth=2 C = US, O = DigiCert Inc, OU = www.digicert.com, CN = DigiCert Global Root CA
verify return:1
depth=1 C = US, O = DigiCert Inc, CN = DigiCert SHA2 Secure Server CA
verify return:1
depth=0 C = CN, L = Beijing, O = Gitlab (Beijing) Limited, CN = gitlab
verify return:1
... ... 
```


我这才想起证书链的问题，证书链说明
```
Root CA证书:        DigiCert Global Root CA
中间CA证书:          DigiCert SHA2 Secure Server CA
终端证书:            gitlab.com(这是假的，为和前面的网站保持一致)
```

然后把中间CA证书也放到gitlab服务的配置中后，一切都ok了


## 2020-03-13更新

上面说的还是有一些问题，主要是版本不同，带来的问题也不同。首先要先知道1.12版和1.13版的不同，1.13增加了GOSUMDB和GOPRIVATE环境变量1.13版本需要加上以下几个命令到~/.bash_profile(zsh要改~/.zprofile):
```
export GO111MODULE=on
export GOPROXY=https://goproxy.cn,direct
export GOSUMDB=sum.golang.google.cn
export GOPRIVATE=gitlab.com  # 这儿改成你的私有git域名
```

## 扩展阅读

* https://github.com/hyper0x/go_command_tutorial/blob/master/0.3.md
