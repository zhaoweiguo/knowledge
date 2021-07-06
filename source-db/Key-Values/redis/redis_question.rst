redis常见问题
#################

redis的key字符串中不能有空格和回车
------------------------------------
::

    redis-cli KEYS "key_*" | xargs redis-cli DEL


.. warning:: 

    keys 指令可以进行模糊匹配，但如果 Key 含空格，就匹配不到了

带空格的解决方案::

    1.把所有的命令都保存到一个文件中
    redis-cli -n 0 keys "*关键字*"  >> /home/bi_dev/b.txt

    2.将/home/bi_dev/b.txt下载到本地
    在每一行的头和尾加上"，由于key可能存储空格，导致无法匹配删除

    3.上传替换原来的/home/bi_dev/b.txt文件

    4.执行以下命名删除key
    cat /home/bi_dev/b.txt | xargs redis-cli -n 0 del

其他方案(未验证) [1]_::

    // 直接命令行增加""
    redis-cli keys "key_*" | xargs -I {} redis-cli del “{}”

NOAUTH Authentication required
------------------------------

错误说明::

    redis> get <key>
    (error) NOAUTH Authentication required.

原因::

    没有加密码、或密码错误


.. [1] https://blog.csdn.net/weixin_39049216/article/details/90765129




