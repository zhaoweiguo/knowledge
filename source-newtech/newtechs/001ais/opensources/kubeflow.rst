.. _kubeflow:

kubeflow
########

* github [1]_
* 官网 [2]_

Kubeflow 是由 Google 等公司于 2017 年推出的基于 Kubernetes 的开源项目，它支持常见的机器学习框架。

Kubeflow has three core components::

    1. TF Job Operator and Controller:
        Extension to Kubernetes to simplify deployment of distributed TensorFlow workloads.
    2. TF Hub: 
        Running instances of JupyterHub, enabling you to work with Jupyter Notebooks.
    3. Model Server:
        Deploying a trained TensorFlow models for clients to access and use for future predictions.




.. [1] https://github.com/kubeflow/kubeflow
.. [2] https://www.kubeflow.org/