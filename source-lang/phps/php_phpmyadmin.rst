.. _php_phpmyadmin:

PhpMyAdmin
============
:作者: 新溪-godon
:日期: 2012-08-08

* 注意: 我认为以下配置适合本地用，如果在远程电脑上用权限问题:

比如root用户只允许本地使用且密码简单，如果没有这个项目是没有问题的，但有了这个项目就出大问题了！

* 打开libraries下的config.default.php文件，依次找到下面各项，按照说明配置即可:

    * 访问网址::

        $cfg['PmaAbsoluteUri'] = '';这里填写phpmyadmin的访问网址

    * MySQL主机信息::

        $cfg['Servers'][$i]['host'] = 'localhost'; // MySQL hostname or IP address
        填写localhost或mysql所在服务器的ip地址，如果mysql和该phpmyadmin在同一服务器，则按默认localhost
        $cfg['Servers'][$i]['port'] = ''; // MySQL port - leave blank for default port
        mysql端口，如果是默认3306，保留为空即可

    * MySQL用户名和密码::

        $cfg['Servers'][$i]['user'] = 'root'; // MySQL user 访问phpmyadmin使用的mysql用户名
        fg['Servers'][$i]['password'] = ''; // MySQL password (only needed对应上述mysql用户名的密码

    * 认证方法::

        $cfg['Servers'][$i]['auth_type'] = 'cookie';

        此有四种模式可供选择，cookie，http，HTTP，config
        config方式即输入phpmyadmin的访问网址即可直接进入，无需输入用户名和密码，是不安全的，不推荐使用。
        当该项设置为cookie，http或HTTP时，登录phpmyadmin需要数据用户名和密码进行验证，,具体如下：
        PHP安装模式为Apache，可以使用http和cookie；
        PHP安装模式为CGI，可以使用cookie


    * 短语密码(blowfish_secret)的设置::

        $cfg['blowfish_secret'] = '';
        如果认证方法设置为cookie，就需要设置短语密码
        设置为什么密码，由您自己决定，但是不能留空，否则会在登录phpmyadmin时提示错误


