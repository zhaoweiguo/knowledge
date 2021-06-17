通用定义
----------

OLTP
''''''''
（OnLine Transaction Processing）
也称为面向交易的处理过程，其基本特征是前台接收的用户数据可以立即传送到计算中心进行处理，并在很短的时间内给出处理结果，是对用户操作快速响应的方式之一。
这样做的最大优点是可以即时地处理输入的数据，及时地回答。也称为实时系统(Real time System)。衡量联机事务处理结果的一个重要指标是系统性能，具体体现为实时请求-响应时间(Response Time)，即用户在终端上输入数据之后，到计算机对这个请求给出答复所需要的时间。OLTP是由前台、应用、数据库共同完成的，处理快慢以及处理程度取决于数据库引擎、服务器、应用引擎。


OLAP
'''''''''
（OnLine Analytical Processing）
联机分析处理OLAP是一种软件技术，它使分析人员能够迅速、一致、交互地从各个方面观察信息，以达到深入理解数据的目的。它具有FASMI(Fast Analysis of Shared Multidimensional Information)，即共享多维信息的快速分析的特征。
OLAP展现在用户面前的是一幅幅多维视图。
OLAP系统按照其存储器的数据存储格式可以分为关系OLAP（RelationalOLAP，简称ROLAP）、多维OLAP（MultidimensionalOLAP，简称MOLAP）和混合型OLAP（HybridOLAP，简称HOLAP）三种类型。
OLAP的基本多维分析操作有钻取（roll up和drill down）、切片（slice）和切块（dice）、以及旋转（pivot）、drill across、drill through等。
·钻取是改变维的层次，变换分析的粒度。它包括向上钻取（roll up）和向下钻取（drill down）。roll up是在某一维上将低层次的细节数据概括到高层次的汇总数据，或者减少维数；而drill down则相反，它从汇总数据深入到细节数据进行观察或增加新维。

·切片和切块是在一部分维上选定值后，关心度量数据在剩余维上的分布。如果剩余的维只有两个，则是切片；如果有三个，则是切块。

·旋转是变换维的方向，即在表格中重新安排维的放置（例如行列互换）。



MOLAP
'''''''''
Multidimension OLAP，简称MOLAP
是Arbor Software严格遵照Codd的定义，自行建立了多维数据库，来存放联机分析系统数据，开创了多维数据存储的先河，后来的很多家公司纷纷采用多维数据存储。代表产品有Hyperion(原Arbor Software) Essbase、Showcase Strategy等。
数据仓库与OLAP的关系是互补的，现代OLAP系统一般以数据仓库作为基础，即从数据仓库中抽取详细数据的一个子集并经过必要的聚集存储到OLAP存储器中供前端分析工具读取。

ROLAP
''''''''
ROLAP将分析用的多维数据存储在关系数据库中并根据应用的需要有选择的定义一批实视图作为表也存储在关系数据库中。不必要将每一个SQL查询都作为实视图保存，只定义那些应用频率比较高、计算工作量比较大的查询作为实视图。对每个针对OLAP服务器的查询，优先利用已经计算好的实视图来生成查询结果以提高查询效率。同时用作ROLAP存储器的RDBMS也针对OLAP作相应的优化，比如并行存储、并行查询、并行数据管理、基于成本的查询优化、位图索引、SQL的OLAP扩展(cube,rollup)等等


混沌工程
''''''''

采用基于经验和系统的方法解决了分布式系统在规模增长时引发的问题, 并以此建立对系统抵御这些事件的能力和信心。通过在受控实验中观察分布式系统的行为来了解它的特性，我们称之为混沌工程。

https://github.com/wizardbyron/principlesofchaos_zh-cn








