安装
####

安装istioctl::

    1. 方法1:
    $ curl -L https://istio.io/downloadIstio | sh -
    Istio 1.4.3 Download Complete!

    Istio has been successfully downloaded into the istio-1.4.3 folder on your system.

    Next Steps:
    See https://istio.io/docs/setup/kubernetes/install/ to add Istio to your Kubernetes cluster.

    Begin the Istio pre-installation verification check by running:
       istioctl verify-install

    Need more information? Visit https://istio.io/docs/setup/kubernetes/install/

    2. 方法2:
    对mac来说本质是执行下面命令并解压
    $ wget https://github.com/istio/istio/releases/download/1.4.3/istio-1.4.3-osx.tar.gz
    $ tar zxvf istio-1.4.3-osx.tar.gz && rm istio-1.4.3-osx.tar.gz

    注: 下载实在太慢, 可以来这儿找
    链接: https://pan.baidu.com/s/1M0XLWNCRSe2dBChlTKAEbA 提取码: xduu





