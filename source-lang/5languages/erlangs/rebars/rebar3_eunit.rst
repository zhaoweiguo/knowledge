.. _rebar3_eunit:

rebar3 eunit
#####################
Rebar3 has built in eunit and ct (common_test) test runners

Eunit
--------
::

  $ rebar3 eunit

  如果定义了宏的:{d, TEST, true} and {d, EUNIT, true}, 
  rebar3会编译所有项目模块，你可以使用-ifdef(TEST). or -ifdef(EUNIT)隐藏测试代码
  如果存在test目录,它会自动编译里面所有代码。

  最后为每个app调用eunit:test([{application, App}]
  如果你想更改eunit:test/1的参数，可以修改rebar.conf文件的eunit_tests


限制测试::

  % 指定apps
  $ rebar3 eunit --application=some_app,some_other_app

  % 指定modules
  $ rebar3 eunit --module=a,b,c

  % 指定test files
  $ rebar3 eunit --file="test/my_tests.erl"

  % 指定directories
  $ rebar3 eunit --dir="test"



Common Test
----------------
::

  $ rebar3 ct
  % rebar3会查找所有app的test目录，并编译运行*_SUITE.erl源码

限制测试::

  % 指定suites
  $ rebar3 ct --suite=test/first_SUITE,test/second_SUITE

帮助::

  $ rebar3 help ct


Code Coverage
-----------------
说明::

  1.设定{cover_enabled, true}
  2.运行
    rebar3 eunit --cover 
    or
    rebar3 ct --cover
  3.说明
    1.生成cover data: .coverdata类型文件
    2.运行rebar3 cover

.coverdata文件::

  eunit.coverdata
  ct.coverdata

可使用--cover_export_name指定.coverdata文件名::

  $ rebar3 ct --dir test/suites1 --cover --cover_export_name=suites1
  ===> Running Common Test suites...
  ...
  $ rebar3 ct --dir test/suites2 --cover --cover_export_name=suites2
  ===> Running Common Test suites...
  ...
  $ ls _build/test/cover
  cover.log    suite1.coverdata    suite2.coverdata
  $ rebar3 cover --verbose
  ===> Performing cover analysis...
    |----------------------------|------------|
    |                    module  |  coverage  |
    |----------------------------|------------|
    |                     ....   |       Y%   |
    |----------------------------|------------|
    |                     total  |       X%   |
    |----------------------------|------------|
    coverage calculated from:
      _build/test/cover/suites1.coverdata
      _build/test/cover/suites2.coverdata
    cover summary written to: _build/test/cover/index.html








