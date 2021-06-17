.. _sendmail:

sendmail发送邮件使用
##############################

* 官网: http://caspian.dotconf.net/menu/Software/SendEmail/
* 下载::

    wget http://caspian.dotconf.net/menu/Software/SendEmail/sendEmail-v1.56.tar.gz
    # 直接解压使用

* 常见使用方法(详情看源码中的README)::

    Synopsis:  sendEmail -f ADDRESS [options]

   Required:
    -f ADDRESS                from (sender) email address
    * At least one recipient required via -t, -cc, or -bcc
    * Message body required via -m, STDIN, or -o message-file=FILE

   Common:
    -t ADDRESS [ADDR ...]     to email address(es)
    -u SUBJECT                message subject
    -m MESSAGE                message body
    -s SERVER[:PORT]          smtp mail relay, default is localhost:25

   Optional:
    -a   FILE [FILE ...]      file attachment(s)
    -cc  ADDRESS [ADDR ...]   cc  email address(es)
    -bcc ADDRESS [ADDR ...]   bcc email address(es)
    -xu  USERNAME             username for SMTP authentication
    -xp  PASSWORD             password for SMTP authentication

   Paranormal:
    -b BINDADDR[:PORT]        local host bind address
    -l LOGFILE                log to the specified file
    -v                        verbosity, use multiple times for greater effect
    -q                        be quiet (i.e. no STDOUT output)
    -o NAME=VALUE             advanced options, for details try: --help misc
        -o message-content-type=<auto|text|html>
        -o message-file=FILE
        -o message-format=raw
        -o message-header=HEADER
        -o message-charset=CHARSET
        -o reply-to=ADDRESS
        -o timeout=SECONDS
        -o username=USERNAME
        -o password=PASSWORD
        -o tls=<auto|yes|no>
        -o fqdn=FQDN


   Help:
    --help                    the helpful overview you're reading now
    --help addressing         explain addressing and related options
    --help message            explain message body input and related options
    --help networking         explain -s, -b, etc
    --help output             explain logging and other output options
    --help misc               explain -o options, TLS, SMTP auth, and more

说明::

    SendEmail is a lightweight, command line SMTP email client. 
    If you have the need to send email from a cmd line, this free one is perfect: simple to use and feature rich. 
    It was designed to be used in bash scripts, batch files, Perl programs and web sites, 
        but is quite adaptable and will likely meet your requirements. 
    SendEmail is written in Perl and is unique in that it requires NO MODULES. 
    It has an intuitive and flexible set of command-line options, making it very easy to learn and use.

    SendEmail is licensed under the GNU GPL, either version 2 of the License or (at your option) any later version.
    [Supported Platforms: Linux, BSD, OS X, Windows 98, Windows NT, Windows 2000, & Windows XP]





* 实例::

    #!/bin/sh

    ./sendEmail -f gordonsendmail@163.com \  # 发件人
            -t xinxishangwang@163.com \      # 收件人
            -s smtp.163.com \                # smtp服务器
            -xu gordonsendmail@163.com \     # 用户名
            -xp q1w2e3r4 \                   # 密码
            -l ./sendmail.log \              # 操作日志
            -o message-charset=utf-8 \       # 编码
            -o message-file=./content \      # 邮件内容(可以使用-m "<content>"代替)
            -u "主题1"                       # 主题
            -o timeout=5                     # 超时时间5秒

            -a ./<fileName> "/<path>/Document Folder/abc.txt" #附件, 有空格时要加双引号
            
            -o tls=yes          # 
            -cc <mail@163.com>  # 抄送
            -bcc <mail@163.com> # 私抄


* 错误示例::

    Jan 05 16:10:52 bkg sendEmail[1602]: ERROR => No TLS support!  
    SendEmail can't load required libraries. (try installing Net::SSLeay and IO::Socket::SSL)

* 解决方法:

    查找 ``Net::SSLea``, 与 ``IO::Socket::SSL`` 找到相关包并安装(如yum search <xxxx>)


