go mod相关疑问
==============

ambiguous import
---------------------

错误::

    build dispatcher: cannot load github.com/ugorji/go/codec: 
        ambiguous import: found github.com/ugorji/go/codec in multiple modules:

原因::

    报错的字面意思是有一个包多个地方引用但版本不一致。
    详见 https://github.com/ugorji/go/issues/279 
    应该是github.com/ugorji/go这个库的问题，1.1.2版本修复了该问题

解决::

    执行: go get github.com/ugorji/go@v1.1.2

git 私有仓库如何使用 [1]_
-------------------------

因为golang拉取依赖都按照预定义策略，例如https，如果依赖仓库是私有仓库怎么完成自动构建？例如::

    我们有多个私有项目,项目之间也存在包依赖关系,可以通过修改.gitconfig配置完成,例如:
    如果你使用的是gerrit做为代码审核工具的话，可以通过命令

    git config --global url."ssh://你的用户名@example.com:29418/".insteadOf "https://example.com/"
    如:
    git config --global url."git@gitee.com:".insteadof "https://gitee.com/"

本质是~/.gitconfig 增加如下的配置::

    [url "ssh://你的用户名@example:29418/"]
        insteadOf = https://example.com/

    [url "git@gitee.com:"]
        insteadof = http://gitee.com/

如何依赖未提交的库最新代码进行开发
-----------------------------------

可以使用replace配置，替换成本地的路径::

    module example.com/go_service.git
        replace (
        example.com/server/common/go/pub.git => /localpath
    )

    require (
        example.com/server/common/go/pub.git v0.0.0-20181226054539-bec28798b114
    )

parsing go.mod: unexpected module path
--------------------------------------

错误::

    go: github.com/h2non/gock@v1.0.15: parsing go.mod: 
        unexpected module path "gopkg.in/h2non/gock.v1"

原因::

    开源项目地址是github.com/h2non/gock
    但里面代码中import用的却是gopkg.in/h2non/gock.v1

解决方法::

    在go.mod文件中增加:
    replace github.com/h2non/gock => gopkg.in/h2non/gock.v1 v1.0.14

kubernetes client-go依赖报错
----------------------------

问题::

    cannot find module providing package k8s.io/api/xxxx/v1alpha1 
        when compiling operator-sdk

解决::

    1. 修改go.mod文件
    替换k8s.io\client-go@v11.0.0+incompatible为k8s.io/client-go v0.18.2，然后在go build就可以了
    2. 使用go get 命令
    $ go get k8s.io\client-go@v0.18.2

github issue中解释如下 [2]_ ::

    Related issue is that go get k8s.io/client-go@latest 
        resolves to v11.0.0+incompatible not v0.18.2.
    Should I break this off as a separate discussion?

    Unfortunately, that is not possible to resolve. 
    k8s.io/client-go had major versions tagged prior to the introduction of go modules. 
    go modules require any major version X >= 2 rename the module to k8s.io/client-go/v.

原因应该是这样的::

    go get命令是会自动的下载版本最新的(这儿是v11.0.0)
    但实际上v12.0.0的下一版本是v0.12.10也就是kubernetes-1.12.10

    另: 下面2个tag是同一个commit
    分支: origin/release-13.0
    tag: v0.16.13, tag: kubernetes-1.16.13

commit日志::

    commit 9a60e030176b33b0f5e1d6f37d5b2409f5d80422 (HEAD, tag: v0.16.13, tag: kubernetes-1.16.13)
    Author: Kubernetes Publisher <k8s-publishing-bot@users.noreply.github.com>
    Date:   Wed Jul 15 21:31:14 2020 +0000

        Update dependencies to v0.16.13 tag

    commit b063729e49a610cb5cfd329fce64b7c736784d83 (origin/release-13.0)
    Merge: c94387a2 37e11edd
    Author: Kubernetes Publisher <k8s-publishing-bot@users.noreply.github.com>
    Date:   Tue Apr 28 14:58:24 2020 -0700

        Merge pull request #90022 from liggitt/json-raw-1.16
        
        Manual cherry pick of #89833: preserve integers decoding raw JSON values
        
        Kubernetes-commit: 4d8caa7d476ae12f362b031efd765d9d282d337e






.. [1] http://blog.ipalfish.com/?p=443
.. [2] https://github.com/kubernetes/client-go/issues/551