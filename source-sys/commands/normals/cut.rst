cut命令
##############

选项::

    -c col: 取每和行指定列数col往后面的所有

实例::

    $> find . -mindepth 1 -maxdepth 1 -type d
    ./genyaml
    ./kubemark
    ./hyperkube

    $> find . -mindepth 1 -maxdepth 1 -type d | cut -c 3-
    genyaml
    kubemark
    hyperkube






