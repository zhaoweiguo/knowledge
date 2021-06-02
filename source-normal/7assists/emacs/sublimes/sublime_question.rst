常见问题 
############

Mac安装插件报错 [1]_
--------------------

Sublime Text 安装插件报错::

    Package Control
    Unable to download XXX. Please view the console for more details.

解决办法:

.. image:: /images/emacs/sublime_plug.png

增加如下内容::

    "debug": true,
    "downloader_precedence":
    {
        "linux": [ "curl", "urllib", "wget" ],
        "osx": [ "curl", "urllib" ],
        "windows": [ "wininet" ]
    },

最终内容如下::

    {
        "bootstrapped": true,
        "debug": true,
        "installed_packages":
        [
            "Package Control"
        ],
        "downloader_precedence":
        {
            "linux": [ "curl", "urllib",    "wget" ],
            "osx": [ "curl", "urllib" ],
            "windows": [ "wininet" ]
        },
    }






.. [1] https://www.jianshu.com/p/ebf3f39b37ca