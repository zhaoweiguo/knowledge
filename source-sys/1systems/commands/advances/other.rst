其他命令临时地
##############

pycopy & pbpaste
================

* linux版: https://www.ostechnix.com/how-to-use-pbcopy-and-pbpaste-commands-on-linux/

使用::

    // mac 自带命令
    pbcopy < ~/.ssh/id_rsa.pub
    grep "<keyword>" | pbcopy

.. note::  这个命令好用，比 linux 下此命令好用。可以完美与 gui 接合


网速
====

* speedtest-cli: https://github.com/sivel/speedtest-cli ::
  
    https://github.com/sivel/speedtest-cli/wiki
    安装在 ~/bin 目录下






其他
====

- 摘自: https://medium.com/swlh/my-favorite-cli-tools-c2fa484cee52
- mac 工具：
    - 窗口管理：
        - https://github.com/rxhanson/Rectangle
        - https://github.com/ianyh/Amethyst
        - 类似Magnet
    - [x] 记忆专用
        - 记忆卡片: https://apps.ankiweb.net/
- docker 工具
    - lazydocker
        - https://github.com/jesseduffield/lazydocker
        - The lazier way to manage everything docker
        - brew install lazydocker
        - [更新版]brew install jesseduffield/lazydocker/lazydocker
- 小工具
    - httpie
        - https://httpie.org/
        - 更直观

- 配置信息::
  
    https://obihann.github.io/archey-osx/
    使用:
    > welcome
                 ###                  User: zhaoweiguo
               ####                   Hostname: zhaowgMac
               ###                    Distro: OS X 11.0.1
       #######    #######             Kernel: Darwin
     ######################           Uptime: 19 days
    #####################             Shell: /bin/zsh
    ####################              Terminal: xterm iTerm.app
    ####################              CPU: Intel Core i9-9880H CPU @ 2.30GHz
    #####################             Memory: 32 GB
     ######################           Disk: 16%
      ####################            Battery: 81.54%%
        ################              IP Address: 60.247.104.73
         ####     #####

- FIGlet: http://www.figlet.org/ ::

    $ brew install figlet
    $ printf "\e[92m" && figlet -f standard "Terminal Tips"
    $ printf "\e[95m" && figlet -f standard "Terminal Tips"
    $ printf "\e[31;3m" && figlet -f standard "Terminal Tips"

    Fonts:
    $ printf "\e[96m" && figlet -f starwars "Terminal Tips"
    // 参考实例: http://www.figlet.org/examples.html


- Colors::

    $ for code in {30..37}; do \
    echo -en "\e[${code}m"'\\e['"$code"'m'"\e[0m"; \
    echo -en "  \e[$code;1m"'\\e['"$code"';1m'"\e[0m"; \
    echo -en "  \e[$code;3m"'\\e['"$code"';3m'"\e[0m"; \
    echo -en "  \e[$code;4m"'\\e['"$code"';4m'"\e[0m"; \
    echo -e "  \e[$((code+60))m"'\\e['"$((code+60))"'m'"\e[0m"; \
    done

- Weather reports on your terminal::

    $ curl wttr.in/CityName
    $ curl wttr.in/Beijing
    帮助:
    $ curl wttr.in/:help

    alias:
    # weather
    alias we='curl wttr.in\?0nqF'
    alias we1='curl wttr.in\?1nqF'
    alias we2='curl wttr.in\?2nqF'
    alias weather='curl wttr.in\?nqF'

* https://github.com/chubin/wttr.in
* golang 版: https://github.com/schachmat/wego
* https://github.com/chubin/pyphoon

.. image:: /images/linuxs/linux_command_advance_weather.png


 






