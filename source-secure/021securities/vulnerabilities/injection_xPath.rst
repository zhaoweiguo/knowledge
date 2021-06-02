XPath injection
###############
  
XPath基础
=========

概念::

    XPath 即为 XML 路径语言，是 W3C XSLT 标准的主要元素
    它是一种用来确定 XML（标准通用标记语言的子集）文档中某部分位置的语言

在 XPath 中，有七种类型的节点::

    元素、属性、文本、命名空间、处理指令、注释以及文档节点（或称为根节点）

节点之间存在父、子、先辈、后代、同胞关系，以下面「实例1」中的t3stt3st.xml为例::

    根节点<root1> 、元素节点<user><username><key><hctfadmin> 
    属性节点name='user1'
    <root1>是<user>和<htcfadmin>的父节点
    同时也是<user><hctfadmin><username><key>的先辈
    <username>和<key>是同胞节点

路径表达式::

    表达式             描述
    nodename        选取此节点的所有子节点
    /               从根节点选取
    //              从匹配选择的当前节点选择文档中的节点，而不考虑它们的位置
    .               选取当前节点
    ..              选取当前节点的父节点
    @               选取属性
    []              查找某个特定的节点或者包含某个指定的值的节点

通配符::

    通配符       描述
    *           匹配任何元素节点
    @*          匹配任何属性节点
    node()      匹配任何类型的节点

XPath注入攻击
==============

XPath 注入攻击是指利用XPath 解析器的松散输入和容错特性，能够在URL、表单或其它信息上附带恶意的XPath 查询代码，以获得权限信息的访问权并更改这些信息。



实例1
=====

index.php::

    <?php
    $re = array('and','or','count','select','from','union','group','by','limit','insert','where','order','alter','delete','having','max','min','avg','sum','sqrt','rand','concat','sleep');
    setcookie('injection','c3FsaSBpcyBub3QgdGhlIG9ubHkgd2F5IGZvciBpbmplY3Rpb24=',time()+100000);
    if(file_exists('t3stt3st.xml')) {
        $xml = simplexml_load_file('t3stt3st.xml');
        $user=$_GET['user'];
        $user=str_replace($re, ' ', $user);
        $query="user/username[@name='".$user."']";
      
        $ans = $xml->xpath($query);
        foreach($ans as $x => $x_value)
        {
            echo $x.":  " . $x_value;
            echo "<br />";
        }
    }
    ?>  

t3stt3st.xml::

    <?xml version="1.0" encoding="utf-8"?>
    <root1>
        <user>
            <username name='user1'>user1</username>
            <key>KEY:1</key>
            <username name='user2'>user2</username>
            <key>KEY:2</key>
            <username name='user3'>user3</username>
            <key>KEY:3</key>
            <username name='user4'>user4</username>
            <key>KEY:4</key>
        </user>
        <hctfadmin>    
            <username name='hctf1'>hctf</username>
            <key>flag:hctf{Dd0g_fac3_t0_k3yboard233}</key>
        </hctfadmin>
    </root1>


XPath注入说明::

    从index.php源码可知XPath查询语句为$query="user/username[@name='".$user."']"
    $user经过关键字替换, 但是黑名单$re中都为SQL关键字，所以并不影响对XPath进行注入
    如: 我们可以构造payload如 ']|//*|zzz['来进行注入，获取文档中的所有元素节点


实例2
=====

查询基本语句::

    //users/user[loginID/text()=’abc’ and password/text()=’test123’]
    如果黑客在loginID 字段中输入：' or 1=1 并在 password 中输入：' or 1=1
    就能绕过校验，成功获取所有user数据
    //users/user[LoginID/text()=''or 1=1 and password/text()=''or 1=1]






参考
====

* https://www.jianshu.com/p/a3d06d9f2e1b












