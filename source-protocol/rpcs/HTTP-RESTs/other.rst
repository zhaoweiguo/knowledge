Rest相关
########

RESTful架构风格最初由Roy T. Fielding（HTTP/1.1协议专家组负责人）在其2000年的博士学位论文中提出。HTTP就是该架构风格的一个典型应用。


RESTful架构风格的特点
=====================

资源::

    所谓"资源"，就是网络上的一个实体，或者说是网络上的一个具体信息。


统一接口::

    RESTful架构风格规定，数据的元操作，即:
      CRUD(create, read, update和delete,即数据的增删查改)操作
    分别对应于HTTP方法:
      GET用来获取资源，POST用来新建资源（也可以用于更新资源），PUT用来更新资源，DELETE用来删除资源
    这样就统一了数据操作的接口，仅通过HTTP方法，就可以完成对数据的所有增删查改工作

    GET（SELECT）：从服务器取出资源（一项或多项）。
    POST（CREATE）：在服务器新建一个资源。
    PUT（UPDATE）：在服务器更新资源（客户端提供完整资源数据）。
    PATCH（UPDATE）：在服务器更新资源（客户端提供需要修改的资源数据）。
    DELETE（DELETE）：从服务器删除资源。

URI::

    可以用一个URI（统一资源定位符）指向资源，即每个URI都对应一个特定的资源
    要获取这个资源，访问它的URI就可以，因此URI就成了每一个资源的地址或识别符

    一般的，每个资源至少有一个URI与之对应，最典型的URI即URL

无状态::

    所谓无状态的，即所有的资源，都可以通过URI定位，而且这个定位与其他资源无关，也不会因为其他资源的变化而改变。


ROA,SOA,REST与RPC
=================

ROA即Resource Oriented Architecture，RESTful 架构风格的服务是围绕资源展开的，是典型的ROA架构（虽然“A”和“架构”存在重复，但说无妨），虽然ROA与SOA并不冲突，甚至把ROA看做SOA的一种也未尝不可，但由于RPC也是SOA，比较久远一点点论文、博客或图书也常把SOA与RPC混在一起讨论，因此，RESTful 架构风格的服务通常被称之为ROA架构，很少提及SOA架构，以便更加显式的与RPC区分。

RPC风格曾是Web Service的主流，最初是基于XML-RPC协议（一个远程过程调用（remote procedure call，RPC)的分布式计算协议），后来渐渐被SOAP协议（简单对象访问协议（Simple Object Access Protocol））取代；RPC风格的服务，不仅可以用HTTP，还可以用TCP或其他通信协议。但RPC风格的服务，受开发服务采用语言的束缚比较大，如.NET框架中，开发web service的传统方式是使用WCF，基于WCF开发的服务即RPC风格的服务，使用该服务的客户端通常要用C#来实现，如果使用python或其他语言，很难实现可以直接与服务通信客户端；进入移动互联网时代后，RPC风格的服务很难在移动终端使用，而RESTful风格的服务，由于可以直接以json或xml为载体承载数据，以HTTP方法为统一接口完成数据操作，客户端的开发不依赖于服务实现的技术，移动终端也可以轻松使用服务，这也加剧了REST取代RPC成为web service的主导。

RPC与RESTful的区别如下面两个图所示:

.. image:: /images/protocols/http_rest_rpc_service.png

.. image:: /images/protocols/http_rest_restful_service.png


本真REST与hybrid风格
====================

通常开发者做服务相关的客户端开发时，使用的所谓RESTful服务，基本可分为本真REST和hybrid风格两类。本真REST即我上文阐述的RESTful架构风格，具有上述的4个特点，是真正意义上的RESTful风格；而hybrid风格，只是借鉴了RESTful的一些优点，具有一部分RESTful的特点，但对外依然宣称是RESTful风格的服务。（窃以为，正是由于hybrid风格服务混淆了RESTful的概念，才在RESTful架构风格提出了本真REST的概念，以为了划分界限 :P）

hybrid风格的最主流的用法是，使用GET方法获取资源，用POST方法实现资源的创建、修改和删除。hybrid风格之所以存在，据我了解有两种来源：一种情况是因为，某些开发者并没有真正理解何为RESTful架构风格，导致开发的服务貌合神离；而主流的原因是由于历史包袱 —— 服务本来是RPC风格的，由于上文提到的RPC的劣势及RESTful的优势，开发者在RPC风格的服务上又包装了一层RESTful的外壳，通常这层外壳只为获取资源服务，因此会按RESTful风格实现GET方法，如果客户端提出一些简单的创建、修改或删除数据的需求，则通过HTTP协议中最常用的POST方法实现相应功能




参考
====

* RESTful 架构风格概述 [1]_



.. [1] https://blog.igevin.info/posts/restful-architecture-in-general/