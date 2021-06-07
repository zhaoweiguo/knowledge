协议
###########


行协议::

    <measurement>[,<tag-key>=<value>...] <field-key>=<value>[...] [unix-nano-timestamp]

实例::

    1. cpu,host=serverA,region=us_west value=0.64
    2. payment,device=mobile,product=Notepad,method=credit billed=33,licenses=3i 1434067467100293230
    3. stock,symbol=AAPL bid=127.46,ask=127.48
    4. temperature,machine=unit42,type=assembly external=25,internal=37 1434067467000000000

实例:一个measurement为cpu，tag为host和region，测量值value为0.64的数据点已经写入数据库::

    > INSERT cpu,host=serverA,region=us_west value=0.64
    > SELECT "host", "region", "value" FROM "cpu"

    > INSERT temperature,machine=unit42,type=assembly external=25,internal=37
    > SELECT * FROM "temperature"








