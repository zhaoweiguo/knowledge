内置函数(标准库函数)
####################


::

    int(x)    # convert to Integers
    str(x)    # convert to Strings
    list(x)   # convert to List



exec和eval语句::

    exec('print("Hello World")')  # Hello World
    eval('print("Hello World")')  # Hello World

    exec('2*3')     # 返回值为空
    eval('2*3')     # 返回值为6


assert语句::

    # assert语句用来声明某个条件是真的
    # 当assert语句失败的时候，会引发一个AssertionError
    mylist = ['item']
    assert len(mylist) >= 1
    mylist.pop()
    assert len(mylist) >= 1
    # Traceback (most recent call last):
    #  File "<stdin>", line 1, in ?
    #  AssertionError


repr函数(用来取得对象的规范字符串表示)::

    i = []
    i.append('item')
    # repr函数
    repr(i)
    # 反引号（也称转换符）可以完成相同的功能
    `i`

.. note:: 函数 str () 用于将值转化为适于人阅读的形式，而 repr () 转化为供解释器读取的形式





内置函数::

  open(filename[, mode[, bufsize]])
  参数:
   r:read
   a:append
   w:write
   b:binary(text mode will treat ``\n``, ``\r\n``, ``\r`` different in different system)

   file.tell()
   返回file’s current position, 同 stdio‘s ftell()

   file.seek(offset[, whence])
       f.seek(2, os.SEEK_CUR)     //advances the position by two
       f.seek(-3, os.SEEK_END)    //sets the position to the third to last




