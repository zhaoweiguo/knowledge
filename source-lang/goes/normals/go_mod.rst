Go包管理
############


* Go 模块idea使用指南 [1]_
* 介绍1 [2]_
* 介绍2 [3]_


go get引入私有git库 [4]_ ::

    git config --global url."git@gitee.com:".insteadof "https://gitee.com/"

    关掉 GO 代理 拉取代码
    export GOPROXY=

    // 如果没有用https或证书
    go get -v   -insecure  gitcodecloud.zhaoweiguo.com.cn/tools/dauth

历史管理方法
============

* deps管理依赖 [5]_
* godep, glide, or dep
* 各管理依赖对比 [6]_


* gopkg.in: Go的包管理解决方案之一，就是gopkg.in做了一个转发过程，实际上是使用了github里面的相应的tag的代码


相关参考
========

* https://blog.golang.org/versioning-proposal
* https://semver.org/
* https://labix.org/gopkg.in
* https://github.com/golang/proposal/blob/master/design/24301-versioned-go.md#rationale
* https://github.com/golang/go/issues/24301
* https://github.com/golang/go/wiki/PackageManagementTools
* https://supereagle.github.io/2017/10/05/golang-dep/


.. [1] https://blog.jetbrains.com/cn/2019/03/go-%E6%A8%A1%E5%9D%97%E4%BD%BF%E7%94%A8%E6%8C%87%E5%8D%97/
.. [2] https://juejin.im/post/5c9c8c4fe51d450bc9547ba1
.. [3] http://copyfuture.com/blogs-details/c0da8fd286057159b61b483fa0e8a4c6
.. [4] https://golang.org/doc/faq#git_https
.. [5] https://github.com/golang/dep
.. [6] https://github.com/blindpirate/report-of-build-tools-for-java-and-golang