influx命令
##########

技巧::

    1.直接执行 influx -precision rfc3339
    2.或者登录到influx cli之后
        precision rfc3339

登录::

    $> influx -ssl -username <账号名称> -password <密码> -host <网络地址> -port 3242 \
      -import -path=path/to/apple_stand.txt -database=apple_stand

    > create user gordon with password '1QAZ2wsx'
    > CREATE USER root WITH PASSWORD 'wisedu123' WITH ALL PRIVILEGES

    grant all privileges to gordon
    create database testdb

    ./influx -host <host> -port 3242 -ssl -username gordon -password <pwd>


登录::

    // -precision参数表明了任何返回的时间戳的格式和精度
    // rfc3339是让InfluxDB返回RFC339格式(YYYY-MM-DDTHH:MM:SS.nnnnnnnnnZ)的时间戳
    shell> influx -precision rfc3339 
    influx> auth
    username: root
    password: 

    or
    $> influx -username <user> -password <pwd> -precision rfc3339 






