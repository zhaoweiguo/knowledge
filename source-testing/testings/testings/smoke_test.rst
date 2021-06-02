冒烟测试
########

这一术语源自硬件行业。对一个硬件或硬件组件进行更改或修复后，直接给设备加电。如果没有冒烟，则该组件就通过了测试。在软件中，“冒烟测试”这一术语描述的是在将代码更改嵌入到产品的源树中之前对这些更改进行验证的过程。在检查了代码后，冒烟测试是确定和修复软件缺陷的最经济有效的方法。冒烟测试设计用于确认代码中的更改会按预期运行，且不会破坏整个版本的稳定性。


冒烟测试属于HLT(High Level Test)测试，HLT通常指SDV(系统设计验证)/SIT(系统集成测试)/SVT(系统验证测试)等测试活动。HLT是站在系统的角度对整个版本进行测试，测试对象是一个完整的产品而不是产品内部的模块，常见的HLT测试包括系统测试和验收测试。


维基百科定义:

smoke testing is preliminary testing to reveal simple failures severe enough to, for example, reject a prospective software release. Smoke tests are a subset of [test cases] that cover the most important functionality of a component or system, used to aid assessment if main functions of the software appear to work correctly. When used to determine if a computer program should be subjected to further, more fine-grained testing, a smoke test may be called an intake test.[1] Alternately, it is a set of tests run on each new build of a product to verify that the build is testable before the build is released into the hands of the test team.[5] In the DevOps paradigm, use of a BVT step is one hallmark of the continuous integration maturity stage.


分类
====

冒烟测试的对象是每一个新编译的需要正式测试的软件版本。通过冒烟测试，在软件代码正式编译并交付测试之前，先尽量消除其表面的错误，减少后期测试的负担。冒烟测试的执行者是版本编译人员。因此可以说，冒烟测试是预测试。在实际的软件测试工作中，冒烟测试在软件研发的不同阶段有所不同。大体可以分为三类

1. 形成集成测试版本以前::
    
    验证各个单元能够成功执行，并保证测试版本能够顺利集成；

2. 形成集成测试版本::
   
    以保证新的或者更改过的代码不破坏集成版本的完成性和稳定性；

3. 后期预测试缺陷的修正::
   
    针对每个缺陷所做的缺陷修正都要先在干净的链接环境中进行冒烟测试，测试通过后才能更新相关软件版本。


应用
====


冒烟测试的对象是每一个新编译的需要正式测试的软件版本，目的是确认软件基本功能正常，可以进行后续的正式测试工作。冒烟测试的执行者是版本编译人员。


意义
====

冒烟测试是软件测试过程中一个不可或缺的节点，一个好的冒烟测试过程，对于软件测试效率的提升具有重要意义。

1. 冒烟测试是对软件质量的总体检验。
2. 冒烟测试是测试人员对测试流程的熟悉。


新版本的基本功能确认的测试，有的公司称为版本健康检查(Build Sanity Check)。









