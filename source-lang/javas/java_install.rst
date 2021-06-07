.. _java_install:

java安装、编译
###################

java8环境安装
---------------
* 首先在 `Oracle官网 <https://www.oracle.com/index.html>`_ 下载java8的linux-64安装包:jdk-8u181-linux-x64.tar.gz

* 创建目录::

    $ mkdir -p /opt/java
    $ tar -zxvf jdk-8u181-linux-x64.tar.gz -C /opt/java/
    ​$ sudo vim /etc/profile
        #set java environment
        export JAVA_HOME=/opt/java/jdk1.8.0_181
        export PATH=${JAVA_HOME}/bin:${PATH}
    $ source /etc/profile


java7环境安装
-----------------
::

   apt-get install  openjdk-7-jdk tomcat7


javac命令
------------

格式为::

    javac [options]  [sourcefiles] [@files]

命令行选项::

    options:命令行选项；
    sourcefiles:一个或多个要编译的源文件
    @files:一个或多个对源文件进行列表的文件,有时候要编译的文件很多,一个个敲命令会显得很长,也不方便修改,可以把要编译的源文件列在文件中,在文件名前加@,这样就可以对多个文件进行编译,对编译一个工程很有用,方便,省事

有几个比较重要的选项::

    -d 用于指定编译成的class文件的存放位置,缺省情况下不指定class文件的存放目录,编译的class文件将和源文件在同一目录下
    -classpath 可以简写成-cp,用于搜索编译所需的class文件,指出编译所用到的class文件的位置,如jar、zip或者其他包含class文件的目录,指定该选项会覆盖CLASSPATH的设定；
    -sourcepath用于搜索编译所需的源文件(即java文件), 指定要搜索的源文件的位置, 如jar、zip或其他包含java文件的目录

需要注意windows下和linux下文件路径分隔符和文件列表（即-classpath和-sourcepath指定的文件）分隔符的区别::

    windows下文件路径分隔符用 \ ，文件列表分隔符用分号 ;
    linux下文件路径分隔符用 / ，文件列表分隔符用冒号 



java命令
------------

格式如下::

    java [options] classfile

命令行选项::

    options:一般用于 -classpath 指定要执行的文件所在的位置以及需要用到的类路径，包括jar、zip和class文件目录，会覆盖CLASSPATH的设定




实例
---------

编译实例::

    #!/bin/sh
    # 定义常量
    PRO_SERVER=<project_name>
    PROJECT_PATH=/home/gordon/project   #项目路径
    JAR_PATH=$PROJECT_PATH/lib          #jar包路径
    BIN_PATH=$PROJECT_PATH/bin          #bin路径
    SRC_PATH=$PROJECT_PATH/src/$PRO_SERVER       #src路径

    # 如果存在sources.list文件，先删除再重新创建
    rm -f $SRC_PATH/sources.list
    find $SRC_PATH -name *.java > $SRC_PATH/sources.list

    # 如果存在bin目录，先删除再重新创建
    rm -rf $BIN_PATH/$PRO_SERVER
    mkdir $BIN_PATH/$PRO_SERVER

    # 编译项目
    javac -d $BIN_PATH/$PRO_SERVER -classpath $JAR_PATH/<jar1>.jar:$JAR_PATH/<jar2>.jar @$SRC_PATH/sources.list


运行实例::

    #!/bin/sh
    # 定义常量
    PRO_SERVER=<project_name>
    PROJECT_PATH=/home/gordon/project
    JAR_PATH=$PROJECT_PATH/lib
    BIN_PATH=$PROJECT_PATH/bin

    # 使用后台进程运行些项目
    nohup java -classpath $BIN_PATH:$JAR_PATH/<jar1>.jar:$JAR_PATH/<jar2>.jar com.<project>.<www> &


最简单实例::

    mkdir -p com/xinxi/www
    mkdir classes
    //编辑文件Hello.java
    package com.Javasoft;
    public class Hello{
        public static void main(String[] args){
            System.out.println("Hi ？");
        }
    }
    //编译
    javac -d classes com/xinxin/www/Hello.java
    //运行
    java com.xinxi.www.Hello



