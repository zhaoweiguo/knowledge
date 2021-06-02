#!/bin/sh

cd /data/backup/mysql;
Folder=backup_`date "+%y%m%d-%H%M"`;
mkdir $Folder;
cd $Folder;
mysqldump -uadmin -pq1w2e3r4 --database wordpress > blog.sql;
mysqldump -uadmin -pq1w2e3r4 --database ultrax > bbs.sql;
mysqldump -uadmin -pq1w2e3r4 --database wprelay > relay.sql;
mysqldump -uadmin -pq1w2e3r4 --database wpfinancial > finance.sql;
mysqldump -uadmin -pq1w2e3r4 --database wpdiary > diary.sql;
mysqldump -uadmin -pq1w2e3r4 --database wplele > lele.sql;
cd ..;
tar zcf $Folder.tar.gz $Folder;
rm -rf $Folder;

/usr/local/bin/sendEmail -f gordonsendmail@163.com \
    -t xinxishangwang@163.com \
    -s smtp.163.com \
    -xu gordonsendmail@163.com \
    -xp q1w2e3r4 \
    -l ./sendmail.log \
    -o message-charset=utf-8 \
    -u "[数据库备份]$Folder" \
    -m "备份数据" \
    -o timeout=500 \
    -a ./$Folder.tar.gz \
    -o tls=yes;

