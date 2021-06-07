.. _http_method:

HTTP Method方法
###############

* Http定义了与服务器交互的不同方法，最基本的方法有4种，分别是GET，POST，PUT，DELETE
* HTTP中的GET，POST，PUT，DELETE就对应着对这个资源的查 ，改 ，增 ，删 4个操作
* 其他还有OPTIONS、HEAD、TRACE等
* http协议规定以ASCII码传输，建立在tcp，ip协议这上的引用规范，规范内容把http请求分成3个部分，状态行，请求头，请求体。所有的方法，实现都是围绕如何使用和组织这三部分来完成了



HTTP 的主要方法::

    1. GET:
      获取 URI 指定的信息。
      如果 URI 指定的是文件，则 返回文件的内容;
      如果 URI 指定的是 CGI 程序，则 返回该程序的输出数据
    2. POST
      从客户端向服务器发送数据。一般用于发送表单中 填写的数据等情况下
    3. HEAD
      和 GET 基本相同。
      不过它只返回 HTTP 的消息头 (message header)，而并不返回数据的内容。
      用于获取文件最后更新时间等属性信息
    4. OPTIONS
      用于通知或查询通信选项
    5. PUT
      替换 URI 指定的服务器上的文件。
      如果 URI 指定的 文件不存在，则创建该文件
    6. DELETE
      删除 URI 指定的服务器上的文件
    7. TRACE
      将服务器收到的请求行和头部(header)直接返回 给客户端。
      用于在使用代理的环境中检查改写请求的情况
    8. CONNECT
      使用代理传输加密消息时使用的方法



HTTP协议的格式
==============

* HTTP请求::

    <request line>
    <headers>
    <blank line>
    <request-body>]


* HTTP响应::

    <status line>
    <headers>
    <blank line>
    [<response-body>]

实例说明
========

* GET請求::

    GET /books/?sex=man&name=Professional HTTP/1.1
    Host: www.wrox.com
    User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.6)Gecko/20050225 Firefox/1.0.1
    Connection: Keep-Alive

* GET响应::

    HTTP/1.1 200 OK
    Content-Type: text/xml; charset=utf-8
    Content-Length: length

    <?xml version="1.0" encoding="utf-8"?>
    <objPlaceOrderResponse xmlns="https://api.efxnow.com/webservices2.3">
    <Success>boolean</Success>
    <ErrorDescription>string</ErrorDescription>
    <ErrorNumber>int</ErrorNumber>
    <CustomerOrderReference>long</CustomerOrderReference>
    <OrderConfirmation>string</OrderConfirmation>
    <CustomerDealRef>string</CustomerDealRef>
    </objPlaceOrderResponse>


* POST請求::

    POST / HTTP/1.1
    Host: www.wrox.com
    User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.6)
    Gecko/20050225 Firefox/1.0.1
    Content-Type: application/x-www-form-urlencoded
    Content-Length: 40
    Connection: Keep-Alive
       （----此处空一行----）
    name=Professional%20Ajax&publisher=Wiley

* POST响应::

    HTTP/1.1 200 OK
    Content-Type: text/xml; charset=utf-8
    Content-Length: length

    <?xml version="1.0" encoding="utf-8"?>
    <objPlaceOrderResponse xmlns="https://api.efxnow.com/webservices2.3">
    <Success>boolean</Success>
    <ErrorDescription>string</ErrorDescription>
    <ErrorNumber>int</ErrorNumber>
    <CustomerOrderReference>long</CustomerOrderReference>
    <OrderConfirmation>string</OrderConfirmation>
    <CustomerDealRef>string</CustomerDealRef>
    </objPlaceOrderResponse>


* SOAP 1.2請求::

    POST /DEMOWebServices2.8/Service.asmx HTTP/1.1
    Host: api.efxnow.com
    Content-Type: application/soap+xml; charset=utf-8
    Content-Length: length

    <?xml version="1.0" encoding="utf-8"?>
    <soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">
       <soap12:Body>
          <CancelOrder xmlns="https://api.efxnow.com/webservices2.3">
              <UserID>string</UserID>
              <PWD>string</PWD>
              <OrderConfirmation>string</OrderConfirmation>
          </CancelOrder>
       </soap12:Body>
    </soap12:Envelope>

* SOAP 1.2响应::

    HTTP/1.1 200 OK
    Content-Type: application/soap+xml; charset=utf-8
    Content-Length: length

    <?xml version="1.0" encoding="utf-8"?>
    <soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">
      <soap12:Body>
        <CancelOrderResponse xmlns="https://api.efxnow.com/webservices2.3">
            <CancelOrderResult>
                <Success>boolean</Success>
                <ErrorDescription>string</ErrorDescription>
                <ErrorNumber>int</ErrorNumber>
                <CustomerOrderReference>long</CustomerOrderReference>
                <OrderConfirmation>string</OrderConfirmation>
                <CustomerDealRef>string</CustomerDealRef>
            </CancelOrderResult>
        </CancelOrderResponse>
     </soap12:Body>
   </soap12:Envelope>

