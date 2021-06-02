.. _ab:

Apache Bench(ab)
################

* 使用方法::

    Usage: ./ab [options] [http://]hostname[:port]/path
    Options are:
    -n 请求次数
    -c 请求的并发数
    -t timelimit Seconds to max. wait for responses
    -p post请求的文件(内含post参数)
    -T Content-type header for POSTing:如application/x-www-form-urlencoded
    -v 日志级别.当n>2时，可以显示发送的http请求头和响应的http头的内容。并且，n越大显示的内容会越全，比如，－v4
    -w Print out results in HTML tables
    -i Use HEAD instead of GET
    -x attributes String to insert as table attributes
    -y attributes String to insert as tr attributes
    -z attributes String to insert as td or th attributes
    -C attribute Add cookie, eg. ‘Apache=1234. (repeatable)
    -H attribute Add Arbitrary header line, eg. ‘Accept-Encoding: gzip’
    Inserted after all normal header lines. (repeatable)
    -A attribute Add Basic WWW Authentication, the attributes
    are a colon separated username and password.
    -P attribute Add Basic Proxy Authentication, the attributes
    are a colon separated username and password.
    -X proxy:port Proxyserver and port number to use
    -V Print version number and exit
    -k Use HTTP KeepAlive feature
    -d Do not show percentiles served table.
    -S Do not show confidence estimators and warnings.
    -g filename Output collected data to gnuplot format file.
    -e filename Output CSV file with percentages served
    -h Display usage information (this message)

* 实例(同时处理1000个請求并运行100次index.php)::

    // 最简单实例
    ./ab -c 1000 -n 100 http://blog.programfan.info/index.php
    // post请求实例:以4个并发数请求40个请求
    ab -c 4 -n 40 -v2 -p "post.json" -T "application/x-www-form-urlencoded" "http://zgapi.taojoy.com.cn/3/goods/multibuy2"

介绍
====

Apache Bench（ab）是一款用来针对HTTP协议做性能压测的命令行工具，支持在本地环境发起测试请求，验证服务器的处理性能。它主要具有以下特点：





缺点
====

如无图形化界面支持，支持协议较为单一，只支持HTTP协议，缺少对HTTPS协议、WebSocket等协议的支持，对于较为复杂的性能压测场景，ab缺少链路编排、场景管理等支持，只能够对单一地址发起性能压测，此外，它的性能压测统计指标纬度较少，缺少性能压测过程中的数据统计，只能够在压测结束后获取相关的统计数据，无法实时获取系统负载等指标，难以应用于生产环境下的性能压测。

总的来说，ab作为一款命令行测试工具，适用于本地对支持HTTP协议的单一地址进行性能压测，但缺少相应的链路编排、场景管理、数据可视化等大规模性能压测基础功能，无法应用于生产环境。










