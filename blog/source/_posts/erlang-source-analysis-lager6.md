---
title: 开源项目lager6-写一个lager的kafka插件
date: 2018-11-09 09:19:11
categories:
- source-analysis
tags:
- erlang
- source-analysis
- lager
---

配置文件:

    [
     {handlers,[{lager_kafka_backend,[
                  {level,                         "info"},
                  {topic,                         <<"topic">>},
                  {broker,                        [{"localhost", 9092}]},
                  {send_method,                   async},
                  {formatter,                     lager_default_formatter},
                  {formatter_config,
                    [date, " ", time, "|", node, "|",severity,"|", module, "|", function, "|", line, "|", pid, "|", message]
                  }     
               ]}]
      }
    ]

<!--more-->

文件lager_kafka_backend.erl:

    上面的配置文件指定文件名为:lager_kafka_backend.erl
    实现一个gen_event，详见后面几个函数说明

init/1函数:

    参数就是上面配置文件中的值,作用是把相关信息存放到state中,
    启动brod,配置好kafka信息

handle_call/2函数:

    要实现set_loglevel和get_loglevel相关功能

handle_event/2函数:

    接收{log, Message}
    其中Message为info:log函数执行时的数据和meta信息
    执行brod的写入kafka函数


config_to_id/1函数:

    可选
    多id时用,如:lager_file_backend
    主要用于多个gen_event事件
    









