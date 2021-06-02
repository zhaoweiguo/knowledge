常用
####

http 请求格式::

    http://<user>:<password>@www.glasscom.com:<80>/dir/file1.htm
    注<>代表可选

要在发送请求的时候添加HTTP Basic Authentication认证信息到请求中，有两种方法::

    1. 在请求头中添加Authorization:
    Authorization: "Basic 用户名和密码的base64加密字符串"
    2. 在url中添加用户名和密码:
    http://userName:password@api.minicloud.com.cn/statuses/friends_timeline.xml





