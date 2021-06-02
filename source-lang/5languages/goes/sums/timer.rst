定时器
######

跟golang定时器相关的入口主要有以下几种方法::

    <-time.Tick(time.Second)
    <-time.After(time.Second)
    <-time.NewTicker(time.Second).C
    <-time.NewTimer(time.Second).C
    time.AfterFunc(time.Second, func() { /*do*/ })
    time.Sleep(time.Second)








