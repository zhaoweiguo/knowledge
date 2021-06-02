#!/bin/sh
#============说明===============
# 此脚本是用于解决多个系统环境配置文件不同的问题
#==============================

usage() {
  echo "-----------------用法-----------------------"
  echo "参数1: octopus结点名"
  echo "参数2: app, pvt, dev, pr。分别代表4个环境."
  echo "其他:"
  echo "\t1.配置文件会使用config/pr_octopus.config"
  echo "\t2.会生成start.sh文件,可直接执行"
  echo "-----------------实例-----------------------"
  echo "sh> ./gen_start.sh octopus@10.140.2.17 pr"
  echo "-----------------end-----------------------"
}

if test -z $1 | test -z $2; then
  usage
  exit
fi

if !(test $2 = "app" || test $2 = "pvt" || test $2 = "dev" || test $2 = "pr"); then
    usage
    exit
fi


cat gen_start.tpl | sed "s/{{NAME}}/$1/g" | sed "s/{{CONFIG}}/$2/g" > start.sh
chmod +x start.sh
