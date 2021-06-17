浏览器代理
=====================

Chrome浏览器使用SwitchySharp插件
""""""""""""""""""""""""""""""""""""""""""""

* 下载switchysharp插件
* 选择情景模式:

.. figure:: /images/fanqiangs/SwitchySharp_plugin1.png
   :width: 80%

* 切换到规则选项, URL模式填写 ``*//autoproxy-gfwlist.googlecode.com/*``, 模式匹配选择 ``通配符``, 情景模式选择 ``我们刚才创建的情景模式``
* 选择下面的启用在线规则列表 打上对钩, 在规则列表URL 里写入 ``http://autoproxy-gfwlist.googlecode.com/svn/trunk/gfwlist.txt``, 在自动更新间隔 选择 ``30分钟`` 就可以了 你也可以随意选择, 最后的情景模式选择 ``你创建的那个``, 最后给AutoProxy 兼容列表 ``打上对勾``
* 保存 接着点立即更新列表来更新下列表.更新完后如果正常那么 就可以代理上网了
* 如图:

.. figure:: /images/fanqiangs/SwitchySharp_plugin2.png
   :width: 80%

* 点击chrome浏览器的菜单那里的那个小图标:

.. figure:: /images/fanqiangs/SwitchySharp_plugin3.png
   :width: 30%

FireFox浏览器使用SwitchySharp插件
""""""""""""""""""""""""""""""""""""
* 在Firefox地址栏输入  ``about:config``
* 点击 ``我保证会小心``, 在打开的窗口中的过滤器中输入 ``dns``, 找到 ``network.proxy.socks_remote_dns``, 双击使其值由false变为true

.. figure:: /images/fanqiangs/firefoxSwitchy1.jpg
   :width: 50%

* 在Firefox输入网址: https://addons.mozilla.org/zh-CN/firefox/addon/autoproxy/ 然后打开(或在插件页面搜索autoproxy), 点击 ``添加到Firefox``
* 我有试过， 但总有问题，暂不试了


