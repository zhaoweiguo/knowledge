sublime临时相关
======================

把<tab>转为4个<space>:

.. figure:: /images/emacs/sublime_tab2space.png
   :width: 40%

::

   >> preferences->settings-user
   {
       "tab_size": 4,
       "translate_tabs_to_spaces": false
   }
           

把进行代码格式化(好像不是很好用的说)::

  >> Preferences → Key Bindings – User
  {"keys": ["super+shift+r"], "command": "reindent" , "args": {"single_line": false}}



安装 Package Control
------------------------


1. 通过快捷键 ctrl+` 或者 View > Show Console 菜单打开控制台
2. 粘贴下面的代码后，回车安装
3. 参考资料 `Package Control 安装 <https://packagecontrol.io/installation>`_ sublime3的安装代码如下::

    import urllib.request,os,hashlib; 
    h = 'eb2297e1a458f27d836c04bb0cbaf282' + 'd0e7a3098092775ccb37ca9d6b2e4b7d'; 
    pf = 'Package Control.sublime-package'; 
    ipp = sublime.installed_packages_path(); 
    urllib.request.install_opener( urllib.request.build_opener( urllib.request.ProxyHandler()) ); 
    by = urllib.request.urlopen( 'http://packagecontrol.io/' + pf.replace(' ', '%20')).read(); 
    dh = hashlib.sha256(by).hexdigest(); 
    print('Error validating download (got %s instead of %s), please try manual install' % (dh, h))
    if dh != h else open(os.path.join( ipp, pf), 'wb' ).write(by)

安装插件
-----------------
1. 快捷键 'Ctrl + Shift + P' （Mac 为：'Command + Shift + P'）（或顶部菜单 -> Tools -> Command Palette），输入 'install'，选择 'Package Control:Install Package'
2. 弹出的插件搜索框输入 '<xxx>'，选择 '<xxxxx>'，回车等待安装完毕，重启 Sublime Text，即可使用。


代码安装插件::

   # on a Mac
   cd "$HOME/Library/Application Support/Sublime Text 3/Packages"
   # on Linux
   cd $HOME/.config/sublime-text-3/Packages
   # on Windows (PowerShell)
   cd "$env:appdata\Sublime Text 3\Packages\"

   git clone git@github.com:divmain/GitSavvy.git








