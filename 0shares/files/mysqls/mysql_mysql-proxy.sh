#!/bin/bash
mode=$1
if [ -z "$mode" ] ; then
mode="start"
fi
case $mode in

start)
mysql-proxy --defaults-file=/etc/mysql-proxy.cnf>/usr/local/proxy-mysql/cn.log &
;;

stop)
killall -9 mysql-proxy
;;

restart)
if $0 stop ; then
$0 start
else
echo  "Restart failed!"
exit 1
fi
;;
esac
exit 0