安装&使用
#########

安装 [3]_ ::

    % ubuntu
    wget https://dl.grafana.com/oss/release/grafana_5.4.0_amd64.deb 
    sudo dpkg -i grafana_5.4.0_amd64.deb 

    % centos
    wget https://dl.grafana.com/oss/release/grafana-5.4.0-1.x86_64.rpm 
    sudo yum localinstall grafana-5.4.0-1.x86_64.rpm 

    % normal linux
    wget https://dl.grafana.com/oss/release/grafana-5.4.0.linux-amd64.tar.gz 
    tar -zxvf grafana-5.4.0.linux-amd64.tar.gz 

启动::

  % 1.Start the server (init.d service)
  $ sudo service grafana-server start
  $ sudo /sbin/chkconfig --add grafana-server   % start at boot time:

  % 2.Start the server (via systemd)
  $ systemctl daemon-reload
  $ systemctl start grafana-server
  $ systemctl status grafana-server
  $ sudo systemctl enable grafana-server.service   % start at boot time:




相关文件路径::

    配置文件
    /etc/grafana/grafana.ini
    此配置文件可以设定:
    admin password, http port, grafana database (sqlite3, mysql, postgres) 
      authentication options (google, github, ldap, auth proxy) 
    默认密码:admin/admin

    日志文件
    /var/log/grafana

    数据库文件
    /var/lib/grafana/grafana.db

重设密码::

  % 1.grafana-cli
  grafana-cli admin reset-admin-password ...
  grafana-cli admin reset-admin-password --homepath "/usr/share/grafana" newpass

  % 2.UI界面请求

  % 3.curl请求
  curl -X PUT -H "Content-Type: application/json" -d '{
    "oldPassword": "admin",
    "newPassword": "newpass",
    "confirmNew": "newpass"
  }' http://admin:admin@<your_grafana_host>:3000/api/user/password







.. [3] https://grafana.com/grafana/download