通用
####

事务存在的意义就是保证系统中的数据是正确的，不同数据间不会产生矛盾，也就是保证数据状态的一致性（Consistency）

一致性分为::

    1. 数据库状态的一致性
    2. 分布式共识算法中的一致性


要达成数据库状态的一致性，理论上需要三方面::

    原子性（Atomic）
        在同一项业务处理过程中，事务保证了多个对数据的修改，要么同时成功，要么一起被撤销。
        原子性保证了事务的多个操作要么都生效要么都不生效，不会存在中间状态；
    隔离性（Isolation）
        在不同的业务处理过程中，事务保证了各自业务正在读、写的数据互相独立，不会彼此影响。
    持久性（Durability）
        事务应当保证所有被成功提交的数据修改都能够正确地被持久化，不丢失数据。
        持久性保证了一旦事务生效，就不会再因为任何原因而导致其修改的内容被撤销或丢失。

    “ACID”: A、I、D 是手段，C 是目的

    实现原子性和持久性所面临的困难是:
      “写入磁盘” 这个操作不会是原子的，不仅有 “写入” 与 “未写入”，还客观地存在着 “正在写” 的中间状态。


    原子性，隔离性和持久性是正交的
    Consistency 是应用程序视角看到的

    Atomicity, isolation, and durability are properties of the database, 
        whereas consistency (in the ACID sense) is a property of the application. 
    The application may rely on the database’s atomicity and isolation properties 
        in order to achieve consistency,
    but it’s not up to the database alone.
    原子性，隔离性和持久性是数据库的属性，
    而一致性（在 ACID 意义上）是应用程序的属性。
    应用可能依赖数据库的原子性和隔离属性来实现一致性，但这并不仅取决于数据库。



整体分为以下4个场景::

    单个服务使用单个数据源   =>  本地事务(ACID，强一致性)
    单个服务使用多个数据源   =>  全局事务(XA 协议，多数据源的强一致性，两阶段提交（2PC）和三阶段提交（3PC）)
    多个服务使用单个数据源   =>  共享事务(多个服务共用同一个数据源)
    多个服务使用多个数据源   =>  分布式事务




