---
title: lager实战2:写文件、写kafka的性能测试
date: 2018-11-21 13:22:09
categories:
- tune
tags:
- erlang
- tune
- lager
- kafka
---
参考项目:

    https://github.com/klarna/brod
    https://github.com/erlang-lager/lager
    http://kafka.apache.org
    https://github.com/newforks/lager_kafka_backend


测试目的:

    项目使用lager写日志时，如果日志量非常大，会导致消息队列堆积，进而引起更严重的问题,
    于是想着增加一kafka的backend:
      一是为了把所有日志合并在一起
      二是为了增加写入效率

测试对比:

    1. 测试file写入文件中带delayed_write与不带的性能对比
    2. 测试brod写kafka与file写入的性能对比
    3. 测试lager_kafka_backend与lager_file_backend的性能对比

测试内容:

    写入数据: <<"123456789qwertyuiopasdfghjklzxcvbnm">>
    执行Module:loop(Times, Num).
    其中:
      Times: 为执行次数
      Num: 每次执行写入数据次数

代码实例:

    1. 普通文件写入: 
    https://github.com/zhaoweiguo/demo-erlang/blob/6829ca950f2ea16859d3be23a1396aa3d1fdaf2d/apps/demo_lager/src/speed_file.erl

    2. 带delayed_write文件写入:
    https://github.com/zhaoweiguo/demo-erlang/blob/6829ca950f2ea16859d3be23a1396aa3d1fdaf2d/apps/demo_lager/src/speed_delayfile.erl

    3. 普通写kafka(注:要本地启动kafka server)
    https://github.com/zhaoweiguo/demo-erlang/blob/6829ca950f2ea16859d3be23a1396aa3d1fdaf2d/apps/demo_lager/src/speed_brod.erl

    4. 通过lager写入文件
    https://github.com/zhaoweiguo/demo-erlang/blob/6829ca950f2ea16859d3be23a1396aa3d1fdaf2d/apps/demo_lager/src/speed_lager_file.erl

    5. 通过lager写入kafka
    https://github.com/zhaoweiguo/demo-erlang/blob/6829ca950f2ea16859d3be23a1396aa3d1fdaf2d/apps/demo_lager/src/speed_lager_kafka.erl

测试结果:

(demo_lager@127.0.0.1)3> speed_file:loop(20, 20).

    % 测试过程中文件写入不稳定,有时写入数据差10倍以上，原因不明
    time:384 | {0,0,384}
    time:833 | {0,0,833}
    time:2734 | {0,2,734}
    time:484 | {0,0,484}
    time:642 | {0,0,642}
    time:483 | {0,0,483}
    time:609 | {0,0,609}
    time:582 | {0,0,582}
    time:844 | {0,0,844}
    time:795 | {0,0,795}
    time:506 | {0,0,506}
    time:1125 | {0,1,125}
    time:490 | {0,0,490}
    time:599 | {0,0,599}
    time:605 | {0,0,605}
    time:444 | {0,0,444}
    time:479 | {0,0,479}
    time:415 | {0,0,415}
    time:421 | {0,0,421}
    time:577 | {0,0,577}


(demo_lager@127.0.0.1)4> speed_delayfile:loop(20, 20).

    time:39 | {0,0,39}
    time:98 | {0,0,98}
    time:78 | {0,0,78}
    time:86 | {0,0,86}
    time:83 | {0,0,83}
    time:149 | {0,0,149}
    time:51 | {0,0,51}
    time:461 | {0,0,461}
    time:85 | {0,0,85}
    time:58 | {0,0,58}
    time:56 | {0,0,56}
    time:108 | {0,0,108}
    time:60 | {0,0,60}
    time:87 | {0,0,87}
    time:62 | {0,0,62}
    time:58 | {0,0,58}
    time:151 | {0,0,151}
    time:417 | {0,0,417}
    time:75 | {0,0,75}
    time:109 | {0,0,109}


(demo_lager@127.0.0.1)14> speed_brod:loop(20, 20).

    time:2900 | {0,2,900}
    time:229 | {0,0,229}
    time:243 | {0,0,243}
    time:293 | {0,0,293}
    time:971 | {0,0,971}
    time:191 | {0,0,191}
    time:183 | {0,0,183}
    time:607 | {0,0,607}
    time:253 | {0,0,253}
    time:256 | {0,0,256}
    time:233 | {0,0,233}
    time:257 | {0,0,257}
    time:145 | {0,0,145}
    time:195 | {0,0,195}
    time:175 | {0,0,175}
    time:135 | {0,0,135}
    time:197 | {0,0,197}
    time:189 | {0,0,189}
    time:166 | {0,0,166}
    time:200 | {0,0,200}


(demo_lager@127.0.0.1)15> speed_lager_kafka:loop(20, 20).

    time:136 | {0,0,136}
    time:176 | {0,0,176}
    time:203 | {0,0,203}
    time:198 | {0,0,198}
    time:161 | {0,0,161}
    time:161 | {0,0,161}
    time:192 | {0,0,192}
    time:141 | {0,0,141}
    time:229 | {0,0,229}
    time:235 | {0,0,235}
    time:253 | {0,0,253}
    time:247 | {0,0,247}
    time:189 | {0,0,189}
    time:201 | {0,0,201}
    time:150 | {0,0,150}
    time:189 | {0,0,189}
    time:153 | {0,0,153}
    time:235 | {0,0,235}
    time:161 | {0,0,161}
    time:176 | {0,0,176}


(demo_lager@127.0.0.1)18> speed_lager_file:loop(20, 20).

    time:189 | {0,0,189}
    time:192 | {0,0,192}
    time:233 | {0,0,233}
    time:277 | {0,0,277}
    time:177 | {0,0,177}
    time:183 | {0,0,183}
    time:179 | {0,0,179}
    time:290 | {0,0,290}
    time:218 | {0,0,218}
    time:208 | {0,0,208}
    time:215 | {0,0,215}
    time:256 | {0,0,256}
    time:263 | {0,0,263}
    time:287 | {0,0,287}
    time:238 | {0,0,238}
    time:294 | {0,0,294}
    time:226 | {0,0,226}
    time:276 | {0,0,276}
    time:195 | {0,0,195}
    time:332 | {0,0,332}


结论:

    1.直接写文件，加不加buffer影响很大
    2.直接写kafka，比不加buffer的快，但比加buffer的慢
    3.通过lager_file_backend与通过lager_kafka_backend性能差别不大
    4.通过lager_file_backend加不加buffer，影响不大
    5.可能是虚拟机原因，磁盘写入不稳定






