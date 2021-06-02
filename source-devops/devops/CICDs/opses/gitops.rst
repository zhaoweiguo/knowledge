GitOps
==========

* GitOps 初探 [1]_
* 实战攻略：利用 GitOps 在 Kubernetes 上实现持续交付 [2]_
* Istio 的 GitOps——像代码一样管理 Istio 配置 [3]_

DevOps 就是开发 + 测试 + 运维，一套都自动化，自动构建、自动测试、自动发布，所谓的 CI/CD （持续集成、持续交付）工作流水线。而GitOps就是基于 Git 的 DevOps 工作流水线。根源在于使开发人员能够使用 git 创建 CI/CD 来自动化多云和多容器编排集群的开发和运营。

.. note:: 核心思想是将应用系统的声明性基础架构和应用程序存放在 Git 版本库中。将 Git 作为交付流水线的核心，每个开发人员都可以提交拉取请求（Pull Request）并使用 Gi​​t 来加速和简化 Kubernetes 的应用程序部署和运维任务。通过使用像 Git 这样的简单工具，开发人员可以更高效地将注意力集中在创建新功能而不是运维相关任务上（例如，应用系统安装、配置、迁移等）。


.. note:: GitOps: versioned CI/CD on top of declarative infrastructure. Stop scripting and start shipping. https://t.co/SgUlHgNrnY — Kelsey Hightower (@kelseyhightower) January 17, 2018

优势和特点::

    安全的云原生 CI/CD 管道模型
    更快的平均部署时间和平均恢复时间
    稳定且可重现的回滚（例如，根据 Git 恢复 / 回滚 /fork）
    与监控和可视化工具相结合，对已经部署的应用进行全方位的监控


.. note:: GitOps 应用场景 —— 满足云原生环境下的持续交付



GitOps 的基本原则::

    1. 任何能够被描述的内容都必须存储在 Git 库中
      通过使用 Git 作为存储声明性基础架构和应用程序代码的存储仓库，
      可以方便地监控集群，以及检查比较实际环境的状态与代码库上的状态是否一致。
      所以，我们的目标是描述系统相关的所有内容：策略，代码，配置，甚至监控事件和版本控制等，
      并且将这些内容全部存储在版本库中，在通过版本库中的内容构建系统的基础架构或者应用程序的时候，
      如果没有成功，则可以迅速的回滚，并且重新来过。

    2. 不应直接使用 Kubectl
      作为一般规则，不提倡在命令行中直接使用 kubectl 命令操作执行部署基础架构或应用程序到集群中。
      还有一些开发者使用 CI 工具驱动应用程序的部署，但如果这样做，可能会给生产环境带来潜在不可预测的风险。

    3. 调用 Kubernetes 的 API 的接口或者控制器应该遵循 Operator 模式
      调用 Kubernetes 的 API 的接口或者控制器应该遵循 Operator 模式
      集群的状态和 Git 库中的配置文件等要保持一致，并且查看分析它们之间的状态差异。








参考
====

* 【知乎】GitOps | 一种实现云原生的持续交付模型: https://zhuanlan.zhihu.com/p/43002417

.. [1] https://app.yinxiang.com/fx/f36abf0f-fa05-43c1-b4ef-91e695c420ed
.. [2] https://app.yinxiang.com/fx/9fb5cd35-80af-45ee-9b62-76367f979946
.. [3] https://app.yinxiang.com/fx/2e74b829-3551-4964-ab0c-7c0f3bc429f5