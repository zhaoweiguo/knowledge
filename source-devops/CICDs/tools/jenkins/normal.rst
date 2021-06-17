常用
#########

* 官网 [1]_
* github [2]_

::

    java -jar jenkins.war --httpPort=8080

    java -Duser.home=/opt/manager/projects/blueocean -jar /opt/manager/projects/blueocean/jenkins/jenkins.war --httpPort=9292

docker::

    docker pull jenkins/jenkins
    docker run -p 8080:8080 -p 50000:50000 jenkins/jenkins

    // lts版本
    docker run -p 8080:8080 -p 50000:50000 jenkins/jenkins:lts


docker实例 [3]_
======================
启动::

  docker run \
    --rm \
    -u root \
    -p 8080:8080 \
    -v jenkins-data:/var/jenkins_home \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v "$HOME":/home \
    --name jenkins \
    jenkinsci/blueocean

进入docker::

    docker exec -it jenkins bash


流水线语法
===============

* 声明式流水线::

    Jenkinsfile (Declarative Pipeline)
    pipeline {
        agent any 
        stages {
            stage('Build') { 
                steps {
                    // 
                }
            }
            stage('Test') { 
                steps {
                    // 
                }
            }
            stage('Deploy') { 
                steps {
                    // 
                }
            }
        }
    }

* 脚本化流水线::

    Jenkinsfile (Scripted Pipeline)
    node {  
        stage('Build') { 
            // 
        }
        stage('Test') { 
            // 
        }
        stage('Deploy') { 
            // 
        }
    }



执行环境
=============

agent指令
-----------

* agent 指令告诉Jenkins在哪里以及如何执行Pipeline或者Pipeline子集。 正如您所预料的，所有的Pipeline都需要 agent 指令
* 在执行引擎中，agent 指令会引起以下操作的执行::

    所有在块block中的步骤steps会被Jenkins保存在一个执行队列中,一旦一个执行器executor是可以利用的,这些步骤将会开始执行
    一个工作空间 workspace 将会被分配， 工作空间中会包含来自远程仓库的文件和一些用于Pipeline的工作文件

处理 Jenkinsfile
---------------------

参数::

    Jenkinsfile (Declarative Pipeline)
    pipeline {
        agent any
        parameters {
            string(name: 'Greeting', defaultValue: 'Hello', description: 'How should I greet the world?')
        }
        stages {
            stage('Example') {
                steps {
                    echo "${params.Greeting} World!"
                }
            }
        }
    }

使用环境变量::

    Jenkinsfile (Declarative Pipeline)
    pipeline {
        agent any
        stages {
            stage('Example') {
                steps {
                    echo "Running ${env.BUILD_ID} on ${env.JENKINS_URL}"
                }
            }
        }
    }

设置环境变量::

    Jenkinsfile (Declarative Pipeline)
    pipeline {
        agent any
        environment { 
            CC = 'clang'    // 全局可用
        }
        stages {
            stage('Example') {
                environment { 
                    DEBUG_FLAGS = '-g'  // 只适用于`stage`中的步骤
                }
                steps {
                    sh 'printenv'
                }
            }
        }
    }








.. [1] https://jenkins.io/zh/
.. [2] https://github.com/jenkinsci
.. [3] https://jenkins.io/zh/doc/tutorials/build-a-java-app-with-maven/


