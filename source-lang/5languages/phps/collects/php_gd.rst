.. _php_gd:

php的GD库(用于验证码)
========================

* What is the GD library?

    GC is an open source code library for the dynamic creation of images by programmers. GC is written in C, and "wrappers" are available for PHP、 Perl and other lanaguages. GD creates PNG, JPEG and GIF images, among other formats. GD is commonly used to generate charts, graphics, thumbnails, and most anything else, on the fly. While not restricted to use on the web, the most common applications of GD involve website development.


* 注意:
    这儿是源码安装，也可以是不是源码安装，直接安装这几个库就好了，应该是都需要安装dev的！

一、下载 

* gd-2.0.33.tar.gz http://www.boutell.com/gd/ 
* jpegsrc.v6b.tar.gz http://www.ijg.org/ 
* libpng-1.2.7.tar.tar http://sourceforge.net/projects/libpng/ 
* zlib-1.2.2.tar.gz http://sourceforge.net/projects/zlib/ 
* freetype-2.1.9.tar.gz http://sourceforge.net/projects/freetype/ 
* php-4.3.9.tar.gz http://www.php.net 


二、安装 

1. 安装zlib::

    tar zxvf zlib-1.2.2.tar.gz 
    cd zlib-1.2.2 
    ./configure 
    make 
    make install 

2. 安装libpng::

    tar zxvf libpng-1.2.7.tar.tar 
    cd libpng-1.2.7 
    cd scripts/ 
    mv makefile.linux ../makefile 
    cd .. 
    make 
    make install
    注意:这里的makefile不是用./configure生成，而是直接从scripts/里拷一个 

3. 安装freetype::

    tar zxvf freetype-2.1.9.tar.gz 
    cd freetype-2.1.9 
    ./configure 
    make 
    make install 

4. 安装Jpeg::

    tar zxvf jpegsrc.v6b.tar.gz 
    cd jpeg-6b/ 
    ./configure --enable-shared 
    make 
    make test 
    make install 
    注意:这里configure一定要带--enable-shared参数，不然，不会生成共享库 

5. 安装GD::

    tar zxvf gd-2.0.33.tar.gz 
    cd gd-2.0.33 
    ./configure --with-png --with-freetype --with-jpeg 
    make install 

6. 重新编译PHP::

    tar zxvf php-4.3.9.tar.gz 
    cd php-4.3.9 
    // 下面的参数好像有点问题，但暂能解决问题
    ./configure (以前的参数) --with-gd --enable-gd-native-ttf --with-zlib --with-png --with-jpeg --with-freetype --enable-sockets
    make
    make install

7. 查看情况::

    <?php 
    phpinfo(); 
    ?> 
