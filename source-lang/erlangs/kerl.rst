kerl使用 [1]_
##############
erlang版本管理

安装::

    $ brew install kerl
    or
    $ curl -O https://raw.githubusercontent.com/kerl/kerl/master/kerl

    文件:
    ~/.kerl/


用法::

    % 查看release列表
    $> kerl list releases
    % 从erlang.org更新release列表
    $> kerl update releases

    % 构建
    $> kerl build 19.2 19.2
    % 显示已构建版本
    $> kerl list builds



    % 安装
    $> kerl install <build_name> <path>     % <build_name>为前面build起的名字
    % 19.2版本到指定目录
    $> kerl install 19.2 ~/kerl/19.2

    % 
    $> kerl list installations

    % 查看
    $> kerl status
    % 显示当前已经激活的Erlang版本
    $> kerl active
    % 显示当前激活的erlang安装路径
    $ kerl path
    % 显示指定build版本安装路径
    $ kerl path 19.2



    % 删除
    % 删除特定的构建
    $> kerl delete build 17.4


其他构建方式::

    
    % Building from a git source
    $> kerl build git https://github.com/erlang/otp.git master 20160411

    % Building from a github fork
    $> export KERL_BUILD_BACKEND=git
    $> export OTP_GITHUB_URL="https://github.com/basho/otp"
    $> kerl update releases
    $> kerl build R16B02_basho10 16b02-basho10

使用::

    % 激活
    . <install_folder>/<version>/activate
    % 取消激活
    kerl_deactivate


部署::

    kerl deploy <[user@]host> [directory] [remote_directory]
    kerl deploy test@192.168.8.100 /deploy/erlang/18.3_hipe
    把指定Erlang构建版本部署到远程服务器上,
    这样在一个集群中, 我们可以在一个服务器上编译,
    统一部署所有的集群节点的 Erlang 运行环境







.. [1] https://github.com/kerl/kerl



