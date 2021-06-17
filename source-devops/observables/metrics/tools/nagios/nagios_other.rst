其他运维工具
===================


当下有许多的运维自动化工具( 配置管理 )，例如::

  Ansible、SaltStack、Puppet、Fabric

Ansible 一种集成 IT 系统的配置管理、应用部署、执行特定任务的开源平台，是 AnsibleWorks 公司名下的项目，该公司由 Cobbler 及 Func 的作者于 2012 年创建成立。

Ansible 基于 Python 语言实现，由 Paramiko 和 PyYAML 两个关键模块构建。

Ansible 特点::

  >> 部署简单，只需在主控端部署 Ansible 环境，被控端无需做任何操作。
  >> 默认使用 SSH（Secure Shell）协议对设备进行管理。
  >> 主从集中化管理。
  >> 配置简单、功能强大、扩展性强。
  >> 支持 API 及自定义模块，可通过 Python 轻松扩展。
  >> 通过 Playbooks 来定制强大的配置、状态管理。
  >> 对云计算平台、大数据都有很好的支持。
  >> 提供一个功能强大、操作性强的 Web 管理界面和 REST API 接口 ---- AWX 平台。

Ansible 与 SaltStack::

  >> 最大的区别是 Ansible 无需在被监控主机部署任何客户端代理，默认通过 SSH 通道进行远程命令执行或下发配置。
  >> 相同点是都具备功能强大、灵活的系统管理、状态配置，都使用 YAML 格式来描述配置，两者都提供丰富的模板及 API，对云计算平台、大数据都有很好的支持。









