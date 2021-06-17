镜像源
############

debian镜像源
============

修改镜像源操作::

    $> tee /etc/apt/sources.list <<-'EOF'
    xxxxx
    $> apt-get update

阿里debian10(buster)镜像源::

    deb http://mirrors.aliyun.com/debian buster main contrib non-free
    deb http://mirrors.aliyun.com/debian buster-updates main contrib non-free
    deb http://mirrors.aliyun.com/debian-security buster/updates main contrib non-free
    EOF

阿里debian10(buster)镜像源(带源码)::

    deb http://mirrors.aliyun.com/debian buster main contrib non-free
    deb-src http://mirrors.aliyun.com/debian buster main contrib non-free
    deb http://mirrors.aliyun.com/debian buster-updates main contrib non-free
    deb-src http://mirrors.aliyun.com/debian buster-updates main contrib non-free
    deb http://mirrors.aliyun.com/debian-security buster/updates main contrib non-free
    deb-src http://mirrors.aliyun.com/debian-security buster/updates main contrib non-free
    EOF

阿里debian9(stretch)镜像源::

    deb http://mirrors.aliyun.com/debian/ stretch main non-free contrib
    deb http://mirrors.aliyun.com/debian-security stretch/updates main
    deb http://mirrors.aliyun.com/debian/ stretch-updates main non-free contrib
    deb http://mirrors.aliyun.com/debian/ stretch-backports main non-free contrib
    EOF







