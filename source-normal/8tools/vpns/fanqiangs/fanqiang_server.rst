启动ssh隧道
====================

linux下操作 [1]_
-------------------

* 直接使用终端,输入::

    ssh -D 7070 username@yourserver.com

* 使用gSTM客户端(ubuntu)::

    apt-get install gstm
    “应用程序->互联网“菜单下面找到:gSTM

* gSTM客户端使用:

.. figure:: /images/fanqiangs/mytunnel.png
   :width: 80%

.. figure:: /images/fanqiangs/mini-gstm-edit-redirection-mini.png
   :width: 80%

windows下操作
------------------


使用Tunnelier这个软件

* 首先打开软件后设置登入信息. 打开login选项, 然后看图:

.. figure:: /images/fanqiangs/Bitvise-Tunnelier-SSH2-Client.png
   :width: 80%

* 打开Options选项 按图来就可以了 其他的不需要动:

.. figure:: /images/fanqiangs/Bitvise-Tunnelier-SSH2-Client2.png
   :width: 80%

* Options选择完后 接着打开Services选项:

.. figure:: /images/fanqiangs/Bitvise-Tunnelier-SSH2-Client3.png
   :width: 80%



.. [1] http://blog.csdn.net/luosiyong/article/details/7685273


