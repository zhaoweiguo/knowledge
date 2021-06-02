---
title: 阿里产品ASM用户验收测试初体验
date: 2020-02-05 19:16:23
categories:
- aliyun
tags:
- aliyun
- service mesh
- UAT
---

### 简介

我正在学习Istio，正巧碰到阿里云的服务网格(Alibaba Cloud Service Mesh，简称 ASM)进入UAT环境 [1]，于是报名并有幸能抢先体验一把阿里的Service Mesh。阿里这边对UAT的要求是「以真实客户视角从产品开通、控制台易用性、功能完整性和有效性以及帮助文档的完整性、准确性和易读性等维度体验评测产品，在规定时间完成产品评测后按照提交建议和评分模板完成最后的体验建议提交和评分。」UTA评分标准如下图:

![UAT评分标准](/images/alis/asm_uat1.png)

### 


##### 操作步骤

创建 ASM 实例，参见 创建 ASM 实例。
添加集群到 ASM 实例，参见添加集群到 ASM 实例。
为 ASM 实例中的集群部署入口网关，参见添加入口网关。
将应用部署到 ASM 实例，参见部署应用到 ASM 实例。
定义虚拟服务和 Istio 网关

##### 前提条件

已开通以下服务：
服务网格 ASM
容器服务
资源编排（ROS）服务
弹性伸缩（ESS）服务
访问控制（RAM）服务
已创建至少一个标准托管ACK集群





[^1]: https://mvp.aliyun.com/crowdsource/assignment/393