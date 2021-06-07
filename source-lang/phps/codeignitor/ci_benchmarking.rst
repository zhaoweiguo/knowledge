.. _ci_benchmarking:

CI基准测试类
================

* CI的基准测试类是处理一直开启中的，自动初使化，无需手工启动!
* 你可以在 ``controllers`` , ``views`` , ``models`` 中使用

使用基准测试类
-------------------

* 实例一::

    $this->benchmark->mark('code_start'); //标记起始点
    // Some code happens here
    $this->benchmark->mark('code_end'); //标记终止点
    echo $this->benchmark->elapsed_time('code_start', 'code_end');//计算两点间时间
    // 注意: 两点的名字是唯一的

* 实例二::

    $this->benchmark->mark('dog');

    // Some code happens here

    $this->benchmark->mark('cat');

    // More code happens here

    $this->benchmark->mark('bird');

    echo $this->benchmark->elapsed_time('dog', 'cat');
    echo $this->benchmark->elapsed_time('cat', 'bird');
    echo $this->benchmark->elapsed_time('dog', 'bird');

对基准点做性能分析
----------------------

* 如果你想你的基准数据可以用于:ref:`性能分析 <ci_profiling>`_ ,那么你所有的标记点都必须成对的！
* 每个点的名字必须要以 ``_start`` 、 ``_end`` 结尾
* 实例::

    $this->benchmark->mark('my_mark_start');

    // Some code happens here...

    $this->benchmark->mark('my_mark_end'); 

    $this->benchmark->mark('another_mark_start');

    // Some more code happens here...

    $this->benchmark->mark('another_mark_end');

显示总共运行时间
------------------

* 从CI开始到最后输出到浏览器，可以如下代码放到view模板中::

    <?php echo $this->benchmark->elapsed_time();?>

* 此函数和上面的一样，只不过没有参数
* 此段代码不管放到哪里都是会运行到最后计算出結果
* 另外，还有一种方法:使用如下pseudo-variable::

    {elapsed_time}

显示内存消耗
------------------

* 需要在php安装时使用 ``--enable-memory-limit`` 
* 此代段代码只能在view文件中
* 计算的是你整个app的内存占用情况
* php格式代码::

    <?php echo $this->benchmark->memory_usage();?>

* pseudo代码::

    {memory_usage}


