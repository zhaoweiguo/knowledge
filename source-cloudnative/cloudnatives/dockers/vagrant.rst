vagrant命令
#################

* site: http://www.vagrantup.com
* 一些共享box: http://www.vagrantbox.es/
* vagrant的cloud: https://vagrantcloud.com/
* 文档:http://docs.vagrantup.com/

简单命令::

    vagrant init <title>     # 其实就是生成Vagrantfile的过程
    vagrant init hashicorp/precise32


    vagrant up     # 启动vagrant对应的虚拟机
    vagrant up --provider=vmware_fusion   # 指定容器为vmware
    vagrant up --provider=aws    # 指定窗口为cloud——aws

    vagrant ssh    # 连接虚拟机

    vagrant suspend   # 会吃一定磁盘
    vagrant halt
    vagrant destroy



共享目录::

    /vagrant     # 默认在虚拟机下的共享目录

Box命令::

    vagrant box add <>
    e.x: vagrant box add hashicorp/precise32   # 从https://vagrantcloud.com/下载此名的box
    # 也可以加载本地或你自己url的box

    vagrant box list
    vagrant box remove
    vagrant box repackage



实例::

    vagrant init     // 初使化vagrant,生成Vagrantfile文件
    vagrant box add <title> <url>   // 其中title随便起,url可以从上面网站中获取
    vagrant up   // 启动vagrant

个性化实例1 ``Vagrantfile``::

    Vagrant.configure("2") do |config|
       config.vm.box = "hashicorp/precise32"               # 指定box名
       config.vm.provision :shell, path: "bootstrap.sh"    # 设定up时执行shell文件bootstrap.sh
       # 如果增加provision之前box已经运行，可以使用vagrant reload --provision加载

       config.vm.network :forwarded_port, host: 4567, guest: 80   # 把box的80端口绑定到主机的4567端口
    end




个性化实例2 ``Vagrantfile`` ::

    # -*- mode: ruby -*-
    # vi: set ft=ruby :

    # Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
    VAGRANTFILE_API_VERSION = "2"

    Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

      config.vm.define :app1 do |app|
        app.vm.provider "virtualbox" do |v|
          v.customize ["modifyvm", :id, "--name", "app1"]
        end
        app.vm.guest = :freebsd
        app.vm.box = "app"
        app.ssh.username = "root"
        app.ssh.guest_port = 22
        app.ssh.timeout = 100
        app.ssh.host = "118.194.167.99"
        app.ssh.shell = "sh"
        app.vm.hostname = "app1"
        app.vm.network :forwarded_port,guest: 22, host: 22001, host_ip: "118.194.167.99", id: "ssh"
        app.vm.network :public_network,:bridge => "bce0",:type => :static, ip: "192.168.1.20",netmask: "255.255.255.0"
        app.vm.synced_folder "vagrant", "/vagrant", disabled: true
      end
    end





