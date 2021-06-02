#!/usr/bin/env python
#coding=utf-8
######################################
#
# MySQLdb 查询
#
#######################################

import MySQLdb

conn = MySQLdb.connect(host='localhost', user='root', passwd='longforfreedom',db='python')

cursor = conn.cursor()

count = cursor.execute('select * from test')

print '总共有 %s 条记录',count

#获取一条记录,每条记录做为一个元组返回
print "只获取一条记录:"
result = cursor.fetchone();
print result
#print 'ID: %s   info: %s' % (result[0],result[1])
print 'ID: %s   info: %s' % result 

#获取5条记录，注意由于之前执行有了fetchone()，所以游标已经指到第二条记录了，也就是从第二条开始的所有记录
print "只获取5条记录:"
results = cursor.fetchmany(5)
for r in results:
    print r

print "获取所有结果:"
#重置游标位置，0,为偏移量，mode＝absolute | relative,默认为relative,
cursor.scroll(0,mode='absolute')
#获取所有结果
results = cursor.fetchall()
for r in results:
    print r
conn.close()
