tensorflow
##########

* 官网 [1]_
* 官网2 [2]_
* github [3]_

tensorflow是由Jeff Dean领头的谷歌大脑团队基于谷歌内部第一代深度学习系统DistBelief改进而来的通用计算框架。TensorFlow 是谷歌的开发者创造的一款开源的深度学习框架，于 2015 年发布。官方研究发布于论文 `《TensorFlow：异构分布式系统上的大规模机器学习》 <http://download.tensorflow.org/paper/whitepaper2015.pdf>`_

TensorFlow 是 Google 负责开发的用 Python API 编写，通过 C/C++ 引擎加速的深度学习框架，是目前受关注最多的深度学习框架。它使用数据流图集成 深度学习中最常见的单元，并支持许多的 CNN 网络结构以及不同设置的 RNN。其优缺点为::

    ✓ 具备不局限于深度学习的多种用途，还有支持强化学习和其他算法的工具;
    ✓ 跨平台运行能力强;
    ✓ 支持自动求导;

    ✗ 运行明显比其他框架慢;
    ✗ 不提供商业支持。


lenet-5模型简介：LeNet-5模型是Yann LeCun教授于1988年在论文Gradient-based learning applied to document recognition中提出的，并且是第一个成功应用于数字识别问题的卷积神经网络。LeNet-5模型总共有七层。分别是卷积层-池化层-卷积层-池化层-全连接层-全连接层-全连接层。

* 虽然DistBelief已经被谷歌内部很多产品所使用，但是DistBelief过于依赖谷歌内部的系统架构，很难对外开源。为了将这样一个在谷歌内部已经获得了巨大成功的系统开源，谷歌大脑团队对DistBelief进行了改进，并于2015年11月正式公布了基于Apache 2.0开源协议的计算框架TensorFlow。相比DistBelief，TensorFlow的计算模型更加通用、计算速度更快、支持的计算平台更多、支持的深度学习算法更广而且系统的稳定性也更高。关于TensorFlow平台本身的技术细节可以参考谷歌的论文 ``TensorFlow: Large-Scale Machine Learning on Heterogeneous Distributed Systems``


docker::

    $ docker pull tensorflow/tensorflow                     # latest stable release
    $ docker pull tensorflow/tensorflow:devel-gpu           # nightly dev release w/ GPU support
    $ docker pull tensorflow/tensorflow:latest-gpu-jupyter  # latest release w/ GPU support and Jupyter

启动 TensorFlow Docker 容器::
    
    $ docker run [-it] [--rm] [-p hostPort:containerPort] tensorflow/tensorflow[:tag] [command]

    $ docker run -it --rm tensorflow/tensorflow \
       python -c "import tensorflow as tf; tf.enable_eager_execution(); print(tf.reduce_sum(tf.random_normal([1000, 1000])))"

    $ docker run -it --rm -v $PWD:/tmp -w /tmp tensorflow/tensorflow python ./script.py

TensorFlow 顶级项目
===================

* Magenta：一个探索将机器学习用作创造过程的工具的开源研究项目：https://magenta.tensorflow.org/
* Sonnet：这是一个基于 TensorFlow 的软件库，可用于构建复杂的神经网络：https://sonnet.dev/
* Ludwig：这是一个无需写代码就能训练和测试深度学习模型的工具箱：https://uber.github.io/ludwig



Tensorflow的劣势
================

Tensorflow静态图虽说上手难了点，但这并非1.x版本不好用的主要原因。Tensorflow 1.x不好用的主要原因在于API混乱。到了Tensorflow 2.0后，情况并没有好转。为了兼容1.x，谷歌也是想方设法的搞。可是，2.x的生态其实连Pytorch的车尾灯都看不到。还不如坚守静态图，然后好好梳理一下自己的API！



逻辑回归
========




激活函数
========

* 在实际的神经网络中，我们不能直接用逻辑回归。必须要在逻辑回归外面再套上一个函数。这个函数我们就称它为激活函数
* 激活函数非常非常重要，如果没有它，那么神经网络的智商永远高不起来。而且激活函数又分好多种。

sigmoid的激活函数

.. image:: /images/ais/activation_function_sigmoid2.png

.. image:: /images/ais/activation_function_sigmoid.png







.. [1] https://www.tensorflow.org/
.. [2] https://tensorflow.google.cn/
.. [3] https://github.com/tensorflow