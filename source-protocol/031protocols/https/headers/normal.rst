常用
####

HTTP 中主要的头字段
===================

通用头::

    Date:
      表示请求和响应生成的日期

    Pragma
      表示数据是否允许缓存的通信选项

    Cache-Control(○)
      控制缓存的相关信息

    Connection(○)
      设置发送响应之后 TCP 连接是否继续保持的通信选项

    Transfer-Encoding(○)
      表示消息主体的编码格式

    Via(○)
      记录途中经过的代理和网关

请求头:用于表示请求消息的附加信息的头字段::

    Authorization
      身份认证数据

    From
      请求发送者的邮件地址

    If-Modified-Since
      如果希望仅当数据在某个日期之后有更新时才执行请求，可以在这个字段指定希望的日期。
      一般 来说，这个功能的用途在于判断客户端缓存的数据是否已经过期，如果已经过期则获取新的数据

    Referer
      当通过点击超级链接进入下一个页面时，在这里 会记录下上一个页面的 URI

    User-Agent
      客户端软件的名称和版本号等相关信息

    Accept(△○)
      客户端可支持的数据类型(Content-Type)，以 MIME 类型来表示

    Accept-Charset(△○)
      客户端可支持的字符集

    Accept-Encoding(△○)
      客户端可支持的编码格式(Content-Encoding)， 一般来说表示数据的压缩格式

    Accept-Language(△○)
      客户端可支持的语言，汉语为 zh，英语为 en

    Host(○)
      接收请求的服务器 IP 地址和端口号

    If-Match(○)
      参见 Etag

    If-None-Match(○)
      参见 Etag

    If-Unmodified-Since(○)
      当指定日期之后数据未更新时执行请求

    Range(○)
      当需要只获取部分数据而不是全部数据时，可通 过这个字段指定要获取的数据范围

响应头:用于表示响应消息的附加信息的头字段::

    Location
      表示信息的准确位置。当请求的 URI 为相对路径 时，这个字段用来返回绝对路径

    Server
      服务器程序的名称和版本号等相关信息

    WWW-Authenticate
      当请求的信息存在访问控制时，返回身份认证用的数据(Challenge 1)

    Accept-Ranges(○)
      当希望仅请求部分数据(使用 Range 来指定范围) 时，服务器会告知客户端是否支持这一功能

实体头:用于表示实体(消息体)的附加信息的头字段::

    Allow
      表示指定的 URI 支持的方法

    Content-Encoding
      当消息体经过压缩等编码处理时，表示其编码格式

    Content-Length
      表示消息体的长度

    Content-Type
      表示消息体的数据类型，以 MIME 规格定义的数 据类型来表示

    Expires
      表示消息体的有效期

    Last-Modified
      数据的最后更新日期

    Content-Language(○)
      表示消息体的语言。汉语为 zh，英语为 en

    Content-Location(○)
      表示消息体在服务器上的位置(URI)

    Content-Range(○)
      当仅请求部分数据时，表示消息体包含的数据范围

    Etag(○)
      在更新操作中，有时候需要基于上一次请求的响应数据来发送下一次请求。
      在这种情况下，这个字段 可以用来提供上次响应与下次请求之间的关联信息。
      上次响应中，服务器会通过 Etag 向客户端发送一个唯一标识，
      在下次请求中客户端可以通过 If- Match、If-None-Match、If-Range 字段将这个标识 告知服务器，
      这样服务器就知道该请求和上次的响应是相关的。
      这个字段的功能和 Cookie 是相同的， 但 Cookie 是网景(Netscape)公司自行开发的规格，
      而 Etag 是将其进行标准化后的规格










