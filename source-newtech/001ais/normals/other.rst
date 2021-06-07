其他
####

Torch
=====

* 官网 [1]_

Torch 是用 Lua 编写带 API 的科学计算框架，支持机器学习算法。Facebook 和 Twitter 等大型科技公司使用 Torch 的某些版本，由内部团队专门负责定制自己的深度学习平台。其优缺点如下::

    ✓ 大量模块化组件，容易组合;
    ✓ 易编写新的网络层;
    ✓ 支持丰富的预训练模型;
    ✓ PyTorch 为 Torch 提供了更便利的接口;

    ✗ 使用 Lua 语言需要学习成本;
    ✗ 文档质量参差不齐;
    ✗ 一般需要自己编写训练代码(即插即用相对较少)。


caffe
=====

* github [2]_
* 官网 [3]_

 Caffe 是一个广为人知、广泛应用侧重计算机视觉方面的深度学习库，由加州大学伯克利分校 BVLC 组开发 

总结来说， Caffe 有以下优缺点::

    ✓ 适合前馈网络和图像处理;  
    ✓ 适合微调已有的网络模型;  
    ✓ 训练已有网络模型无需编写任何代码;   
    ✓ 提供方便的 Python 和 MATLAB 接口; 

    ✗ 可单机多卡，但不支持多机多卡;   
    ✗ 需要用 C++/CUDA 编写新的 GPU 层;  
    ✗ 不适合循环网络;  
    ✗ 用于大型网络(如， GoogLeNet、 ResNet )时过于繁琐;   
    ✗ 扩展性稍差，代码有些不够精简;   
    ✗ 不提供商业支持;  
    ✗ 框架更新缓慢，可能之后不再更新。 



Caffe2
======

* Caffe2 is now a part of `PyTorch <pytorch>`_


Deeplearning4j
==============

Deeplearning4j 简称 DL4J，是基于JVM、聚焦行业应用且提供商业支持的分布式深度学习框架，其宗旨是在合理的时间内解决各类涉及大量数据的问题。 它与 Hadoop 和 Spark 集成，可使用任意数量的 GPU 或 CPU 运行。 DL4J 是一种适用于各类平台的便携式学习库。开发语言为 Java，可通过调整 JVM 的堆空间、垃圾回收算法、内存管理以及 DL4J 的 ETL 数据加工管道来优化 DL4J 的性能。

其优缺点为::

  ✓ 适用于分布式集群，可高效处理海量数据;   
  ✓ 在多种芯片上的运行已经被优化;   
  ✓ 可跨平台运行，有多种语言接口;   
  ✓ 支持单机多卡和多机多卡;  
  ✓ 支持自动求导，方便编写新的网络层;   
  ✓ 提供商业支持; 

  ✗ 提供的预训练模型有限;   
  ✗ 框架速度不够快。 




MatConvNet
==========

MatConvNet 由英国牛津大学著名计算机视觉和机器学习研究组 VGG 负责开发，是主要基于 MATLAB 的深度学习工具包。其优缺点为::

    ✓ 基于 MATLAB，便于进行图像处理和深度特征后处理;
    ✓ 提供了丰富的预训练模型;
    ✓ 提供了充足的文档及教程;

    ✗ 不支持自动求导; 
    ✗ 跨平台能力差。

Theano
======

Theano 是深度学习框架中的元老，用 Python 编写，可与其他学习库配合使用，非常适合学术研究中的模型开发。现在已有大量基于 Theano 的开源深度学习库，包括 Keras、Lasagne 和  Blocks。这些学习库试着在 Theano 有时不够直观的接口之上添加一层便于使用的 API。关于 Theano，有如下特点::

    ✓ 支持 Python 和 Numpy;
    ✓ 支持自动求导;
    ✓ RNN 与计算图匹配良好;
    ✓ 高级的包装(Keras、Lasagne)可减少使用时的麻烦; 

    ✗ 编译困难，错误信息可能没有帮助;
    ✗ 运行模型前需编译计算图，大型模型的编译时间较长; 
    ✗ 仅支持单机单卡;
    ✗ 对预训练模型的支持不够完善。

临时
====

* tensorflow：http://www.tensorfly.cn/谷歌基于DistBelief进行研发的第二代人工智能学习系统
* caffe2：https://caffe2.ai/，A New Lightweight, Modular, and Scalable Deep Learning Framework
* PyTorch is a deep learning framework for fast, flexible experimentation. https://pytorch.org/
* mxnet: http://mxnet.incubator.apache.org/A flexible and efficient library for deep learning.
* OpenCV (Open Source Computer Vision Library) is released under a BSD license and hence it’s free for both academic and commercial use. https://opencv.org/
* Dlib is a modern C++ toolkit containing machine learning algorithms and tools for creating complex software in C++ to solve real world problems. http://dlib.net/

深度学习工具::

  tensorflow
  caffe
  pytorch
  mxnet

计算机视觉工具::

  opencv
  dlib

语音处理软件::

  kaldi
  htk

* 机器学习: https://github.com/JustFollowUs/Machine-Learning
* 欧拉公式、费马小定理、中国剩余定理


.. [1] http://torch.ch/
.. [2] https://github.com/BVLC/caffe
.. [3] http://caffe.berkeleyvision.org/