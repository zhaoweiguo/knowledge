R语言
########

R是用于统计分析、绘图的语言和操作环境。R是属于GNU系统的一个自由、免费、源代码开放的软件，它是一个用于统计计算和统计制图的优秀工具。

* github [1]_

发展历史
========
R是统计领域广泛使用的诞生于1980年左右的S语言的一个分支。可以认为R是S语言的一种实现。而S语言是由AT&T贝尔实验室开发的一种用来进行数据探索、统计分析和作图的解释型语言。最初S语言的实现版本主要是S-PLUS。S-PLUS是一个商业软件，它基于S语言，并由MathSoft公司的统计科学部进一步完善。后来新西兰奥克兰大学的Robert Gentleman和Ross Ihaka及其他志愿人员开发了一个R系统。由“R开发核心团队”负责开发。R可以看作贝尔实验室（AT&T BellLaboratories）的RickBecker，JohnChambers和AllanWilks开发的S语言的一种实现。当然,S语言也是S-Plus的基础。所以,两者在程序语法上可以说是几乎一样的,可能只是在函数方面有细微差别,程序十分容易地就能移植到一程序中,而很多一的程序只要稍加修改也能运用于R。

使用
======

::

    $ docker run -ti --rm r-base
    or
    $ registry.cn-hangzhou.aliyuncs.com/langs/r-base


Basic types::

    numeric (real)
    integer
    character
    logical
    complex








.. [1] https://github.com/wch/r-source