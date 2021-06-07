CQRS [1]_
############

CQRS（Command Query Responsibility Seperation）

Martin Flower给出了一个思路 Eager Read Derivation [2]_



查询命令分离原则 Command-query separation principle::

    CQS是针对方法的经典oo设计原则，该原则指出，任何方法都可能是如下情况之一；

    1. 执行动作（更新，调整。。。。）的命令方法，这种方法通常具有改变对象状态等副作用。并且是void的，没有返回值。
    2. 向调用者返回数据的查询，这种方法没有副作用，不会永久性地改变任何对象的状态。
    关键是，一个方法不应该同时属于以上2个类型。
    写操作按照严格定义是没有返回值(void)，我常常见到那种写操作返回最新对象的方法
    User changeName(User user)
    这样实际上是将写操作和读操作合在一块了，违反了CQS原则。






.. [1] https://github.com/JoeCao/JoeCao.github.io/issues/10
.. [2] https://martinfowler.com/bliki/EagerReadDerivation.html

