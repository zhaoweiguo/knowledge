Docker代理加速
##################

配置镜像加速器 [1]_
::

    // Linux版
    sudo mkdir -p /etc/docker
    sudo tee /etc/docker/daemon.json <<-'EOF'
    {
      "registry-mirrors": ["https://bpsifqa9.mirror.aliyuncs.com"]
    }
    EOF
    sudo systemctl daemon-reload
    sudo systemctl restart docker

.. warning:: 注意, systemctl restart docker会重启docker服务
    k8s集群上执行,所有docker服务都会重启

其他proxy::

    阿里云: https://bpsifqa9.mirror.aliyuncs.com
    Docker 官方提供的中国 registry mirror https://registry.docker-cn.com
    七牛云加速器 https://reg-mirror.qiniu.com/

配置 DNS::

    # 每次启动的容器 DNS 自动配置为 114.114.114.114 和 8.8.8.8
    $ cat /etc/docker/daemon.json
    {
      "dns" : [
        "114.114.114.114",
        "8.8.8.8"
      ]
    }

如果希望永久绑定到某个固定的 IP 地址::

    $ cat /etc/docker/daemon.json
    {
      "ip": "0.0.0.0"
    }






.. [1] https://cr.console.aliyun.com/cn-hangzhou/instances/mirrors