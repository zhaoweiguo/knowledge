.. _tsung_config:

tsung参考文档说明
=======================

默认编码
-----------

默认编码为utf-8，你可以根据需要进行修改，如::

    <?xml version=”1.0″ encoding=”ISO-8859-1″?>

配置文件的整体结构
--------------------

它是由下面这些标签构成:

    * 顶级标签<tsung>
    * 客户端标签<clients>
    * 服务端标签<servers>
    * 监控标签<monitor>
    * 负载标签<load>
    * 选项标签<options>
    * 过程标签<sessions>

顶级标签
----------

顶级标签是tsung,如::

    <?xml version=”1.0″?>
    <!DOCTYPE tsung SYSTEM “/usr/share/tsung/tsung-1.0.dtd” [] >
    <tsung loglevel=”info”>
    …
    </tsung>

参数::

    dumptraffic:
    * true:所有的通信都会被记录，注：这会大大降低tsung速度，一般是用于调试
    * light:只转储前44字节

    loglevel:
    * emergency
    * critical
    * error
    * warning(推荐)
    * notice (默认)
    * info
    * debug(需要察看详细信息时，注：使用这个属性时要用make debug重新编译tsung)


客户端标签与服务端标签(这两个有关联，需对照理解)
----------------------------------------------------

简单设置::

    <clients>
        <client host=”localhost” use_controller_vm=”true”/>
    </clients>
    <servers>
        <server host=”127.0.0.1″ port=”80″ type=”tcp”></server>
    </servers>

高级设置::

    <clients>
        <client host=”louxor” weight=”1″ maxusers=”800″>
            <ip value=”10.9.195.12″></ip>
            <ip value=”10.9.195.13″></ip>
        </client>
        <client host=”memphis” weight=”3″ maxusers=”600″ cpu=”2″/>
    </clients>
    <servers>
        <server host=”10.9.195.1″ port=”8080″ type=”tcp”></server>
    </servers>

监控标签
----------

tsung监控多个远程服务器.可以在<monitor>标签中配置.可统计的数据有::

    * cpu使用情况
    * 平均的工作量情况
    * 内存利用情况

你可以从作业调试器得到监控结点，如::

    <monitor batch=”true” host=”torque” type=”erlang”></monitor>

注:这儿支持多种类型的远程代理(默认是erlang)

负载标签
--------

随机生成用户::

    <load>
        <arrivalphase phase="1" duration=”10″ unit=”minute”>
          <users interarrival=”2″ unit=”second”></users>
        </arrivalphase>
        <arrivalphase phase="2" duration=”10″ unit=”minute”>
          <users interarrival=”1″ unit=”second”></users>
        </arrivalphase>
        <arrivalphase phase="3" duration=”10″ unit=”minute”>
          <users interarrival=”0.1″ unit=”second”></users>
        </arrivalphase>
    </load>


interarrival::

    % 第2阶段10分钟,每1秒新增1个用户
    <arrivalphase phase="2" duration=”10″ unit=”minute”>
      <users interarrival=”1″ unit=”second”></users>
    </arrivalphase>


arrivalrate::

    % 第1阶段10分钟, 每秒新增10个用户
    <arrivalphase phase="1" duration="10" unit="minute">
        <users arrivalrate="10" unit="second"></users>
    </arrivalphase>

注:还可以用load标签中用loop属性来让整个过程执行多次，如：loop=’2′的意思是这序列被循环两次，所以整天负载被执行三次。(这个要在版本1.2.2之后可用)

静态生成用户::

     你想在测试的过程中在指定的时间上启动给定的session，你的愿望在1.3.1版本之后可以实现:
     <load>
         <arrivalphase phase=”1″ duration=”10″ unit=”minute”>
             <users interarrival=”2″ unit=”second”></users>
         </arrivalphase>
         <user session=”http-example” start_time=”185″ unit=”second”></user>
         <user session=”http-example” start_time=”10″ unit=”minute”></user>
         <user session=”foo” start_time=”11″ unit=”minute”></user>
     </load>
     <sessions>
         <session name=”http-example” probability=”0″ type=”ts_http”>
             <request> <http url=”/” method=”GET”></http> </request>
         </session>
         <session name=”foo” probability=”100″ type=”ts_http”>
             <request> <http url=”/” method=”GET”></http> </request>
         </session>
     <sessions>

注: 在这个例子中，有两个session，一个的probability为“0”(因此在第一阶段不会被执行，就是随机生成用户部分)， 而另一个是100。在测试开始之后，我们设置3个用户分别启动，第一个在3分5秒(执行http-example session)启动，第二个在10分钟后启动(http-example session)，最后一个在11分钟后启动(foo session)。

负载测试的过程::

    默认情况下，tsung在所有用户都完成他们的session之后结束，因此这会比用户生成的过程要长的多。
    如果你想要停止tsung而不管阶段是否完成，也不管是否有session正处于激活状态。
    那么你可以在load标签中增加duration属性(版本1.3.2后有效):

    <load duration=”1″ unit=”hour”>
        <arrivalphase phase=”1″ duration=”10″ unit=”minute”>
            <users interarrival=”2″ unit=”second”></users>
        </arrivalphase>
    </load>

    当前最大值是50天，unit可以是”second”, “minute”, “hour”

option标签
------------

全局变量的默认值可以在这儿进行设定，比如::

    * 场景中两次请求间的思考时间
    * ssl加密算法
    * tcp/udp缓存大小(默认是32K)

如果override设置为true，这些值会把session配置文件中的对应值覆盖::

    <option name=”thinktime” value=”3″ random=”false” override=”true”/>
    <option name=”ssl_ciphers” value=”EXP1024-RC4-SHA,EDH-RSA-DES-CBC3-SHA”/>
    <option name=”tcp_snd_buffer” value=”16384″></option>
    <option name=”tcp_rcv_buffer” value=”16384″></option>
    <option name=”udp_snd_buffer” value=”16384″></option>
    <option name=”udp_rcv_buffer” value=”16384″></option>

XMPP/Jabber 选项::

    暂略…

http 选项::

    对应http，你可以设定UserAgent的值[版本1.1.0后]
    对每个user_agent都有一个probability属性(所有的probability值的和是100)，如:

    <option type=”ts_http” name=”user_agent”>
        <user_agent probability=”80″>
            Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Galeon/1.3.21
        </user_agent>
        <user_agent probability=”20″>
            Mozilla/5.0 (Windows; U; Windows NT 5.2; fr-FR; rv:1.7.8) Gecko/20050511 Firefox/1.0.4
        </user_agent>
    </option>

session标签
------------






