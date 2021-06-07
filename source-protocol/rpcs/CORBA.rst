CORBA协议
#########

::
  
    CORBA 本身的设计实在是太过于啰嗦和繁琐了，甚至有些规定简直到了荒谬的程度。
        比如:
        我们要写一个对象请求代理（ORB，这是 CORBA 中的关键概念）大概要 200 行代码，其中大概有 170 行是纯粹无用的废话
        —— CORBA 的首席科学家 Michi Henning 在文章《The Rise and Fall of CORBA》中说
        https://dl.acm.org/doi/pdf/10.1145/1142031.1142044
    另一方面，为 CORBA 制定规范的专家逐渐脱离实际了
        做出的 CORBA 规范非常晦涩难懂，导致各家语言的厂商都有自己的解读，
        结果弄出来的 CORBA 实现互不兼容，实在是对 CORBA 号称支持众多异构语言的莫大讽刺。
        这也间接造就了后来 W3C Web Service 的出现。








