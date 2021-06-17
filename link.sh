#!/bin/bash

items=(architecture around assist cloudnative db devops key lang manager newtech normal open protocol secure sys testing theory tool tune);
shares=(_static _themes images files conf.py plantuml.jar);

my_usage() {
  echo "-----------------用法-----------------------"
  echo "1. 建立/取消全部链接"
  echo "  ./link.sh on"
  echo "  ./link.sh off"
  echo "2. 建立/取消指定链接"
  echo "  ./link.sh on xxx"
  echo "  ./link.sh off xxx"
  echo "    可用 xxx 选项有:"
  echo "    ${items[@]}"
  echo "-----------------end-----------------------"
}

my_begin() {
  echo "--------------link.sh started--->"
  echo
}

my_end() {
  echo
  echo "--------------link.sh ended--->"
}

my_do_links() {
  echo "$1--->[$2]"
  cd source-$2
  my_do_link $1
  cd ..
}

my_do_link() {
  for share in ${shares[@]}
  do
    my_do_link2 $1
  done
}
my_do_link2() {
  if test $1 = "on"; then
    ln -s ../0shares/$share .
    return
  fi
  if test $1 = "off"; then
    rm $share
    return
  fi
}


my_begin
if test -z $1; then
  my_usage
  exit
fi

# 1. 单个操作
if ! test -z $2; then
  my_do_links $1 $2
  my_end
  exit
fi

# 2. 全部操作
for item in ${items[@]}
do
  my_do_links $1 $item
done

my_end
