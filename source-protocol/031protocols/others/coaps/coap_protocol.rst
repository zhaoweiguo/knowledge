Coap协议
#############


CoAP消息类型::

  CON——需要被确认的请求,如果CON请求被发送,那么对方必须做出响应
  NON——不需要被确认的请求,如果NON请求被发送,那么对方不必做出回应
  ACK——应答消息,接受到CON消息的响应
  RST——复位消息,当接收者接受到的消息包含一个错误,接受者解析消息或者不再关心发送者发送的内容,那么复位消息将会被发送

CoAP消息结构::

    [Ver]版本Version: 类似于IPv6和IPv6,仅仅是一个版本号。
    [T]消息类型MessageType: CON,NON,ACK,RST。
    [TKL]CoAP标识符长度
      CoAP协议中具有两种功能相似的标识符:
      一种为Message ID（报文编号）,一种为Token（标识符）
      其中每个报文均包含消息编号，但是标识符对于报文来说是非必须的
    [Code]功能码/响应码:
      Code在CoAP请求报文和响应报文中具有不同的表现形式
      Code占一个字节，它被分成了两部分，前3位一部分，后5位一部分，为了方便描述它被写成了c.dd结构
      其中0.XX表示CoAP请求的某种方法，而2.XX、4.XX或5.XX则表示CoAP响应的某种具体表现
    [MessageID]消息ID MessageID: 每个CoAP消息都有一个ID,在一次会话中ID总是保持不变,但在这个会话之后该ID会被回收利用
    [Token]标记Token: 标记是ID的另一种表现
    [Option]选项Options: 
      CoAP选项类似于HTTP请求头,它包括CoAP消息本身,例如CoAP端口号,CoAP主机和CoAP查询字符串等
    负载Payload: 真正有用的被交互的数据。


Code部分详解::

    3.1 请求
      【0.01】GET方法——用于获得某资源
      【0.02】POST方法——用于创建某资源
      【0.03】PUT方法——用于更新某资源
      【0.04】DELETE方法——用于删除某资源
    3.2 响应
      【2.01】Created
      【2.02】Deleted
      【2.03】Valid
      【2.04】Changed
      【2.05】Content。类似于HTTP 200 OK
      
      【4.00】Bad Request 请求错误，服务器无法处理。类似于HTTP 400。
      【4.01】Unauthorized 没有范围权限。类似于HTTP 401。
      【4.02】Bad Option 请求中包含错误选项。
      【4.03】Forbidden 服务器拒绝请求。类似于HTTP 403。
      【4.04】Not Found 服务器找不到资源。类似于HTTP 404。
      【4.05】Method Not Allowed 非法请求方法。类似于HTTP 405。
      【4.06】Not Acceptable 请求选项和服务器生成内容选项不一致。类似于HTTP 406。
      【4.12】Precondition Failed 请求参数不足。类似于HTTP 412。
      【4.15】Unsuppor Conten-Type 请求中的媒体类型不被支持。类似于HTTP 415。

      【5.00】Internal Server Error 服务器内部错误。类似于HTTP 500。
      【5.01】Not Implemented 服务器无法支持请求内容。类似于HTTP 501。
      【5.02】Bad Gateway 服务器作为网关时，收到了一个错误的响应。类似于HTTP 502。
      【5.03】Service Unavailable 服务器过载或者维护停机。类似于HTTP 503。
      【5.04】Gateway Timeout 服务器作为网关时，执行请求时发生超时错误。类似于HTTP 504。
      【5.05】Proxying Not Supported 服务器不支持代理功能。

Option部分详解::

       一般情况下Option部分包含Option Delta、Option Length和Option Value三部分。
      【Option Delta】表示Option的增量，当前的Option的具体编号等于之前所有Option Delta的总和。
      【Option Length】表示Option Value的具体长度。
      【Option Value】表示Option具体内容

Content-Format描述::

      【text/plain】 编号为0，表示负载为字符串形式，默认为UTF8编码。
      【application/link-format】编号为40，CoAP资源发现协议中追加定义，该媒体类型为CoAP协议特有。
      【application/xml】编号为41，表示负载类型为XML格式。
      【application/octet-stream】编号为42，表示负载类型为二进制格式。
      【application/exi】编号为47，表示负载类型为“精简XML”格式。（翻译不一定准确）

      还有一种格式也被IANA认定，也会在CoAP协议中广泛使用那便是CBOR格式
      该格式可理解为二进制JSON格式
      【applicaiton/cbor】编号为60

::

  % CoAP核心协议 RFC 7252
  https://datatracker.ietf.org/doc/rfc7252/
  % CoAP资源发现 RFC 6690
  https://datatracker.ietf.org/doc/rfc6690/








