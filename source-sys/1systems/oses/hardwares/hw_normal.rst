常见知识
=================

板子::
  
  51单片机
  AVR单片机
  arm板

  
芯片-WiFi模块（六大Wi-Fi芯片厂商）::

  1.乐鑫
    ESP8266、ESP8285
  2.新岸线
    NL6621
  3.联盛德微电子
    W500
  4.南方硅谷
    SSV6060P
  5.澜起科技
    M88WI6032D、M88WI6800-K
  6.上海庆科
    EMW3162、EMW5088、EMW3081、EMW3088、EMW3165、EMW1088、EMW3240、EMW1062、EMW3081A、EMW3238

芯片、串口、接口::
  
  232接口
  RS-422

  CH340:CH340 是一个USB 总线的转接芯片，实现USB 转串口、USB 转IrDA 红外或者USB 转打印口。
  CP2102:CP2102其集成度高，内置USB2.0全速功能控制器、USB收发器、晶体振荡器、EEPROM及异步串行数据总线（UART），支持调制解调器全功能信号，无需任何外部的USB器件。CP2102与其他USB-UART转接电路的工作原理类似，通过驱动程序将PC的USB口虚拟成COM口以达到扩展的目的。

  -- 稳压器
  AMS1117:AMS1117系列稳压器有可调版与多种固定电压版

线::
  
  杜板线

配置::

    smartconfig
    softAP

常见::
  
  Raspberry Pi：树莓派
  Tessel：JavaScript做嵌入式
  Ruff：JavaScript做嵌入式2
  Arduino：开源电子原型平台
  ESP8266

文件后缀::
  
  印制电路板.PCB
  物料清单BOM
  原理图文件 .SCH
  工程文件 .DDB

简称::

  TX发送端
  RX接收端
  GND是地
  VCC是电源
  NC就是没有连接
  UART通用异步收发传输器（Universal Asynchronous Receiver/Transmitter)是一种异步收发传输器，是电脑硬件的一部分。它将要传输的资料在串行通信与并行通信之间加以转换。


开发环境::

  LabVIEW
  Keil C51

设备相关术语
============

* 北向接口：提供给其他厂家或运营商进行接入和管理的接口，即向上提供的接口
* 南向接口：管理其他厂家网管或设备的接口，即向下提供的接口

A northbound interface is an interface that conceptualizes lower level details. It interfaces to higher level layers and is normally drawn at the top of an architectural overview.
A southbound interface decomposes concepts in the technical details, mostly specific to a single component of the architecture. Southbound interfaces are drawn at the bottom of an architectural overview.
Northbound interfaces normally talk to southbound interfaces of higher level components and vice versa.

从英文定义可以看出来::

    1.北向接口是某个模块的顶层抽象接口
    2.南向接口是某个模块之内部子模块的接口
    3.北向接口因处于架构图的顶部而得名,南向接口则因处于架构图的底部而得名,所谓上北下南
    4.另外,北向和南向也是相对的,相对于更顶级的模块,某个模块的北向接口就相对来说是南向接口了

组态软件::

    组态软件在国内是一个约定俗成的概念，并没有明确的定义，它可以理解为“组态式监控软件”。
    “组态（Configure）”的含义是“配置”、“设定”、“设置”等意思，
    是指用户通过类似“搭积木”的简单方式来完成自己所需要的软件功能，而不需要编写计算机程序，也就是所谓的“组态”。
    它有时候也称为“二次开发”，组态软件就称为“二次开发平台”。“监控（Supervisory Control）”，
    即“监视和控制”，是指通过计算机信号对自动化设备或过程进行监视、控制和管理。
    组态就像搭积木，摆好各个块后，在配置他们之间的关系
    缩写: SCADA, Supervisory Control and Data Acquisition
    全称: 组态监控软件系统软件
    功能: 数据采集与监视控制

    “组态(Configure)”的含义是“配置”、“设定”、“设置”等意思，
    是指用户通过类似“搭积木”的简单方式来完成自己所需要的软件功能，而不需要编写计算机程序，也就是所谓的“组态”。
    它有时候也称为“二次开发”，组态软件就称为“二次开发平台”。
    “监控（Supervisory Control）”，即“监视和控制”，是指通过计算机信号对自动化设备或过程进行监视、控制和管理。
    简单地说，组态软件能够实现对自动化过程和装备的监视和控制。
    它能从自动化过程和装备中采集各种信息，并将信息以图形化等更易于理解的方式进行显示，
    将重要的信息以各种手段传送到相关人员，对信息执行必要分析处理和存储，发出控制指令等等。

    中文名:组态
    外文名:Configure
    含义:配置、设定、设置, 也称:“二次开发”
    释义:用软件中的工具完成任务的过程

看门狗::

    看门狗就是定期的查看芯片内部的情况，一旦发生错误就向芯片发出重启信号的电路。
    看门狗命令在程序的中断中拥有最高的优先级。防止程序跑飞。也可以防止程序在线运行时候出现死循环。
    软件名称: 看门狗
    软件平台: 51 系列单片机
    类别: 监控软件
    功能: 定时


建模::

    建模就是建立模型，就是为了理解事物而对事物做出的一种抽象，是对事物的一种无歧义的书面描述。
    建立系统模型的过程，又称模型化。建模是研究系统的重要手段和前提。
    凡是用模型描述系统的因果关系或相互关系的过程都属于建模。
    因描述的关系各异，所以实现这一过程的手段和方法也是多种多样的。
    可以通过对系统本身运动规律的分析，根据事物的机理来建模;
    也可以通过对系统的实验或统计数据的处理,并根据关于系统的已有的知识和经验来建模。还可以同时使用几种方法。
    中文名: 建模
    外文名: Modeling
    性质: 用模型描述系统
    别名: 模型化
    原因: 对系统本身运动规律的分析



