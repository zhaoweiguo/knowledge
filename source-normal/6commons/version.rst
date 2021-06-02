版本
####

GA::

    General Availability,正式发布的版本，在国外都是用GA来说明release版本的。

RTM：(Release to Manufacture)::

    是给工厂大量压片的版本，内容跟正式版是一样的，不过RTM版也有出限制、评估版的。
    但是和正式版本的主要程序代码都是一样的。

OEM::

    是给计算机厂商随着计算机贩卖的，也就是随机版。
    只能随机器出货，不能零售。
    只能全新安装，不能从旧有操作系统升级。
    包装不像零售版精美，通常只有一面CD和说明书(授权书)。 

RVL::

    号称是正式版，其实RVL根本不是版本的名称。它是中文版/英文版文档破解出来的。 

EVAL::

    而流通在网络上的EVAL版，与“评估版”类似，功能上和零售版没有区别。 

RTL::

    Retail(零售版)是真正的正式版，正式上架零售版。
    在安装盘的i386文件夹里有一个eula.txt，最后有一行EULAID，就是你的版本。
    比如简体中文正式版是EULAID:WX.4_PRO_RTL_CN，繁体中文正式版是WX.4_PRO_RTL_TW。
    其中：如果是WX.开头是正式版，WB.开头是测试版。_PRE，代表家庭版；_PRO，代表专业版。

α、β、λ常用来表示软件测试过程中的三个阶段::

    α第一阶段，一般只供内部测试使用
    β第二阶段，已经消除了软件中大部分的不完善之处，但仍有可能还存在缺陷和漏洞，一般只提供给特定的用户群来测试使用
    λ第三阶段，此时产品已经相当成熟，只需在个别地方再做进一步的优化处理即可上市发行



语义化版本SemVer
================

* https://semver.org/lang/zh-CN/

::

    版本格式：主版本号.次版本号.修订号，版本号递增规则如下：

    主版本号：当你做了不兼容的 API 修改，
    次版本号：当你做了向下兼容的功能性新增，
    修订号：当你做了向下兼容的问题修正。
    先行版本号及版本编译元数据可以加到“主版本号.次版本号.修订号”的后面，作为延伸。


If the git tag is a valid semver string, provides the tag as a semver string::

    DRONE_SEMVER=1.2.3-alpha.1

    DRONE_SEMVER_SHORT=1.2.3
    DRONE_SEMVER_PATCH=3
    DRONE_SEMVER_MINOR=2
    DRONE_SEMVER_MAJOR=1
    DRONE_SEMVER_PRERELEASE=alpha.1

    DRONE_SEMVER_BUILD=001
    DRONE_SEMVER=1.2.3+001


主版本号为零的时候就是为了做快速开发::

    如果你每天都在改变 API，那么你应该仍在主版本号为零的阶段（0.y.z），或是正在下个主版本的独立开发分支中
    The v0.x.y tags indicate that go APIs may change in incompatible ways in different versions.


万一不小心把一个不兼容的改版当成了次版本号发行了该怎么办？::

    一旦发现自己破坏了语义化版本控制的规范，就要修正这个问题，并发行一个新的次版本号来更正这个问题并且恢复向下兼容
    即使是这种情况，也不能去修改已发行的版本
    可以的话，将有问题的版本号记录到文件中，告诉使用者问题所在，让他们能够意识到这是有问题的版本










