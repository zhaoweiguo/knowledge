以太坊费用(Gas)
###############


Gas是由两个部分组成::

    最高费用 = Gas limit(限制) * Gas Price(价格)
    TX fee = Gas Used By Txn * Gas Price(价格)

    1.  Gas Price: Gwei 的数量，是指用户愿意花费于每个 Gas 单位的价钱
    2.  Gas Limit: 用户愿意为执行某个操作或确认交易支付的最大Gas量（最少21,000）
        不同时期、不同的操作默认值不同，在执行操作时可设置Gas Limit

单位::

    1eth = 10^3 finney = 10^6 szabo = 10^9 gwei(shannon)


网络不好时如果手续费太低会导致交易抢先::

    Warning! Error encountered during contract execution [Out of gas]

    转账金额退回原账户，然而手续费不退





