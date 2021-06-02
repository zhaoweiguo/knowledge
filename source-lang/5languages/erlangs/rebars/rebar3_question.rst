rebar常见问题
##################
.. index:: question, rebar, erlang

rebar转rebar3时erldydtl不编译问题::

  说明: 此事发重现象很诡异
     我在测试时,一直都没有问题,但9.29上线pvt发现网站打不开
     好像其他部门反应系统也出现了问题,于是急急停了
     当我在测试机重复上线的步骤时也出现了同样的问题
     很是奇怪,测试时一直没有发现
     于是,转而处理erlydtl的问题,于是发现rebar设置的hook不可用了
      {provider_hooks, [  %% hook钩子
        {post, [{compile, {erlydtl, compile}}]}
      ]}.
      手工执行rebar3 erlydtl compile后好了,但使用
      {% extends "base.dtl" %}时
      在base.dtl文件里的
      {% load erlydtl_custom_tags %}
      {% rendMenuPage user %}
      没有执行
  奇怪的是:
    新建的项目用同样的rebar.config就没有问题
  进展:
    1.我在另一机器上重新clone项目时,编译运行就没有问题
    2.我在同一机器上重新clone项目时,编译运行也没有问题

    于是我找2边的不同,从rebar转到rebar3有多几个文件
    1.deps/
    2.ebin/
    当我把此2目录移走再运行,就好了
  原因:
    1.erlydtl在编译时如果有此beam文件就不再编译
    2.erlydtl默认增加当前目录的ebin目录


修改deps项目中的文件不编译::

  直接修改_build/default/lib目录中项目的源文件
  在顶层make,默认不编译
  rebar3就是这样,我认为也是合理的
  解决办法:
  1.1 删除对应的beam文件,重新编译
  1.2 走一遍升级流程


deps项目lager_transform没有执行::

  原因:
  需要在用lager的deps项目中增加rebar.config文件
  并加上:
  {erl_opts, [
    {parse_transform, lager_transform}
  ]}.





