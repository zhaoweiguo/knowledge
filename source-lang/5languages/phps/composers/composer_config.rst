composer的使用
================
::

   composer.json 来定义你的项目的依赖


基本属性::

   name: 包的名字。由供应方（vendor）名和项目名组成，用 / 分隔
       在发布包的时候需要填。
   description: 对包的一个简短描述，通常是一行的长度。
       在发布包的时候需要填
   version: 包的版本
       格式必须是 X.Y.Z，选择性后缀：-dev、-alphaN、-betaN、-RCN。
   type: 包的类型，默认为 library
       可以定义一个定制的类型。它可以是一个 symfony-bundle 的类型
       或者 wordpress-plugin，或者 typo3-module
       这些类型将被特定的项目所用，它们将提供安装器来安装这些类型的包
       library：默认值。它将复制文件到 vendor 目录
       project：它表示这是个项目，而不是库。比如像 Symfony 标准版这种应用
       metapackage：一个含有依赖的空包，能触发安装，但不包含文件，不会向文件系统写任何东西
       composer-install：为其他的定制类型的包提供安装器的包。

发布相关::

   keywords(可选):一个与包相关的关键词数组。用于包的搜索和过滤
   homepage(可选): 项目的网站 URL
   time(可选):版本发布时间。必须是 YYYY-MM-DD 或 YYYY-MM-DD HH:MM:SS 格式
   license(可选，但强烈建议加上):包的许可证。可以是字符串或字符串数组
   authors: 包的作者。是个对象数组
       name：作者名字
       email：作者邮箱
       homepage：作者网站 URL
       role：作者在项目中的角色（如：developer 或 translator）
   support(可选):各种关于该项目如何获取支持的信息。包含这些属性
       email：获取支持的邮箱
       issues：问题跟踪的 URL
       forum：论坛的 URL
       wiki：Wiki 的 URL
       irc：IRC 的频道
       source：查看或下载源码的 URL


Package links: 依赖包的映射表，由包名映射版本约束,如::

  {
      "require": {
          "monolog/monolog": "1.0.*"
      }
  }
  require: 列出包所依赖的包。除非这些依赖已经存在，否则这个包不会被安装
  require-dev(root-only):列出开发这个包（或跑测试等等）所依赖的包
      在使用 install 命令时，只有带上 “–dev” 参数才能安装 dev 包
      在使用 update 命令时，带上 “–no-dev” 则不更新
  conflict: 列出包会和哪些包发生冲突。它们将不被允许和你的包一起安装。如果约束了版本，则只会针对特定的版本
  replace:列出哪些包要被这个包替代
  provide:这个包所推荐的包列表


suggest:建议一些能让这个包工作的更好或得到增强的包列表::

  {
      "suggest": {
          "monolog/monolog": "Allows more advanced logging of the application flow"
      }
  }

autoload:提供给 PHP autoloader 的自动加载映射::

  目前支持的有：PSR-0 自动加载规范，classmap 生成器，还有 files
  (1).PSR-0在 psr-0 键名下，定义一个命名空间到路径的映射表，相对于包的根目录
  vendor/composer/autoload_namespaces.php:
      {
        "autoload": {
          "psr-0": {
             "Monolog\\": "src/",
             "Vendor\\Namespace\\": "src/",
             "Vendor_Namespace_": "src/"
          }
        }
      }
      如果你需要在多个目录里查找同一个前缀的命名空间，你可以用数组，如:
      {
        "autoload": {
          "psr-0": { "Monolog\\": ["src/", "lib/"] }
        }
      }
  (2).Classmap的引用可以在安装或更新时生成的文件中查看
  vendor/composer/autoload_classmap.php
      {
        "autoload": {
          "classmap": ["src/", "lib/", "Something.php"]
        }
      }
  (3).files如果你确定需要在任何请求中都加载某些文件，你可以使用 files 自动加载机制
      {
        "autoload": {
          "files": ["src/MyLibrary/functions.php"]
        }
      }

target-dir:指定安装目标路径::

  Symfony\Component\Yaml:
  {
    "autoload": {
      "psr-0": { "Symfony\\Component\\Yaml\\": "" }
    },
    "target-dir": "Symfony/Component/Yaml"
  }

repositories(root-only):定制包的仓库地址(重要)::

   默认的，Composer 只使用 Packagist 仓库
   仓库不能递归。你只能将它们添加到主的 composer.json 中
   支持的仓库的类型有:
   (1).composer
   (2).vcs:版本控制系统仓库，如：git、svn、hg
   (3).pear:通过它，你可以导入任何 pear 仓库到你的项目中
   (4).package:一个不支持 composer 的项目，你可以定义一个 package 类型的仓库
   {
       "repositories": [
       {
         "type": "composer",
         "url": "http://packages.example.com"
       },
       {
         "type": "composer",
         "url": "https://packages.example.com",
         "options": {
           "ssl": {
             "verify_peer": "true"
           }
         }
       },
       {
         "type": "vcs",
         "url": "https://github.com/Seldaek/monolog"
       },
       {
         "type": "pear",
         "url": "http://pear2.php.net"
       },
       {
         "type": "package",
         "package": {
           "name": "smarty/smarty",
           "version": "3.1.7",
           "dist": {
             "url": "http://www.smarty.net/files/Smarty-3.1.7.zip",
             "type": "zip"
           },
           "source": {
             "url": "http://smarty-php.googlecode.com/svn/",
             "type": "svn",
             "reference": "tags/Smarty_3_1_7/distribution/"
           }
         }
       }
       ]
   }


其他::

   scripts(root-only):Composer 允许你在安装进程中安装钩子脚本,钩子是基于事件的
   bin:指定哪些文件必须被当做二进制文件处理的
   archive:设置创建包时的选项，exclude 属性可以设置排除哪些目录,例如:
   {
       "archive": {
          "exclude": ["/foo/bar", "baz", "/*.test", "!/foo/bar/baz"]
       }
   }
                   
   
from:http://www.udpwork.com/item/10716.html
