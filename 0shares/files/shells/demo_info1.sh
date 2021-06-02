#!/bin/bash

###########################
# 创建ssh远程登录欢迎词
###########################


# =======================
# CPU相关
# =======================
# cpu个数
nu1=`cat /proc/cpuinfo |grep processor|sed '$!d'|awk '{print $3}'`
let "nu=($nu1+1)"
# cpu名称
cupname=`cat /proc/cpuinfo |grep "model name"|sed '$!d'|awk '{print $4 " " $5 " " $7}'`
# 修改欢迎界面
echo cat   /proc/cpuinfo $cupname x$nu >> /etc/motd

# 修改对应nginx配置文件
let "nginxprocesses=($nu*2)"
    sed -i "s@worker_processes 4@worker_processes [url=mailtonginxprocesses@g]$nginxprocesses@g[/url]" /data/conf/nginx/nginx.conf

# =======================
# memory相关
# =======================

Free=`free -m |grep Mem |awk '{print $2}'`
echo cat /proc/meminfo   MemTotalFree MB >> /etc/motd

# =======================
# 磁盘信息
# =======================
fdisk -l|grep "Disk"|awk '{print $1 " " $2 " " $3 " " $4}'|sed 's/,/ /g' >> /etc/motd
echo 'df -lhT' >> /root/.bash_profile
    