filelib模块
###############

File utilities, such as wildcard matching of filenames.

.. function:: wildcard/1/2

格式::

    wildcard(Wildcard) -> [file:filename()]
    wildcard(Wildcard, Cwd) -> [file:filename()]
    类型:
    Wildcard = filename() | dirname()
    Cwd = dirname()

说明::

    返回匹配Unix-style wildcard string Wildcard的所有文件列表

实例::

    % 查看所有app的beam文件
    filelib:wildcard("lib/*/ebin/*.beam").
    % 查看指定目录下的的beam文件
    filelib:wildcard("*.beam", "/tmp/").
    % 查找.erl或.hrl文件
    filelib:wildcard("lib/*/src/*.?rl")
    % 等同于
    filelib:wildcard("lib/*/src/*.{erl,hrl}")
    % 找到所有子目录中.erl文件和.hrl文件
    filelib:wildcard("lib/**/*.{erl,hrl}")

.. function:: is_regular/1

格式::

    is_regular(Name) -> boolean()

说明::

    Returns true if Name refers to a (regular) file, otherwise false.














