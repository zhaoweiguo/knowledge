appup
########
Application upgrade file

说明::

  此文件用于定义如何在running system中升降级.
  此文件被用于函数systools生成release upgrade file

语法::

  {Vsn,
  [{UpFromVsn, Instructions}, ...],
  [{DownToVsn, Instructions}, ...]}.







