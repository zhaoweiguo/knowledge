sh初始化文件
############

bash的几个初始化文件::

    /etc/profile
    /ect/bashrc(主要修改对象)
    ~/.profile
    ~/.bash_login
    ~/.bash_profile(主要修改对象)
    ~/.bashrc
    ~/.bash_logout


bash如何更改环境变量PATH的值::

    ~/.bash_profile
    ~/.bashrc

zsh如何更改环境变量PATH的值::

    ~/.zprofile
    ~/.zshrc


path路径::

    /etc/profile
    %or
    ~/.bash_profile
    %添加如下命令
    PATH=/sbin:$PATH

