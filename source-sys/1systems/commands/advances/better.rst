更好的工具
##########

rm
==

* rmtrash: https://github.com/LaiJingli/rmtrash
* 安装::
  
    $ brew install rmtrash
    alias rm="rmtrash"


grep
====

* https://github.com/BurntSushi/ripgrep
* It skips files ignored by .gitignore and hidden ones
* 使用::

    rg "search" ./path


find
====

- fda='fd -IH'
- https://github.com/sharkdp/fd

安装::

    brew install fd

diff
====

- colordiff
    - https://www.colordiff.org/
- diff-so-fancy
    - https://github.com/so-fancy/diff-so-fancy


tldr-man
========

::

    brew install tldr

    tldr=Too Long; Didn't Read
    简化了烦琐的 man 指令帮助文档，仅列出常用的该指令的使用方法
    代替 man 命令的，如:
    man python  => tldr python

ncdu-du
=======

ncdu::

    brew install ncdu
    类似 du 命令，但更智能



ls
==

- exa
    - 代替 ls
    - https://the.exa.website/


cat
===

- bat
    - 代替 cat 和 less(?)
- lolcat


todo
====

taskwarrior::

    命令行版 todo


