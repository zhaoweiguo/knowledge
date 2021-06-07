GC相关优化
##########

小对象过多引起的服务吞吐问题
============================

结论::

    对象数量过多，导致GC的三色算法耗费较多的CPU

优化::

    思路: 减少对象的分配

    对象:
    string, map[key]value, slice, *Type
    如:
    string  => [32]byte
    *Obj    => Obj
    []float64   => [32]float64





