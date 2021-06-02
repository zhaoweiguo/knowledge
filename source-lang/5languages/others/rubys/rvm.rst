rvm
########

* ruby版本管理: http://rvm.io/

安装::

    $ curl -sSL https://get.rvm.io | bash -s stable
    注: 此命令可能需要gunpg2命令操作, 详见上面命令提示

查看RVM可安装的ruby的版本::

    $ rvm list known

安装ruby指定版本::

    $ rvm install 1.9.3
    $ rvm install 2.6

卸载一个已安装版本::

    $ rvm remove 1.8.7



使用::

    $ rvm use 2.6
    // 查看是否生效
    $ ruby -v

    // 设置默认版本
    $ rvm use 2.6.0 --default 



rubygems仓库
============

* 官网: https://rubygems.org/

删除原来的rubygems仓库::

    $ gem sources --remove https://rubygems.org/

查看rubygems仓库::

    $ gem sources -l

添加aliyun的rubygems仓库::

    $ gem sources -a https://mirrors.aliyun.com/rubygems/

安装软件::

    格式:
    $ gem install 包名或组件名 --version  版本号
    
    实例:
    $ gem install i18n --version 0.7.0


bundle命令
==========

创建 gemfile 文件::

    $ bundle init



Bundle,Gem,Gemfile关系
======================

简介::

    rvm 是用来管理 ruby 的，ruby 的其中一个“程序”叫 rubygems ，简称 gem
    bundle用来管理项目的 gem，他俩完全是不同的东西，相同的只是都可以管理gem

    bundler 用来管理 fastlane 自身版本和 fastlane 运行时的相关依赖版本,
    相当于 iOS 开发中的 CocoaPods 框架, 使用方法也和 CocoaPods 如出一辙

fastlane 会使用 Gemfile 里面指定的版本使用程序::

    source "https://rubygems.org"

    gem "dotenv"
    gem "github-pages"

安装当前项目的 gem 库::

    $ bundle install   // 即:安装Gemfile中指定的文件











