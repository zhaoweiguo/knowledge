.. _rdf:

知识图谱相关-RDF
################

* 参考-知识图谱-给AI装个大脑 [1]_
* 开放领域知识图谱DBpedia: https://wiki.dbpedia.org/


RDF(Resource Description Framework)，即资源描述框架，其本质是一个数据模型（Data Model）。它提供了一个统一的标准，用于描述实体/资源。简单来说，就是表示事物的一种方法和手段。RDF形式上表示为SPO三元组，有时候也称为一条语句（statement），知识图谱中我们也称其为一条知识，如下图。

.. image:: /images/theorys/rdfs/architecture.png



.. image:: /images/theorys/rdfs/sentence.png

RDF由节点和边组成，节点表示实体/资源、属性，边则表示了实体和实体之间的关系以及实体和属性的关系。

::

    RDF(Resource Description Framework)，即资源描述框架
    RDFS，即“Resource Description Framework Schema”，是最基础的模式语言
    OWL，即“Web Ontology Language”，语义网技术栈的核心之一
    URI（Universal Resource Identifier: 唯一表示某一事物
    SPO三元组(Subject-Predicate-Object)
    IRIs(International Resource Identifiers

    语义网络（Semantic Network）
    语义网（Semantic Web）
    关联数据（Linked Data）


RDF图::

    （主语、宾语是节点、谓语是边的那种）
    一共有三种类型，IRIs，blank nodes 和 literals
    Subject可以是IRI或blank node。
    Predicate是IRI。
    Object三种类型都可以。

    IRI我们可以看做是URI或者URL的泛化和推广，它在整个网络或者图中唯一定义了一个实体/资源
    literal是字面量，我们可以把它看做是带有数据类型的纯文本，如:"周恩来"^^xsd:string
    blank node简单来说就是没有IRI和literal的资源，或者说匿名资源


    @prefix kg: <http://www.kg.com/ontology/>
    kg:chineseName其实就是"http:// www.kg.com/ontology/chineseName"的缩写

RDF序列化方法
=============

RDF序列化的方式主要有：RDF/XML，N-Triples，Turtle，RDFa，JSON-LD等几种::

    1. RDF/XML，顾名思义，就是用XML的格式来表示RDF数据。
    2. N-Triples，即用多个三元组来表示RDF数据集，是最直观的表示方法。
        在文件中，每一行表示一个三元组，方便机器解析和处理。开放领域知识图谱DBpedia通常是用这种格式来发布数据的。
    3. Turtle, 应该是使用得最多的一种RDF序列化方式了。它比RDF/XML紧凑，且可读性比N-Triples好
    4. RDFa, 即“The Resource Description Framework in Attributes”，是HTML5的一个扩展，在不改变任何显示效果的情况下，让网站构建者能够在页面中标记实体，像人物、地点、时间、评论等等。也就是说，将RDF数据嵌入到网页中，搜索引擎能够更好的解析非结构化页面，获取一些有用的结构化信息。读者可以去这个页面感受一下RDFa，其直观展示了普通用户看到的页面，浏览器看到的页面和搜索引擎解析出来的结构化信息。
    5. SON-LD，即“JSON for Linking Data”，用键值对的方式来存储RDF数据。

实例

.. image:: /images/theorys/rdfs/demo1.png

N-Triples::

    <http://www.kg.com/person/1> <http://www.kg.com/ontology/chineseName> "罗纳尔多·路易斯·纳萨里奥·德·利马"^^string.
    <http://www.kg.com/person/1> <http://www.kg.com/ontology/career> "足球运动员"^^string.
    <http://www.kg.com/person/1> <http://www.kg.com/ontology/fullName> "Ronaldo Luís Nazário de Lima"^^string.
    <http://www.kg.com/person/1> <http://www.kg.com/ontology/birthDate> "1976-09-18"^^date.
    <http://www.kg.com/person/1> <http://www.kg.com/ontology/height> "180"^^int.
    <http://www.kg.com/person/1> <http://www.kg.com/ontology/weight> "98"^^int.
    <http://www.kg.com/person/1> <http://www.kg.com/ontology/nationality> "巴西"^^string.
    <http://www.kg.com/person/1> <http://www.kg.com/ontology/hasBirthPlace> <http://www.kg.com/place/10086>.
    <http://www.kg.com/place/10086> <http://www.kg.com/ontology/address> "里约热内卢"^^string.
    <http://www.kg.com/place/10086> <http://www.kg.com/ontology/coordinate> "-22.908333, -43.196389"^^string.

用Turtle表示的时候我们会加上前缀（Prefix）对RDF的IRI进行缩写::

    @prefix person: <http://www.kg.com/person/> .
    @prefix place: <http://www.kg.com/place/> .
    @prefix : <http://www.kg.com/ontology/> .

    person:1 :chineseName "罗纳尔多·路易斯·纳萨里奥·德·利马"^^string.
    person:1 :career "足球运动员"^^string.
    person:1 :fullName "Ronaldo Luís Nazário de Lima"^^string.
    person:1 :birthDate "1976-09-18"^^date.
    person:1 :height "180"^^int. 
    person:1 :weight "98"^^int.
    person:1 :nationality "巴西"^^string. 
    person:1 :hasBirthPlace place:10086.
    place:10086 :address "里约热内卢"^^string.
    place:10086 :coordinate "-22.908333, -43.196389"^^string.

同一个实体拥有多个属性（数据属性）或关系（对象属性），我们可以只用一个subject来表示，使其更紧凑。我们可以将上面的Turtle改为::

    @prefix person: <http://www.kg.com/person/> .
    @prefix place: <http://www.kg.com/place/> .
    @prefix : <http://www.kg.com/ontology/> .

    person:1 :chineseName "罗纳尔多·路易斯·纳萨里奥·德·利马"^^string;
             :career "足球运动员"^^string;
             :fullName "Ronaldo Luís Nazário de Lima"^^string;
             :birthDate "1976-09-18"^^date;
             :height "180"^^int;
             :weight "98"^^int;
             :nationality "巴西"^^string; 
             :hasBirthPlace place:10086.
    place:10086 :address "里约热内卢"^^string;
                :coordinate "-22.908333, -43.196389"^^string.


轻量级的模式语言——RDFS
======================

::

    @prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
    @prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
    @prefix : <http://www.kg.com/ontology/> .

    ### 这里我们用词汇rdfs:Class定义了“人”和“地点”这两个类。
    :Person rdf:type rdfs:Class.
    :Place rdf:type rdfs:Class.

    ### rdfs当中不区分数据属性和对象属性，词汇rdf:Property定义了属性，即RDF的“边”。
    :chineseName rdf:type rdf:Property;
            rdfs:domain :Person;
            rdfs:range xsd:string .

    :career rdf:type rdf:Property;
            rdfs:domain :Person;
            rdfs:range xsd:string .
            
    :fullName rdf:type rdf:Property;
            rdfs:domain :Person;
            rdfs:range xsd:string .
            
    :birthDate rdf:type rdf:Property;
            rdfs:domain :Person;
            rdfs:range xsd:date .

    :height rdf:type rdf:Property;
            rdfs:domain :Person;
            rdfs:range xsd:int .
            
    :weight rdf:type rdf:Property;
            rdfs:domain :Person;
            rdfs:range xsd:int .
            
    :nationality rdf:type rdf:Property;
            rdfs:domain :Person;
            rdfs:range xsd:string .
            
    :hasBirthPlace rdf:type rdf:Property;
            rdfs:domain :Person;
            rdfs:range :Place .
            
    :address rdf:type rdf:Property;
            rdfs:domain :Place;
            rdfs:range xsd:string .
            
    :coordinate rdf:type rdf:Property;
            rdfs:domain :Place;
            rdfs:range xsd:string .

我们这里只介绍RDFS几个比较重要，常用的词汇::

    1. rdfs:Class. 用于定义类。
    2. rdfs:domain. 用于表示该属性属于哪个类别
    3. rdfs:range. 用于描述该属性的取值类型
    4. rdfs:subClassOf. 用于描述该类的父类。比如，我们可以定义一个运动员类，声明该类是人的子类
    5. rdfs:subProperty. 用于描述该属性的父属性
        比如，我们可以定义一个名称属性，声明中文名称和全名是名称的子类

.. image:: /images/theorys/rdfs/rdfs.png

RDFS的扩展——OWL
===============

OWL有两个主要的功能::

    1. 提供快速、灵活的数据建模能力
    2. 高效的自动推理

实例::

    @prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
    @prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
    @prefix : <http://www.kg.com/ontology/> .
    @prefix owl: <http://www.w3.org/2002/07/owl#> .

    ### 这里我们用词汇owl:Class定义了“人”和“地点”这两个类。
    :Person rdf:type owl:Class.
    :Place rdf:type owl:Class.

    ### owl区分数据属性和对象属性（对象属性表示实体和实体之间的关系）。词汇owl:DatatypeProperty定义了数据属性，owl:ObjectProperty定义了对象属性。
    :chineseName rdf:type owl:DatatypeProperty;
            rdfs:domain :Person;
            rdfs:range xsd:string .

    :career rdf:type owl:DatatypeProperty;
            rdfs:domain :Person;
            rdfs:range xsd:string .
            
    :fullName rdf:type owl:DatatypeProperty;
            rdfs:domain :Person;
            rdfs:range xsd:string .
            
    :birthDate rdf:type owl:DatatypeProperty;
            rdfs:domain :Person;
            rdfs:range xsd:date .

    :height rdf:type owl:DatatypeProperty;
            rdfs:domain :Person;
            rdfs:range xsd:int .
            
    :weight rdf:type owl:DatatypeProperty;
            rdfs:domain :Person;
            rdfs:range xsd:int .
            
    :nationality rdf:type owl:DatatypeProperty;
            rdfs:domain :Person;
            rdfs:range xsd:string .
            
    :hasBirthPlace rdf:type owl:ObjectProperty;
            rdfs:domain :Person;
            rdfs:range :Place .
            
    :address rdf:type owl:DatatypeProperty;
            rdfs:domain :Place;
            rdfs:range xsd:string .
            
    :coordinate rdf:type owl:DatatypeProperty;
            rdfs:domain :Place;
            rdfs:range xsd:string .

.. image:: /images/theorys/rdfs/owl.png

描述属性特征的词汇::

    1. owl:TransitiveProperty. 表示该属性具有传递性质。例如，我们定义“位于”是具有传递性的属性，若A位于B，B位于C，那么A肯定位于C
    2. owl:SymmetricProperty. 表示该属性具有对称性。例如，我们定义“认识”是具有对称性的属性，若A认识B，那么B肯定认识A
    3. owl:FunctionalProperty. 表示该属性取值的唯一性。 例如，我们定义“母亲”是具有唯一性的属性，若A的母亲是B，在其他地方我们得知A的母亲是C，那么B和C指的是同一个人
    4. owl:inverseOf. 定义某个属性的相反关系。例如，定义“父母”的相反关系是“子女”，若A是B的父母，那么B肯定是A的子女。

本体映射词汇（Ontology Mapping）::

    1. owl:equivalentClass. 表示某个类和另一个类是相同的
    2. owl:equivalentProperty. 表示某个属性和另一个属性是相同的
    3. owl:sameAs. 表示两个实体是同一个实体




语义网络
========

优点::

    1. 容易理解和展示。
    2. 相关概念容易聚类。

缺点::

    1. 节点和边的值没有标准，完全是由用户自己定义。
    2. 多源数据融合比较困难，因为没有标准。
    3. 无法区分概念节点和对象节点。
    4. 无法对节点和边的标签(label，我理解是schema层，后面会介绍)进行定义。

* 简而言之，语义网络可以比较容易地让我们理解语义和语义关系。其表达形式简单直白，符合自然。然而，由于缺少标准，其比较难应用于实践。
* RDF的提出解决了语义网络的缺点1和缺点2，在节点和边的取值上做了约束，制定了统一标准，为多源数据的融合提供了便利
* RDFS和OWL是RDF更上一层的技术，主要是为了解决语义网络的缺点3和缺点4，其提供了schema层的描述

语义网(Semantic Web)和链接数据(Linked Data)
===========================================

* 语义网和链接数据是万维网之父Tim Berners Lee分别在1998年和2006提出的。相对于语义网络，语义网和链接数据倾向于描述万维网中资源、数据之间的关系。
* 本质上，语义网、链接数据还有Web 3.0都是同一个概念，只是在不同的时间节点和环境中，它们各自描述的角度不同。它们都是指W3C制定的用于描述和关联万维网数据的一系列技术标准，即，语义网技术栈。

* 链接数据起初是用于定义如何利用语义网技术在网上发布数据，其强调在不同的数据集间创建链接。
* 链接数据也被当做是语义网技术一个更简洁，简单的描述。当它指语义网技术时，它更强调“Web”，弱化了“Semantic”的部分。对应到语义网技术栈，它倾向于使用RDF和SPARQL（RDF查询语言）技术，对于Schema层的技术，RDFS或者OWL，则很少使用


知识图谱
========

定义::

    A knowledge graph consists of a set of interconnected typed entities and their attributes.

.. image:: /images/theorys/rdfs/link_open_data_cloud.png


链接数据和知识图谱最大的区别在于::

    1. 正如上面Open Linked Data Project所展示的，每一个圆圈代表一个独立存在和维护的知识图谱；链接数据更强调不同RDF数据集（知识图谱）的相互链接。
    2. 知识图谱不一定要链接到外部的知识图谱（和企业内部数据通常也不会公开一个道理），更强调有一个本体层来定义实体的类型和实体之间的关系。另外，知识图谱数据质量要求比较高且容易访问，能够提供面向终端用户的信息服务（查询、问答等等）。

* 实例(The Linked Open Data Cloud): https://lod-cloud.net/




.. [1] https://zhuanlan.zhihu.com/knowledgegraph