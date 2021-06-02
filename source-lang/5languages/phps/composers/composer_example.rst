composer开发实例
=====================


初使化::

  composer init

根据提示生成 ``composer.json`` 文件::

  {
      "name": "huy/test",
      "description": "composer and package.list test.",
      "require": {
         "php": ">=5.3"
      },
      "license": "MIT",
      "authors": [
         {
            "name": "<NAME>",
            "email": "email@domain.com"
         }
      ],
      "minimum-stability": "stable",
      "autoload": {
         "psr-4": {
            "Huy\\": "src/"    # Huy命名空间的根目录是当前目录下的src/
         }
      }
  }

根据配置文件生成包骨架::

  composer install

