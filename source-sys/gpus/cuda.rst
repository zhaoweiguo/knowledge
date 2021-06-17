cuda
#############

* CUDA ToolKit Documentssss [1]_
* CUDA® is a parallel computing platform and programming model invented by NVIDIA. It enables dramatic increases in computing performance by harnessing the power of the graphics processing unit (GPU).


2.预安装
===========

2.1. Verify You Have a CUDA-Capable GPU::

    $ lspci | grep -i nvidia

2.2. Verify You Have a Supported Version of Linux::

    $ uname -m && cat /etc/*release

2.3. Verify the System Has gcc Installed::

    $ gcc --version

2.4. Verify the System has the Correct Kernel Headers and Development Packages Installed::

    $ uname -r

The kernel headers and development packages for the currently running kernel can be installed::
    
    RHEL/CentOS
    $ sudo yum install kernel-devel-$(uname -r) kernel-headers-$(uname -r)
    Ubuntu
    $ sudo apt-get install linux-headers-$(uname -r)

2.5. Choose an Installation Method::

    1. distribution-specific packages (RPM and Deb packages)
    2. distribution-independent package (runfile packages)
    可能的话建议使用第1种方法

2.6. Download the NVIDIA CUDA Toolkit::

    http://developer.nvidia.com/cuda-downloads

3. Package Manager Installation [2]_
===========================================

::

    $> sudo yum install 
    $> sudo yum-config-manager --add-repo http://developer.download.nvidia.com/compute/cuda/repos/rhel7/x86_64/cuda-rhel7.repo
    $> sudo yum clean all
    $> sudo yum -y install nvidia-driver-latest-dkms cuda












.. [1] https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html
.. [2] https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&target_distro=CentOS&target_version=7&target_type=rpmnetwork



