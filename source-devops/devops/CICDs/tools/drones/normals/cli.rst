cli命令 [1]_
############

安装::

    $ wget https://github.com/drone/drone-cli/releases/latest/download/drone_linux_amd64.tar.gz | tar zx

配置::

    $ export DRONE_SERVER=http://drone.zhaoweiguo.com
    $ export DRONE_TOKEN=Pclk4hB779h1VodNXEm0zZem9FBxxxx
    % 其中DRONE_TOKEN可参见:
    drone网站 -> 右上角头像 -> User Settings


::

    // 设置全局密钥
    $ drone orgsecret add [organization] [name] [data]
    注意:
    [organization]是gitlab的org
    [name]是secret的名
    [data]是secret的值


Encrypted::

    Encrypted secrets are used to store sensitive information, 
      such as passwords, tokens, and ssh keys 
      directly in your configuration file as an encrypted string

    用法:
    $ drone encrypt <repository> <secret>
    实例:
    $ drone encrypt secret octocat/hello-world top-secret-password
    hl3v+FODjduX0UpXBHgYzPzVTppQblg51CVgCbgDk4U=

    kind: pipeline
    name: default

    steps:
    - name: build
      image: alpine
      environment:
        USERNAME:
          from_secret: username
    ---
    kind: secret
    name: username
    data: hl3v+FODjduX0UpXBHgYzPzVTppQblg51CVgCbgDk4U=





.. [1] https://docs.drone.io/cli/install/