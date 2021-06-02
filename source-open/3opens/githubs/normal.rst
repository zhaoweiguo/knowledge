基本
####

高Rank的项目
============

https://gitstar-ranking.com/

Showcases
=========

Showcases，是GitHub根据你感兴趣的主题，做的一个展示，这里有VR（虚拟现实），机器学习等等主题，地址是 https://github.com/showcases,这也是我经常去的一个地方，在这里可以根据你的兴趣、你关注的主题、你公司需要等等，选择相应的主题，然后打开他们，就可以看到GitHub为你精选的项目了，作为参考学习。比如VR这个主题 https://github.com/showcases/virtual-reality。

Trending
========

Trending，https://github.com/trending,GitHub上的风云榜，在这里你可以看到最近一天、一周、一个月哪些项目和开发者最流行，这基本上是我每天必看的，从这里可以找到新趋势、新技术以及新的基友。推荐每天必看，当今日头条新闻看，善用Trending，不要错过遗憾。

Issues
======

在GitHub中，基友们之间的交互大部分都是通过issues（问题），这类似于提问题，讨论。每一个项目都有，你可以针对该项目打开一个issues，提出你的问题、和基友们讨论等等，就和一个小论坛一样。issues支持MarkDown语法，可以在线编辑，所以非常方便，有不少基友们用他来在GitHub上直接写博客，教程等。想和其他基友们交流，从一个issues开始吧。

Fork
====

这也是GitHub上的概念，意思是建立一个新的分支，比如你Fork了一个项目，就会在你的项目列表里创建一个同名的项目，也即是一个分支（和Git的分支不同），因为是你的所以你拥有它的所有权限，可以任意修改，删除，添加等等。

在贡献代码pull request之前，我们必须要先Fork，这样你才可以有权限修改这个项目，修改完成后，再提交发起pull request就可以提交你的贡献了。

同时Fork也是保存一个项目好办法，因为它是一个完全复制的分支，和原来的项目没有太大关系，所以即使原项目的代码内容被删除，你的还存在。

Pull requests
=============

Pull requests，我们亲切的称为PR，这是在GitHub上代码贡献的流程，不管是你给别的项目贡献代码，还是别的人给你的项目贡献代码。一个完成的贡献代码的流程如下：

Fork别人的项目，因为你是不能直接别人的项目的。
Fork后就是自己项目了，和操作自己的项目一样，编写代码等，然后提交。
提交后，发起pull request给原项目，这时候对方才能看到你贡献的代码。
原作者看到后，会Review你的贡献等，如果没有没问题，就会接受Merge原项目中了。
这样你的贡献，就可以被更多的人使用到了。
如果你对一个项目有更好的想法，或者修复一个Bug等，就发起PR来贡献吧，GitHub上伟大的项目都不是一个写的，都是靠千千万万个贡献者，这也是开源的意义所在，这也是软件、甚至整个IT行业能这么高速发展的原因之一。

GitHub Pages
============

这是一个Github提供的静态网页服务，让你可以为你的开源项目创建一个介绍网站，来介绍你的项目以及使用等等。除此之外，他还有一个好的用处，就是搭建自己的个人博客，具体请参考我以前的一篇博客 http://www.flysnow.org/2015/03/10/github-page-with-hexo.html ，这是介绍我自己通过该服务，使用Hexo搭建个人博客网站的经验。个人博客是一个平台好的平台，不仅可以让你学习总结，也可以让你认识更多的朋友，为你的简历加分，如果没有，赶紧搭建一个吧。

Integrations
============

Integrations是GitHub推出的开放平台服务，可以让其他第三方利用GitHub的开放能力，构建一些开放工具或者平台，帮助开发者更好的开发、构建自己的项目，比如我们常用的Travis CI，可以帮我们持续构建，发布我们的项目。更多关于Integrations的工具或者平台，请到https://github.com/integrations 查找，有详细分类，也可以筛选过滤，非常方便。

webhook
=======

* webhook: https://developer.github.com/webhooks/


命令行工具gh
============


* github: https://github.com/cli/cli

Installation::

    $ brew install gh



Usage::

    $ gh pr [status, list, view, checkout, create]
    $ gh issue [status, list, view, create]
    $ gh repo [view, create, clone, fork]
    $ gh auth [login, logout, refresh, status]
    $ gh config [get, set]
    $ gh help


参考
====

* https://www.flysnow.org/2017/01/15/github-community.html
* https://developer.github.com/
