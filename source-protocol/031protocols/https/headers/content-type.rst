Content-Type
##################


.. toctree::
   :maxdepth: 2

   content-types/multipart_form-data



::

   application/x-www-form-urlencoded 表示在发送前编码所有字符（默认）
   application/json

   multipart/form-data 不对字符编码。在使用包含文件上传控件的表单时，必须使用该值
      传的数据是数组

   text/plain 空格转换为 "+" 加号，但不对特殊字符编码。
   text/html

   image/jpeg
   image/png

Content-Type 定义的数据类型::

   主类型         含  义           子类型示例
   text        表示文本数据         text/html      HTML 文档
                                  text/plain     纯文本
   image       表示图像数据         image/jpeg     JPEG 格式的图片
                                  image/gif      GIF 格式的图片
   audio       表示音频数据         audio/mpeg     MP2、MP3 格式的音频
   video       表示视频数据         video/mpeg     MPEG 格式的视频
                                  video/quicktime  Quicktime 格式的视频
   model       物体等形状和动作建模数据     model/vrml     VRML 格式的建模数据
   application 应用程序的数据        application/pdf      PDF 格式的文档数据
                                  application/msword    MS-WORD 格式的文档数据
   message     存放邮件等消息用的类型    message/rfc822    一般的邮件数据，包含 From:、Date: 等头部数据
   multipart   消息体中包含多个部分的数据  multipart/mixed   消息体中包含各种不同格式的数据
                                                         其中每个部分的数据都有单独定义的媒体类型





