---
title: Chrome插件——TamperMonkey(油猴、暴力猴)
date: 2020-08-07 23:47:37
categories:
- tool
tags:
- tool
- chrome
---

# 前言

关于Chrome插件，我用的比较多的主要是下面几个 ``Anything to QRcode``，``Axure RP Extension for Chrome``，``Evernote Web Clipper``，``有道云笔记网页剪报``，``gitlab-code-view``，``Google Translate``，``Octotree``。之前还有个Proxy代理的，自从使用SS的pac功能之后就用不到了。上面这几个你知道名字，自己去 [chrome web store](https://chrome.google.com/webstore/category/extensions?hl=en-US>) 上自己搜索安装就好了，很简单。今天要讲的这个插件，属于那种 **难者不会，会者不难** 的情况，你用过之后就会感觉很简单，没用之前很可能一个很小的门槛就把你档在外面。

<!--more-->

其实我很早就安装了 ``TamperMonkey`` 插件，之前捣鼓了几下，没用明白就放弃了。一方面是我没找到方法；另一方面不知道会有什么后果，不敢轻易尝试，怕引入危害性的插件。今天clone一个很大的github项目，在欣赏它龟速前进美姿的同时，在群里吐嘈了下。有同学指出可以使用「暴力猴」加速。

# 安装「暴力猴」失败

按照这位同学的说法，在 https://www.extfans.com 网搜索「暴力猴」，安装到chrome浏览器即可使用。从这位同学的说法上，可以看出就是那种属于「会者不难」的简单感。但我在用的时候发现「搜索有3个暴力猴，应该用哪个？」还求人家出个文档。于是他给出文档：

```
打开网址chrome插件网 搜索暴力猴，我现在用的是带有猴子头像的插件。
下载插件，解压提取.crx后缀文件，打开chrome浏览器将.crx后缀文件拖入即可安装。
如何使用：1，启用暴力猴插件，2打开github，点击插件，选择为此站添加脚本，安装此脚本即可使用。
备注：该插件还支持其他网站脚本，比如csdn去广告，b站视频下载。打开网页点击插件搜索脚本安装即可使用
```

我在extfans网站下载「暴力猴」时，发现每次点击下载，网站都报401错误，不能下载。后来1个小时后下载成功，可能的原因是刚注册的账号被网站认为是恶意请求，这是后话了。

# 尝试使用TamperMonkey

隐约间我想起，以前好像用过类似的插件。于是发现了早已安装的 **TamperMonkey**，点击「Find new scripts...」打开了[这个](https://www.tampermonkey.net/scripts.php)页面。然后找到了脚本资源的存放库[GreasyFork](https://greasyfork.org/)和[OpenUserJS](https://openuserjs.org/)，然后试图找到github加速的脚本，试了「github」「加速」「speedup」等关键词搜索，打开页面类似下图，没有找到合适的脚本：

![greasyfork.org按关键词github搜索](/images/chromes/plugin_tampermonkey1.png)

![openuserjs.org按关键词github搜索](/images/chromes/plugin_tampermonkey2.png)

# 成功安装「暴力猴」

过了大约1个小时，我再次试了下，下载成功。安装时，先打开[扩展程序页面](chrome://extensions/)，再打开「开发者模式」，对这块不熟悉的同学可以看下面图片：

![openuserjs.org按关键词github搜索](/images/chromes/plugin_tampermonkey3.png)

最后，把下载的crx文件拖动到浏览器中按提示安装就ok了。

打开github网站，在「暴力猴」上点击「Find scripts for this site」打开[页面](https://greasyfork.org/zh-CN/scripts/by-site/github.com) 第一个就是我们要找的「Github 镜像访问，加速下载」，如下图所示：

![openuserjs.org按关键词github搜索](/images/chromes/plugin_tampermonkey4.png)

脚本安装成功后，再打开github，可以看到「暴力猴」和「TamperMonkey」都生效了

![openuserjs.org按关键词github搜索](/images/chromes/plugin_tampermonkey5.png)

# 总结

上面插件都是greasyfork.org这个网站，开始没有搜索到，我们来看看和后面成功的有啥不同。我们之前查不到时网址是 https://greasyfork.org/zh-CN/scripts?q=github 而成功的网址是 https://greasyfork.org/zh-CN/scripts/by-site/github.com 大家可以看出这其中的区别了吧，就这一点小门槛。


另外，扒了下以前整理的文档，好早就试过这个网站，当时应该就是这点门槛导致没用起来

```
7.Tampermonkey插件
Chrome上最流行的脚本管理工具，可以去http://greasyfork.org 上安装许多实用脚本
```















