协议-HTTP API
#####################

数据库::

    shell> show databases;
    =>
    # curl -G http://localhost:8086/query --data-urlencode "q=SHOW DATABASES"


查询::

    curl -G 'https://<ip>:port/query?u=<账号名称>&p=<密码>&pretty=true' 
      --data-urlencode "db=mydb" --data-urlencode 
        "q=SELECT \"value\" FROM \"cpu_load_short\" WHERE \"region\"='us-west'"

    // 多个查询
    curl -G 'https://<ip>:port/query?u=<账号名称>&p=<密码>&pretty=true' 
      --data-urlencode "db=mydb" --data-urlencode 
        "q=SELECT \"value\" FROM \"cpu_load_short\" WHERE \"region\"='us-west';
        SELECT count(\"value\") FROM \"cpu_load_short\" WHERE \"region\"='us-west'"

查询数据时的其它选项::

    // 时间戳格式: epoch的值是字符串类型，可以是[h, m, s, ms, u, ns]
    curl -G 'https://<网络地址>:3242/query?u=<账号名称>&p=<密码>' 
      --data-urlencode "db=mydb" --data-urlencode "epoch=s" --data-urlencode 
        "q=SELECT \"value\" FROM \"cpu_load_short\" WHERE \"region\"='us-west'"

    // 分块
    // 查询参数chunked=true，可以开启分块（Chunking）
    // 查询参数chunk_size设为您需要的大小
    // 使结果流式批量地返回，而不是一次性全部返回
    // 返回的结果可以按时间线或者按每10,000个数据点分块（哪个条件最先满足就以哪个条件来分块）
    curl -G 'https://<网络地址>:3242/query?u=<账号名称>&p=<密码>' 
      --data-urlencode "db=deluge" 
      --data-urlencode "chunked=true" 
      --data-urlencode "chunk_size=20000" 
      --data-urlencode "q=SELECT * FROM liters"

写入::

    // 使用HTTP API将数据写入TSDB For InfluxDB®。
    // 向/write路径发送POST请求，并在request body中给出行协议数据：
    curl -i -XPOST "https://ip:port/write?db=science_is_cool&u=<账号名称>&p=<密码>" 
      --data-binary 'weather,location=us-midwest temperature=82 1465839830100400200'

    // 单点写入
    curl -i -XPOST 'https://<网络地址>:3242/write?db=mydb&u=<账号名称>&p=<密码>' 
      --data-binary 'cpu_load_short,host=server01,region=us-west value=0.64 1434055562000000000'

    // 多点写入
    curl -i -XPOST 'https://<网络地址>:3242/write?db=mydb&u=<账号名称>&p=<密码>' 
      --data-binary '
        cpu_load_short,host=server02 value=0.67
        cpu_load_short,host=server02,region=us-west value=0.55 1422568543702900257
        cpu_load_short,direction=in,host=server01,region=us-west value=2.0 1422568543702900257
      '

    // 文件写入
    $> cat cpu_data.txt
    cpu_load_short,host=server02 value=0.67
    cpu_load_short,host=server02,region=us-west value=0.55 1422568543702900257
    cpu_load_short,direction=in,host=server01,region=us-west value=2.0 1422568543702900257

    $> curl -i -XPOST 'https://<ip>:3242/write?db=mydb&u=<账号名称>&p=<密码>' --data-binary @cpu_data.txt








