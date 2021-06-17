基本功能
########

命令面板::

    命令面板是vscode快捷键的主要交互界面，可以使用f1或者Cmd+Shift+P(win Ctrl+Shift+P)打开
    命名面板中可以执行各种命令，包括编辑器自带的功能和插件提供的功能

code命令::

    安装: 打开命名面板Cmd+Shift+P,搜索shell命令,点击在PAth中安装code命令
    使用: 
        $ code <path>   // 在命令行打开code IDE
    如果你希望在已经打开的窗口打开文件，可以使用-r参数:
        $ code -r <path>

    打开文件跳转到指定的行和列:

user settings file位置::

    Windows %APPDATA%\Code\User\settings.json
    macOS $HOME/Library/Application Support/Code/User/settings.json
    Linux $HOME/.config/Code/User/settings.json


打开Extensions pane::

    Ctrl+Shift+X or Cmd+Shift+X

快捷键
==========

常用快捷键::

    Cmd+Shift+P: 打开「命令面板」界面
    Control+Shift+G: 打开「版本控制」界面
    Cmd+P: 打开「文件搜索」界面
    Cmd+Shift+X: 打开「插件扩展」界面

    Cmd+K Z: 打开「Zend Mode」
    Cmd+Shift+O: 打开「符号跳转」
    Cmd+U: 回到本文件上一个光标的位置
    Control+-: 在不同的文件之间回到上一个光标的位

    f12: 跳到函数的定义处
    Cmd+f12: 跳转到函数的实现处
    
    Cmd+Shift+E: 文件资源管理器
    Cmd+Shift+F: 跨文件查找
    Cmd+Shift+G: 源代码管理(todo)
    Cmd+Shift+D: 启动调试


Shift+Cmd+P::

    // 为指定语言个性化Setting
    Preferences: Configure Language Specific Settings (command id: workbench.action.configureLanguageBasedSettings)





Zen Mode
========

打开Zen Mode::

    View menu, Command Palette(View -> Appearance for Mac)
    快捷键: Cmd+K Z

退出Zen Mode::

    Double Esc

Git相关 [1]_
============

打开「版本控制」界面::

    Control+Shift+G: 
    可以查看具体的修改细节

Shift + Command + P相关操作::

    克隆:
    1. Shift + Command + P
    2. Git: Clone ...

    分支与tag:
    1. Shift + Command + P
    2. Git: Checkout to ...
       
    Commit:
    1. Shift + Command + P
    2. Git: Stage All Changes
    3. Git: Commit All
    4. Git: Push


代码编辑
===========

光标的移动::

    移动到行首 Cmd+左方向键 (win Home)
    移动到行尾 Cmd+右方向键 (win End)
    移动到文档的开头和末尾 Cmd+上下方向键 （win Ctrl+Home/End）
    在花括号{}左边右边之间跳转 Cmd+Shift+ (win Ctrl+Shift+)

    回到同一文件上一个光标的位置，Cmd+U(win Ctrl+U) 
    在不同的文件之间回到上一个光标的位置 Control+-

文本选择::

    选中单词: Cmd+D
    代码块的选择: 使用cmd+shift+p打开命令面板，输入选择括号所有内容

删除::

    Cmd+Shift+K (win Ctrl+Shift+K)

代码移动::

    代码移动 Option+上下方向键(win Alt+上下)
    代码复制 Option+Shift+上下

添加注释::

    单行注释 Cmd+/ （win Ctrl +/）
    块注释 Option+Shift+A

代码格式
============

代码格式化::

    对整个文档进行格式化：Option+Shift+F (win Alt+Shift+F)
    对选中代码进行格式化： Cmd+K Cmk+F win(Ctrl+K Ctrl+F)

代码缩进::

    整个文档进行缩进调节，使用Cmd+Shift+P打开命令面板，输入缩进,然后选择相应的命令
    选中代码缩进调节：Cmd+] Cmd+[ 分别是减小和增加缩进


小技巧
========

调整字符的大小写::

    命令面板输入: 转化为大写或者转化为小写Transform to Uppercase(Lowercase, Titlecase)
    合并代码行，多行代码合并为一行，Cmd+J

行排序::

    将代码行按照字母顺序进行排序，无快捷键，调出命令面板，输入「按升序排序或者按降序排序」

多光标特性
============

使用鼠标::

    按住Option(win Alt),然后用鼠标点
        注意：有的mac电脑上是按住Cmd，然后用鼠标点才可以
    快捷命令:
        Cmd+D (win Ctrl+D) 第一次按下时，它会选中光标附近的单词
            第二次按下时，它会找到这个单词第二次出现的位置，创建一个新的光标，并且选中它
        cmd-k cmd-d 跳过当前的选择
        Option+Shift+i (win Alt+Shift+i) 首先你要选中多行代码，然后按Option+Shift+i,这样做的结果是：每一行后面都会多出来一个光标

快速跳转(文件、行、符号)
==========================

快速打开文件::

    Cmd+P （win Ctrl+P）输入你要打开的文件名,回车打开
        选中你要打开的文件后，按Cmd+Enter,就会在一个新的编辑器窗口打开
    cmd+shift+[]: 在tab不同的文件间切换，cmd+shift+[]

行跳转::

    Ctrl+g 输入行号
    先按下 “Cmd + P”，输入文件名，然后在这之后加上 “:”和指定行号

符号跳转::

    符号可以是文件名、函数名，可以是css的类名
    Cmd+Shift+O(win Ctrl+Shift+o) 输入你要跳转的符号，回车进行跳转
    win下输入Ctrl+T，可以在不同文件的符号间进行搜索跳转

    #: 整个项目的文件名……
    @: 当前打开文件的方法


定义(definition)和实现(implementation)处::

    f12跳到函数的定义处
    Cmd+f12(win Ctrl+f12)跳转到函数的实现处

引用跳转::

    Shift + F12，VS Code 就会打开一个引用列表和一个内嵌的编辑器




代码重构
===========

修改一个函数或者变量的名字::

    把光标放到函数或者变量名上，然后按下 F2，这样这个函数或者变量出现的地方就都会被修改


参考
====

参考1: https://segmentfault.com/a/1190000017949680





.. [1] https://code.visualstudio.com/Docs/editor/versioncontrol