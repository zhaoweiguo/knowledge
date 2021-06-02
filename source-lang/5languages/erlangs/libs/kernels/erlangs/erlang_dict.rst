进程字典
''''''''''
.. function:: put/2

::

  put(Key, Val) -> term()
  类型
  Key = Val = term()
  1.没有Key对应的值:
    增加此Key,返回值为undefined
  2.有此Key对应的值:
    替换此Key,返回原来的值


实例::

  > X = put(name, walrus).
  > Y = put(name, carpenter).
  > Z = get(name).
  > {X, Y, Z}.
  {undefined,walrus,carpenter}

注意::

  The values stored when put is evaluated within the scope of a catch are not retracted if a throw is evaluated, or if an error occurs.


.. function:: get/0

::

  get() -> [{Key, Val}]
  类型:
  Key = Val = term()
  返回全部进程字典

实例::

  > put(key1, merry).
  > put(key2, lambs).
  > put(key3, {are, playing}).
  > get().
  [{key1,merry},{key2,lambs},{key3,{are,playing}}]

.. function:: get/1

::

  get(Key) -> Val | undefined
  类型:
  Key = Val = term()
  Returns the value Val associated with Key in the process dictionary, or undefined if Key does not exist. Example:

实例::

  > put(key1, merry).
  > put(key2, lambs).
  > put({any, [valid, term]}, {are, playing}).
  > get({any, [valid, term]}).
  {are,playing}