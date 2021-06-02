/etc/default/grub文件
#####################

开机选单是自动创建出来的
========================

::

    请勿尝试手动编辑开机选单，因为它是按照 /boot/ 目录内的文件自动创建出来的。
    然而你可以调整 /etc/default/grub 档内定义的通用设置，及在 /etc/grub.d/40_custom 档内加入个别自定项目。

/etc/default/grub 档的内容如下::

    GRUB_TIMEOUT=5
    GRUB_DEFAULT=saved
    GRUB_DISABLE_SUBMENU=true
    GRUB_TERMINAL_OUTPUT="console"
    GRUB_CMDLINE_LINUX="crashkernel=auto rhgb quiet"
    GRUB_DISABLE_RECOVERY="true"

通用于所有项目的内核选项都通过 GRUB_CMDLINE_LINUX 行来定义::

    // 举个例说:
    1. 要是你想看见详细的开机消息，删除 rhgb quiet。
    2. 要是你想看见标准的开机消息，只删除 rhgb

执行以下指令便能套用更改了的设置::

    $ grub2-mkconfig -o /boot/grub2/grub.cfg
    Generating grub configuration file ...
    Found linux image: /boot/vmlinuz-3.10.0-229.14.1.el7.x86_64
    Found initrd image: /boot/initramfs-3.10.0-229.14.1.el7.x86_64.img
    Found linux image: /boot/vmlinuz-3.10.0-229.4.2.el7.x86_64
    Found initrd image: /boot/initramfs-3.10.0-229.4.2.el7.x86_64.img
    Found linux image: /boot/vmlinuz-3.10.0-229.el7.x86_64
    Found initrd image: /boot/initramfs-3.10.0-229.el7.x86_64.img
    Found linux image: /boot/vmlinuz-0-rescue-605f01abef434fb98dd1309e774b72ba
    Found initrd image: /boot/initramfs-0-rescue-605f01abef434fb98dd1309e774b72ba.img
    done

.. note:: UEFI 系统上的指令是 grub2-mkconfig -o /boot/efi/EFI/centos/grub.cfg

实例
================

说明::

    这一天服务器重启，原因未知，阿里云给出以下解决方案

.. note:: 这个操作会重启主机。

正常配置内核转储，如系统异常宕机这种会有生成转储文件的。
看您反馈的都没有生成对应文件，参考以下配置下，然后可以人工触发下，看下是否有生成转储文件。

操作::

    yum install kexec-tools

    vim /etc/default/grub #修改crashkernel=auto
    GRUB_CMDLINE_LINUX="crashkernel=128M rd.lvm.lv=centos/root rd.lvm.lv=centos/swap rhgb quiet"

    grub2-mkconfig -o /boot/grub2/grub.cfg

    reboot 重启服务器

配置后，业务运行重启的情况下执行::

    echo c > /proc/sysrq-trigger 人工触发下，
    然后在 /var/crash/ 看下是否有生成的文件。










参考
====

* 在 CentOS 7 上设置 grub2: https://wiki.centos.org/zh/HowTos/Grub2