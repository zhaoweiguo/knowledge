真实IP
######

获取真实ip方法(PHP)::

    if(isset($_SERVER['HTTP_X_FORWARDED_FOR'])){
      $ip = $_SERVER['HTTP_X_FORWARDED_FOR'];
    }elseif($_SERVER['REMOTE_ADDR']!=''){
      $ip = $_SERVER['REMOTE_ADDR'];
    }else{
      return $_SERVER['HTTP_CLIENT_IP'];
    }

    // 实例2:
    $x-forward = $_SERVER['HTTP_X_FORWARDED_FOR']
    $server-ip = $_SERVER['HTTP_CLIENT_IP']
    if ($x-forward && preg_match('/^([0-9]{1,3}\.){3}[0-9]{1,3}$/',$x-forward)) {  
          $onlineip = $x-forward;  
    } elseif  ( $server-ip && preg_match('/^([0-9]{1,3}\.){3}[0-9]{1,3}$/',$server-ip)) {  
          $onlineip = $server-ip; 
    }

3个变量说明::

    1.REMOTE_ADDR:浏览当前页面的用户计算机的ip地址
    2.HTTP_X_FORWARDED_FOR: 浏览当前页面的用户计算机的网关
    3.HTTP_CLIENT_IP:客户端的ip


.. note:: 如果客户端没有通过代理服务器来访问，那么用$_SERVER["HTTP_X_FORWARDED_FOR"] 取到的值将是空的

一、没有使用代理服务器的情况::

    REMOTE_ADDR = 您的 IP
    HTTP_VIA = 没数值或不显示
    HTTP_X_FORWARDED_FOR = 没数值或不显示

二、使用透明代理服务器的情 况：Transparent Proxies::

    REMOTE_ADDR = 最后一个代理服务器 IP 
    HTTP_VIA = 代理服务器 IP
    HTTP_X_FORWARDED_FOR = 您的真实 IP ，经过多个代理服务器时，这个值类似如下: 203.98.182.163, 203.129.72.215

    这类代理服务器还是将您的信息转发给您的访问对象，无法达到隐藏真实身份的目的。

三、使用普通匿名代理服务器的情况：Anonymous Proxies::

    REMOTE_ADDR = 最后一个代理服务器 IP 
    HTTP_VIA = 代理服务器 IP
    HTTP_X_FORWARDED_FOR = 代理服务器 IP ，经过多个代理服务器时，这个值类似如下: 203.98.182.163, 203.129.72.215

    隐藏了您的真实IP，但是向访问对象透露了您是使用代理服务器访问他们的。

四、使用欺骗性代理服务器的情况：Distorting Proxies::

    REMOTE_ADDR = 代理服务器 IP 
    HTTP_VIA = 代理服务器 IP 
    HTTP_X_FORWARDED_FOR = 随机的 IP,经过多个代理服务器时,这个值类似如下: 203.98.182.163, 203.129.72.215

    告诉了访问对象您使用了代理服务器，但编造了一个虚假的随机IP代替您的真实IP欺骗它。

五、使用高匿名代理服务器的情况：High Anonymity Proxies (Elite proxies)::

    REMOTE_ADDR = 代理服务器 IP
    HTTP_VIA = 没数值或不显示
    HTTP_X_FORWARDED_FOR = 没数值或不显示 ，经过多个代理服务器时，这个值类似如下: 203.98.182.163, 203.98.182.163

    完全用代理服务器的信息替代了您的所有信息，就象您就是完全使用那台代理服务器直接访问对象






