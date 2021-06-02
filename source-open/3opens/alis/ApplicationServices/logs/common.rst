常见日志
###############


基本运算符::

    and
    or
    not
    ( , ] 
    “ 
    \ 
    | 
    timeslice
    count
    *
    ?  
    __topic__ 
    __tag__ 
    source
    >,>=,<,<=,=
    in: latency in (100 200]

保留字段::

    sort、asc、desc、group by、avgsum、min、max和limit
    可用""来使用


范围::

    status: [400 499] 
    or
    status ≥400 and status ≤499

组合查询::

    status ≥400 and status ≤499 and message:foot

模糊查询::

    在所有日志中查找的100个词;并返回包含这些词的日志
    fo*d: food, foofdfdsad
    fo?d: food, foad







