goreman
#######

* github: https://github.com/mattn/goreman
* ``站内链接: 关联——Procfile<Procfile>``

基本::

    安装:
    $ go get github.com/mattn/goreman

    使用:
    $ cat << EOF > Procfile
    web1: go run web.go -a :8091
    web2: go run web.go -a :8092
    web3: go run web.go -a :8083
    EOF
    $ goreman start







