常用
####



实践 Tips
=========

* 对频繁分配的小对象，使用 sync.Pool 对象池避免分配
* 自动化的 DeepCopy 是非常耗时的，其中涉及到反射，内存分配，容器(如 map)扩展等，大概比手动拷贝慢一个数量级
* 用 atomic.Load/StoreXXX，atomic.Value, sync.Map 等代替 Mutex。(优先级递减)
* 使用高效的第三方库，如用fasthttp替代 net/http
* 在开发环境加上-race编译选项进行竞态检查
* 在开发环境开启 net/http/pprof，方便实时 pprof
* 将所有外部IO(网络IO，磁盘IO)做成异步





参考
====

* Go的pprof使用: https://www.cnblogs.com/yjf512/archive/2012/12/27/2835331.html
* go pprof 性能分析: https://juejin.im/entry/5ac9cf3a518825556534c76e
* Go 程序的性能优化及 pprof 的使用: https://www.cnblogs.com/snowInPluto/p/7403097.html



