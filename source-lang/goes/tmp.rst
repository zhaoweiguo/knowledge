临时
#######

feature::

    // +build ignore


配置::

    Config.Group.Return.Notifications = true
    Group.PartitionStrategy = StrategyRange
    Group.Offsets.Retry.Max = 3
    Group.Session.Timeout = 30 * time.Second
    Group.Heartbeat.Interval = 3 * time.Second

    Net.MaxOpenRequests = 5
    Net.DialTimeout = 30 * time.Second
    Net.ReadTimeout = 30 * time.Second
    Net.WriteTimeout = 30 * time.Second
    Net.SASL.Handshake = true

    Metadata.Retry.Max = 3
    Metadata.Retry.Backoff = 250 * time.Millisecond
    Metadata.RefreshFrequency = 10 * time.Minute
    Metadata.Full = true
        
    Consumer.Fetch.Min = 1
    Consumer.Fetch.Default = 1024 * 1024
    Consumer.Retry.Backoff = 2 * time.Second
    Consumer.MaxWaitTime = 250 * time.Millisecond
    Consumer.MaxProcessingTime = 100 * time.Millisecond
    Consumer.Offsets.CommitInterval = 1 * time.Second
    Consumer.Return.Errors = true
    Consumer.Offsets.Initial = sarama.OffsetOldest
    Consumer.Offsets.Retention = 192 * time.Hour 

    ClientID = defaultClientID
    ChannelBufferSize = 256


::

    6g是amd64的go编译器，它生成的是.6文件
    386一般使用8g命令，它生成的一般是.8格式的文件
    当然还有一个5g的命令是用于arm的cpu
    同理amd64用6l，386用8l,arm用5l的链接器


* golang image: https://gopherize.me/
* 好的网站: https://awesome-go.com/


