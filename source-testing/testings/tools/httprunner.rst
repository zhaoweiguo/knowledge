HttpRunner [1]_
###############

Convention over configuration
=============================

*  each project should and could only have one debugtalk.py file




生成项目
========

::

    $ httprunner startproject demo


Record & Generate testcase
==========================

1. export sessions to HAR file: xxx.har
2. generate testcase (pytest)::

    // 生成单元测试文件
    $ har2case har/xxx.har

    // 运行
    $ hrun har/xxx_test.py  
    or
    $ pytest har/xxx_test.py 

2'. generate testcase (YAML/JSON)::

    // 生成json文件
    $ har2case har/xxx.har -2j
    // 运行
    $ hrun har/xxx.json 

$ har2case -h::

    usage: har2case [-h] [-2y] [-2j] [--filter FILTER]
                             [--exclude EXCLUDE]
                             [har_source_file]

    positional arguments:
      har_source_file       Specify HAR source file

    optional arguments:
      -h, --help            show this help message and exit
      -2y, --to-yml, --to-yaml
                            Convert to YAML format
      -2j, --to-json        Convert to JSON format



Run Testcase
============

run testcases in diverse ways::

    $ hrun path/to/testcase1
    $ hrun path/to/testcase1 path/to/testcase2
    $ hrun path/to/testcase_folder/

run YAML/JSON testcases::

    hrun = convert + pytest

    先把 YAML/JSON 转换为 pytest文件
    再执行pytest命令

    实例: 
    // -s (shortcut for --capture=no).
    $ hrun -s examples/postman_echo/request_methods/request_with_functions.yml



Testing Report
==============

builtin html report::

    $ hrun /path/to/testcase --html=report.html
    or
    $ hrun /path/to/testcase --html=report.html --self-contained-html


allure report::

    // 先安装
    $ pip3 install "allure-pytest"

    // 运行得到结果
    $ hrun /path/to/testcase --alluredir=/tmp/my_allure_results

    // 使用 allure 命令察看
    $ allure serve /tmp/my_allure_results









.. [1] https://docs.httprunner.org/