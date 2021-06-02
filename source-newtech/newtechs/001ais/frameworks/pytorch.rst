.. _pytorch:

PyTorch
#########

* github [1]_
* 官网 [2]_


PyTorch 是最新的深度学习框架之一，由 Facebook 的团队开发，并于 2017 年在 GitHub 上开源。有关其开发的更多信息请参阅论文 `《PyTorch 中的自动微分》 <https://openreview.net/pdf?id=BJJsrmfCZ>`_

PyTorch 很简洁、易于使用、支持动态计算图而且内存使用很高效，因此越来越受欢迎


* https://github.com/ShusenTang/Dive-into-DL-PyTorch
* https://tangshusen.me/Dive-into-DL-PyTorc

安装::

    // Anaconda安装
    conda install pytorch torchvision -c pytorch

    // pip安装
    # Python 3.x
    pip3 install torch torchvision
    
    # Python 2.x
    pip install torch torchvision





PyTorch 顶级项目
================

* CheXNet：使用深度学习来分析胸部 X 光照片，能实现放射科医生水平的肺炎监测: https://stanfordmlgroup.github.io/projects/chexnet/
* PYRO：这是一种用 Python 编写的通用概率编程语言（PPL），后端由 PyTorch 支持：https://pyro.ai (https://pyro.ai/)
* Horizon：一个用于应用强化学习（Applied RL）的平台：https://horizonrl.com (https://horizonrl.com/)

TensorFlow 还是 PyTorch?
========================

TensorFlow 是一种非常强大和成熟的深度学习库，具有很强的可视化功能和多个用于高级模型开发的选项。它有面向生产部署的选项，并且支持移动平台。另一方面，PyTorch 框架还很年轻，拥有更强的社区动员，而且它对 Python 友好。

我的建议是如果你想更快速地开发和构建 AI 相关产品，TensorFlow 是很好的选择。建议研究型开发者使用 PyTorch，因为它支持快速和动态的训练。

首先我们要搞清楚pytorch和TensorFlow的一点区别，那就是pytorch是一个动态的框架，而TensorFlow是一个静态的框架。


.. [1] https://github.com/pytorch/pytorch
.. [2] https://pytorch.org/