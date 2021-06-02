maven项目
##############

maven安装::

    $ wget http://mirrors.hust.edu.cn/apache/maven/maven-3/3.1.1/binaries/apache-maven-3.1.1-bin.tar.gz
    $ tar zxf apache-maven-3.1.1-bin.tar.gz
    $ mv apache-maven-3.1.1 /usr/local/maven3

    $ vi /etc/profile
    export M2_HOME=/usr/local/maven3
    export PATH=$PATH:$JAVA_HOME/bin:$M2_HOME/bin
    $ source /etc/profile
    // 验证
    $ mvn -v


使用命令::

  % 默认要有pom.xml文件
  mvn install

打包命令::

    mvn clean package
    ## 或者执行下面的命令
    ## 排除测试代码后进行打包
    mvn clean package  -Dmaven.test.skip=true


仓库位置::

    % 默认仓库位置:
    ~/.m2/repository

    % 修改仓库位置
    % 修改Maven安装目录下的conf子目录中settings.xml，添加一条下面的语句
    <localRepository>/data/.m2/repository</localRepository>

添加中央仓库的镜像::

    <mirror>    
        <!--This sends everything else to /public -->
        <id>nexus</id>
        <mirrorOf>*</mirrorOf>
        <url>http://maven.aliyun.com/nexus/content/groups/public/</url>
    </mirror>
    <mirror>
          <!--This is used to direct the public snapshots repo in the 
              profile below over to a different nexus group -->
          <id>nexus-public-snapshots</id>
          <mirrorOf>public-snapshots</mirrorOf> 
          <url>http://maven.aliyun.com/nexus/content/repositories/snapshots/</url>
    </mirror>



pom.xml实例::

    <project>
      <modelVersion>4.0.0</modelVersion>

      <groupId>sample.plugin</groupId>
      <artifactId>hello-maven-plugin</artifactId>
      <version>1.0-SNAPSHOT</version>
      <packaging>maven-plugin</packaging>

      <name>Sample Parameter-less Maven Plugin</name>

      <dependencies>
        <dependency>
          <groupId>org.apache.maven</groupId>
          <artifactId>maven-plugin-api</artifactId>
          <version>2.0</version>
        </dependency>

        <!-- dependencies to annotations -->
        <dependency>
          <groupId>org.apache.maven.plugin-tools</groupId>
          <artifactId>maven-plugin-annotations</artifactId>
          <version>3.4</version>
          <scope>provided</scope>
        </dependency>
      </dependencies>
    </project>






