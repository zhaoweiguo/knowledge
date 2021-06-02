机器学习machine learning
########################

Kinds of Machine Learning
=========================

Supervised learning
-------------------

Regression::

    “How many hours will this surgery take?”: regression
    “How many dogs are in this photo?”: regression.

    L1 loss where
    𝑙(𝑦,𝑦′)=∑𝑖|𝑦𝑖−𝑦′𝑖|
 
    L2 loss, where
    𝑙(𝑦,𝑦′)=∑𝑖(𝑦𝑖−𝑦′𝑖)2

Classification::

    optical character recognition (OCR)
    It is treated with a different set of algorithms than those used for regression.
    In classification, we want our model to look at a feature vector
      (e.g., the pixel values in an image)
      and then predict which category (formally called classes), 
      among some (discrete) set of options, an example belongs.
    The simplest form of classification is when there are only two classes, 
      a problem which we call binary classification. 


Tagging::

    The problem of learning to predict classes that are not mutually exclusive 
      is called multi-label classification.
    一个图片中即有狗也有猫时，不能使用上面Classification中的方法来判断是否有狗或猫
    A typical article might have 5-10 tags applied because these concepts are correlated.
    一个技术blog中可能有多个tag, 相互间是有关联关系。

Search and ranking::

    Google搜索, 一个关键词对应的搜索结果

Recommender systems::

    推荐系统, 根据你的喜好给你推荐内容: 头条推荐你喜欢的内容

Sequence Learning::

    1. Automatic Speech Recognition
    2. Text to Speech.
    3. Machine Translation.

Unsupervised learning
---------------------

::

    1. clustering
    2. subspace estimation problems. 
       principal component analysis(If the dependence is linear)
    3. representation learning(e.g. Rome  −  Italy  +  France  =  Paris.)
    4. causality and probabilistic graphical models
    5. advent of generative adversarial networks




Interacting with an Environment
-------------------------------

offline learning::

    前讲的都是离线学习. 即:
    需要预先获取大量数据，然后使模式识别机器处于运行状态，之后无需再次与环境交互。

    Asimov’s Robot Series
    That means we need to think about choosing actions, not just making predictions. 
    Moreover, unlike predictions, actions actually impact the environment.
    真正的机器人做的操作会对环境有影响(与仅预测比)

Reinforcement learning
----------------------

2个实例::

    deep Q-network that beat humans at Atari games using only the visual input
    the AlphaGo program that dethroned the world champion at the board game Go

* The goal of reinforcement learning is to produce a good policy.
* we can cast any supervised learning problem as an RL problem.

MDPs, bandits, and friends
--------------------------

* When the environment is fully observed, we call the RL problem a 
      「Markov Decision Process (MDP)」. 
* When the state does not depend on the previous actions, we call the problem a
      「contextual bandit problem」
* When there is no state, just a set of available actions with initially unknown rewards, 
      this problem is the classic 「multi-armed bandit problem」.


实例
====

::

    自动驾驶: autopilot
    NLP: 
    图像识别、语音识别: visual/speech recognition
    高频交易: high frequency trading
    CV: 





