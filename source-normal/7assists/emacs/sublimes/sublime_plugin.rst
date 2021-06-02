sublime插件相关
#######################



.. toctree::
   :maxdepth: 1

   plugins/plugin_git
   plugins/plugin_html
   plugins/plugin_plantuml
   plugins/plugin_rst
   plugins/plugin_increment_selection
   plugins/plugin_sublimeCodeIntel

安装
=======


安装方式1::

    打开command palette
    键入: Package Control: Install Package.
    输入 <要安装的插件名>.


安装方式2::

    # on a Mac
    cd "$HOME/Library/Application Support/Sublime Text 3/Packages"
    # on Linux
    cd $HOME/.config/sublime-text-3/Packages
    # on Windows (PowerShell)
    cd "$env:appdata\Sublime Text 3\Packages\"

    <把要使用的插件复制到此目录中>

编译环境
=========

步骤::

    1. 在Tools->Build System->New Build System
    2. 保存文件PlantUML[Windows].sublime-build(文件名称可自定义)
    3. 在Tools->Build System中，选择PlantUML[Windows]，启用配置。
    4. Tools->Build 执行


Python生成环境::

    {
      "cmd":["<path>/python","-u","$file"],
      "file_regex":"^[]*File \"(...*?\",line([0-9]*)",
      "selector":"source.python"
    }






