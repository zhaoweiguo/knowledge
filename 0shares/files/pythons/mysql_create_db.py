#!/usr/bin/env python  
# -*- coding=utf-8   -*-
##################################  
#MySQLdb 示例  
#  
##################################  

import MySQLdb  
  
#建立和数据库系统的连接  
conn = MySQLdb.connect(host='localhost', user='root',passwd='longforfreedom')  
  
#获取操作游标  
cursor = conn.cursor()  
#执行SQL,创建一个数据库.  
cursor.execute("""create database python """)  
  
#关闭连接，释放资源  
cursor.close();  


