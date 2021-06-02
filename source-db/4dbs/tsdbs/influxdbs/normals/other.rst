其他
########

特殊字符::

    逗号 ,
    weather,location=us\,midwest temperature=82 1465839830100400200
    wea\,ther,location=us-midwest temperature=82 1465839830100400200

    等号 =
    weather,location=us-midwest temp\=rature=82 1465839830100400200

    空格
    weather,location\ place=us-midwest temperature=82 1465839830100400200
    wea\ ther,location=us-midwest temperature=82 1465839830100400200

    双引号 "
    weather,location=us-midwest temperature="too\"hot\"" 1465839830100400200

关键字::

    time

说明::

    measurement的名字、tag set和时间戳唯一标识一个数据点

    如果您提交的数据具有相同measurement、tag set和时间戳但具有不同field set，
    那么数据的field set会变为旧field set和新field set的并集，如果有任何冲突以新field set为准



