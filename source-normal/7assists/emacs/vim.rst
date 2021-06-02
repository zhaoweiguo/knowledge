.. _vim:

vim简单使用操作
=================


屏幕翻滚类命令
----------------
::

    ``gg``   回到文件头部
    ``<num>``  到当前行第<num>列
    ``$``   到当前行末尾

    ``Ctrl+u`` 向文件首翻半屏
    ``Ctrl+d`` 向文件尾翻半屏
    ``Ctrl+f`` 向文件尾翻一屏
    ``Ctrl＋b`` 向文件首翻一屏
    ``nz`` 将第n行滚至屏幕顶部，不指定n时将当前行滚至屏幕顶部

删除
------
::

   ``dd``      删除光标所在的一行文字，同时本行文字会放到缓存中
   ``d0``      删至行首
   ``d$``      删至行尾

   ``dw``    删除一个单词/光标之后的单词剩余部分
   ``x``    删除当前字符


复制
-----

* ``yy``        复制本行文字到缓存中
* ``number yy`` 复制number行到缓存中

粘贴
-------

* ``p``         把缓存中的行粘贴到光标所在的下一行，
* ``P``         把缓存中的行粘贴到光标所在的上一行

文件
-------

* ``:r filename`` 把文件filename的内容粘贴在光标以下行
* ``:w``          保存当前编辑的文件名
* ``:w filename`` 当filename不存在时，把修改后的文件存为文件filename ,当文件filename存在时，报错。
* ``!w filename`` 如果文件filename存在时，把修改后的文件保存为文件filename

在多个文件之间切换
---------------------

* ``:n``        开始编辑vi激活的文件列表中的下一个文件
* ``:n filenames``       指定将被编辑的新的文件列表

在当前文件和另外一个文件间切换
--------------------------------

* ``:e filename``         使用filename激活vi(在vi中装入另一个文件filename)
* ``e!``                  重新装入当前文件，若当前文件有改动，则丢弃以前的改动
* ``:e+filename``         使用filename激活vi ,并从文件尾部开始编辑
* ``:e+number filename``  使用filename激活vi ,并在第number行开始编辑
* ``:e#``     开始编辑另外一个文件

查找
------

* ``/pattern``  向后寻找指定的pattern ,若遇到文件尾，则从头再开始
* ``？pattern`` 向前寻找指定的pattern ,若遇到文件头，则从尾再开始
* ``n``         在上次指定的方向上，再次执行上次定义的查找
* ``N``         在上次指定的方向的相反方向上，再次执行上次定义的查找
* ``/pattern/+number``  将光标停在包含pattern的行后面第number行上
* ``/pattern/-number``   将光标停在包含pattern的行前面第number行上
* ``%``                  移到匹配的"（）"或"{}"上

选项设置
----------

* ``all``       列出所有选项设置情况
* ``term``      设置终端类型
* ``ignorance`` 在搜索中忽略大小写
* ``list``      显示制表位(Ctrl+I)和行尾标志（$)
* ``number``    显示行号
* ``report``    显示由面向行的命令修改过的数目
* ``terse``     显示简短的警告信息
* ``warn``      在转到别的文件时若没保存当前文件则显示NO write信息
* ``nomagic``   允许在搜索模式中，使用前面不带“\”的特殊字符
* ``nowrapscan``   禁止vi在搜索到达文件两端时，又从另一端开始
* ``mesg``         允许vi显示其他用户用write写到自己终端上的信息


替换命令
----------
命令::

    : ranges /pat1/pat2/g

说明:
    * ``:`` 这是Vi的命令执行界面
    * range 是命令执行范围的指定: 百分号（%）表示所有行
    * 点（.）表示当前行
    * 美元（$）表示最末行
    * s 表示其后是一个替换命令


* 简单命令:

    * ``:s/vivian/sky/`` 替换当前行第一个 vivian 为 sky
    * ``:s/vivian/sky/g`` 替换当前行所有 vivian 为 sky
    * ``:n,$s/vivian/sky/`` 替换第 n 行开始到最后一行中每一行的第一个 vivian 为 sky
    * ``:n,$s/vivian/sky/g`` 替换第 n 行开始到最后一行中每一行所有 vivian 为 sky
    * 说明:n 为数字，若 n 为 ``.`` ，表示从当前行开始到最后一行

* 字符串的首次出现进行替换 ``:g`` 放在命令开头，表示对正文中所有包含搜索字符串的行进行替换操作

    * ``:%s/vivian/sky/`` (等同于 ``:g/vivian/s//sky/`` ) 替换每一行的第一个 vivian 为 sky
    * ``:%s/vivian/sky/g`` (等同于 ``:g/vivian/s//sky/g`` ) 替换每一行中所有 vivian 为 sky

* 可以使用 # 作为分隔符，此时中间出现的 / 不会作为分隔符

    * ``:s#vivian/#sky/#`` 替换当前行第一个 vivian/ 为 sky/
    * ``:%s+/oradata/apras/+/user01/apras1+`` (使用+ 来 替换 / )： /oradata/apras/替换成/user01/apras1/


* 删除文本中的^M

    * 问题描述:对于换行,window下用回车换行(0A0D)来表示，linux下是回车(0A)来表示。这样，将window上的文件拷到unix上用时，总会有个^M.请写个用在unix下的过滤windows文件的换行符(0D)的shell或c程序。
    * 使用命令: ``cat filename1 | tr -d “^V^M” > newfile;``
    * 使用命令: ``sed -e “s/^V^M//” filename > outputfilename`` 
    * 说明: ^V和^M指的是Ctrl+V和Ctrl+M. **你必须要手工进行输入** ,而不是粘贴。
    * 在vi中处理：首先使用vi打开文件，然后按ESC键，接着输入命令: ``%s/^V^M//``
    * ``:%s/^M$//g``
    * 如果上述方法无用，则正确的解决办法是::

        tr -d "\r" < src >dest
        tr -d "\015" dest
        strings A>B



已熟悉
-------------

* 编辑: i
* 退出::

    Esc
    :

    * q   退出
    * q!  强制退出
    * wq  保存并退出





