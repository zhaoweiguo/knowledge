安装dotdeb更新源5.6版
=========================

1、在/etc/apt/sources.list增加两行::

  deb http://packages.dotdeb.org squeeze all
  deb-src http://packages.dotdeb.org squeeze all

2、（可选）如果要安装PHP5.4在Debian6.0，可以添加如下两行::

  deb http://packages.dotdeb.org squeeze-php56 all
  deb-src http://packages.dotdeb.org squeeze-php56 all

3、获得GnuPG key::

  wget http://www.dotdeb.org/dotdeb.gpg
  cat dotdeb.gpg | sudo apt-key add -   // 注意这儿的-要是英文符号

4、运行 ``apt-get update``

5、最后就可以使用::

  apt-get（dselect或aptitude命令）使用dotdeb的软件包


