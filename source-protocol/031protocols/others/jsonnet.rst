jsonnet
#######

* 官网 [1]_

* Jsonnet是Google开源的一门配置语言，用于弥补JSON所暴露的短板，它完全兼容JSON，并加入了JSON所没有的一些特性，包括注释、引用、算数运算、条件操作符、数组和对象深入、引入函数、局部变量、继承等，Jsonnet程序被编译为兼容JSON的数据格式。简单来说Jsonnet就是增强版JSON。

安装
====

mac::

    $ brew install jsonnet

pip::

    $ pip install jsonnet


Go安装::

    $ go get github.com/google/go-jsonnet/cmd/jsonnet



JSON的应用场景跟缺陷
====================

JSON是一种轻量级的数据交换格式，是基于ECMAScript的一个子集，采用完全独立于语言的文本格式，同时也是用了类C的习惯，JSON在各语言间支持友好，可读性强，数据性能比XML好，所以JSON成为目前非常广泛的数据交换格式。

使用场景::

    前后端数据交互
    各语言之间的数据交互
    应用的配置文件

缺陷::

    不能加注释
    对象或数组最后一项后面不能有逗号
    不支持变量、函数
    不能用算数和逻辑运算
    不能划分，复用，文件隔离
    key必须加双引号
    value为字符时必须用双引号

Jsonnet对这些缺陷做了弥补，key的双引号不是必须，对象和数组最后一个属性可以有逗号，支持注释，支持算数运算等等

.. image:: /images/protocols/jsonnet_json1.svg




Jsonnet使用
===========

::

    $ echo "{key: 1+2}" > test.jsonnet
    $ jsonnet test.jsonnet
    {
       "key": 3
    }

# 对于简单的代码也可以使用 -e 直接运行::

    $ jsonnet -e '{key: 1+2}'
    {
       "key": 3
    }

# format 源码文件::

    $ jsonnet fmt test.jsonnet


Jsonnet实例
===========

注释(Jsonnet支持单行或多行注释)::

    /* This is demo comment*/
    { //This comment show for test
        key1:{
            "tom":[
                {kind:"man",test:1.0},
            ]
        }
    }

引用(Jsonnet中可以通过self引用当前对象，$引用根对象)::

    {
        test:{
            data:"data1",
            data2: self.data
        },
        test1:{
            data:$.test.data
        }
    }

数据操作(支持逻辑运算与算数运算)::

    {
        foo:4,
        bar: 2*self.foo,
        bar2:"this value is "+ self.bar+".",
        arrays:[1,2,3]+[4,5],//拼接
        equal: 1== 2
    }

数组和对象深入::

    {
        foo:[1,2,3],
        bar:[x*x for x in self.foo if x>=2],
        bar2:{["field"+x]: x for x in self.foo},
        obj:{["foo"+"bar"]:3},
    }

模块化::

    Jsonnet文件可进行拆分，拆分成多个小文件，每个文件里又是一个Jsonnet对象，通过import进行引入使用

函数::

    //函数demo
    {
        qual_demo(size,value)::
          if std.length(value) == 0 then
            error "no data"
          else [
                {kind: i,data: size/std.length(value)}
                for i in value
          ]
        id:: function(x) x,
    }

    // 实例
    local Person(name='Alice') = {
      name: name,
      welcome: 'Hello ' + name + '!',
    };
    {
      person1: Person(),
      person2: Person('Bob'),
    }

变量::

    //变量demo
    {
        local my_data = "data",
        data:{
            demo:my_data
        }
    }

面向对象继承::

    {
        demo:{
            data:"data1",
        },
        demo2: self["demo"]+{
            data2:"hello"
        }
    }

OtherFormat(非json格式)::

    local application = 'my-app';
    local module = 'uwsgi_module';
    local dir = '/var/www';
    local permission = 644;

    {
      'uwsgi.ini': std.manifestIni({
        sections: {
          uwsgi: {
            module: module,
            pythonpath: dir,
            socket: dir + '/uwsgi.sock',
            'chmod-socket': permission,
            callable: application,
            logto: '/var/log/uwsgi/uwsgi.log',
          },
        },
      }),

      'init.sh': |||
        #!/bin/bash
        mkdir -p %(dir)s
        touch %(dir)s/initialized
        chmod %(perm)d %(dir)s/initialized
      ||| % {dir: dir, perm: permission},

      'cassandra.conf': std.manifestYamlDoc({
        cluster_name: application,
        seed_provider: [
          {
            class_name: 'SimpleSeedProvider',
            parameters: [{ seeds: '127.0.0.1' }],
          },
        ],
      }),
    }

    =>

    {
       "cassandra.conf": "\"cluster_name\": \"my-app\"\n\"seed_provider\":\n- \"class_name\": \"SimpleSeedProvider\"\n  \"parameters\":\n  - \"seeds\": \"127.0.0.1\"",
       "init.sh": "#!/bin/bash\nmkdir -p /var/www\ntouch /var/www/initialized\nchmod 644 /var/www/initialized\n",
       "uwsgi.ini": "[uwsgi]\ncallable = my-app\nchmod-socket = 644\nlogto = /var/log/uwsgi/uwsgi.log\nmodule = uwsgi_module\npythonpath = /var/www\nsocket = /var/www/uwsgi.sock\n"
    }



Jsonnet 使用场景
================

* `kubecfg <https://github.com/bitnami/kubecfg>`_: 使用 jsonnet 生成 kubernetes API 对象 并 apply
* `ksonnet-lib <https://github.com/ksonnet/ksonnet-lib>`_: 一个 jsonnet 的库, 用于生成 kubernetes API 对象(在 hepstio 被 IBM 收购之后 IBM 放弃了 ksonnet 这个项目)
* `kube-prometheus <https://github.com/coreos/prometheus-operator/tree/master/contrib/kube-prometheus>`_: 使用 jsonnet 生成 Prometheus-Operator, Prometheus, Grafana 以及一系列监控组件的配置
* `grafonnet-lib <https://github.com/grafana/grafonnet-lib/tree/master/grafonnet>`_: 一个 jsonnet 的库, 用于生成 json 格式的 Grafana 看板配置

* `jsonnet-lib <https://github.com/grafana/grafonnet-lib>`_: Grafana 内部使用的 jsonnet-libs, 包含各种配置的管理
* `jsonnet-style-guide <https://github.com/databricks/jsonnet-style-guide>`_: Databricks 的 jsonnet 风格指南, 里面还讲了 databricks 是怎么使用 jsonnet 的


参考
====

* https://zhuanlan.zhihu.com/p/61660797









.. [1] https://jsonnet.org/