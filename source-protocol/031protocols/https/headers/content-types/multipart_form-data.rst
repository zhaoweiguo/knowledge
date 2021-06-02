multipart/form-data
========================

multipart/form-data也是在post基础上演变而来的，具体如下::

    1.multipart/form-data的基础方式是post，也就是说通过post组合方式来实现的。
    2.multipart/form-data于post方法的不同之处在于请求头和请求体。

multipart/form-data请求头::

    必须包含一个特殊的头信息:
        Content-Type，其值必须为multipart/form-data，
    同时还需要规定一个内容分割用于分割请求体中多个post的内容，如:
        文件内容和文本内容是需要分隔开来的，不然接收方就无法解析和还原这个文件了

具体的头信息如下::

    Content-Type: multipart/form-data; boundary=${bound}  
    其中${bound} 是一个占位符，代表我们规定的分割符，可以自己任意规定，
    但为了避免和正常文本重复了，尽量要使用复杂一点的内容。
    如：
    --------------------56423498738365
    ----WebKitFormBoundaryDrzZzsaBKZfqWto3


multipart/form-data的请求体::

    也是一个字符串，不过和post的请求体不同的是它的构造方式，
    post是简单的name=value键值连接，
    而multipart/form-data是添加了分隔符等内容的构造体

具体请求体如下::

    --${bound}
    Content-Disposition: form-data; name="Filename"

    HTTP.pdf
    --${bound}
    Content-Disposition: form-data; name="file000"; filename="HTTP协议详解.pdf"
    Content-Type: application/octet-stream

    %PDF-1.5
    file content
    %%EOF

    --${bound}
    Content-Disposition: form-data; name="Upload"

    Submit Query
    --${bound}--

    其中${bound}是之前头信息中的分隔符，如果头信息中规定是123，那这里也要是123；
    可以很容易看到，这个请求体是多个相同部分组成的:
      每一部分都是以--加分隔符开始，
        然后是该部分内容的描述信息，然后一个回车，然后是描述信息的具体内容；
    如果传送的内容是一个文件的话，那么还会包含文件名信息以及文件内容类型。
    上面第二部分是一个文件体的结构，

    最后以--分隔符--结尾，表示请求体结束。





php socket模拟 ``multipart/form-data`` 类型请求:

.. literalinclude:: /files/phps/php_multipart_socket.php
   :language: php
   :linenos:



