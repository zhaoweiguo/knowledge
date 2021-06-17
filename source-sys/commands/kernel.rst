.. _linux_kernel:

linux核心修改命令
###############################
linux下的功能模块可以分为静态内核模块和动态功能模块

* 静态内核模块一半是随内核启动就自动加载，而动态模块是在需要的时候通过linux提供的模块加载命令，例如modprobe  等，根据需要加载进入系统中
* 静态模块的好处是有linux内核来统一管理，性能较高，而动态模块管理和使用方便，不需要使用时，卸载模块即可


.. toctree::
   :maxdepth: 2

   kernels/modprobe
   kernels/kexec
   kernels/lsmod
   kernels/sysctl
   kernels/systemctl

   kernels/supervisor

   kernels/make

   kernels/inotify
