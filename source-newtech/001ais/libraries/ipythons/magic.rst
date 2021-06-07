.. _ipython_magic:

魔法命令 [3]_
=============

There are two kinds of magics, line-oriented and cell-oriented::

    1. Line magics:
       prefixed with the % character and work much like OS command-line calls
    2. Cell magics:
        prefixed with a double %%, and they are functions 
            that get as an argument not only the rest of the line, 
            but also the lines below it in a separate argument.
    
    实例:
    In [1]: %timeit range(1000)
    100000 loops, best of 3: 7.76 us per loop

    In [2]: %%timeit x = range(10000)
    ...: max(x)
    ...:
    1000 loops, best of 3: 223 us per loop

The built-in magics include::

    Functions that work with code: %run, %edit, %save, %macro, %recall, etc.
    Functions which affect the shell: %colors, %xmode, %automagic, etc.
    Other functions such as %reset, %timeit, %%writefile, %load, or %paste.

时间相关::

    %timeit: 命令快速测量代码运行时间
    In [33]: %timeit range(1000)
    195 ns ± 23.1 ns per loop (mean ± std. dev. of 7 runs, 1000000 loops each)
    
    # 注意前提: import np等
    In [34]: %%timeit a = np.random.rand(100, 100)
    ...: np.linalg.eigvals(a)
    ...:
    ...:
    195 ns ± 23.1 ns per loop (mean ± std. dev. of 7 runs, 1000000 loops each)

%%capture打印相关::

    In [24]: %%capture capt
        ...: from __future__ import print_function
        ...: import sys
        ...: print('Hello stdout')
        ...: print('and stderr', file=sys.stderr)
        ...:
        ...:

    In [25]: capt.stdout, capt.stderr
        ...:
    Out[25]: ('Hello stdout\n', 'and stderr\n')

    In [27]: capt.show()
        ...:
    Hello stdout
    and stderr

%%writefile写文件相关::

    In [29]: %%writefile foo123.py
        ...: print('Hello world')
        ...:
        ...:
    
    In [36]: %run foo123
    Hello world


%lsmagic查看所有的「魔法命令」::

    In [1]: %lsmagic


%bg命令::

    In [1]: %bg function: 把function放到后台执行，例如:
    In [1]: %bg myfunc(x, y,z=1)
    之后可以用jobs将其结果取回
    myvar = jobs.result(5) 或 myvar =jobs[5].result
    另外:jobs.status() 可以查看现有任务的状态。

Background Scripts::

    实例:
    In [47]: %%ruby --bg --out ruby_lines
        ...: for n in 1...10
        ...:     sleep 1
        ...:     puts "line #{n}"
        ...:     STDOUT.flush
        ...: end
        ...:
        ...:
    In [48]: ruby_lines
    Out[48]: <_io.BufferedReader name=73>

    In [49]: print(ruby_lines.read().decode('utf8'))
        ...:
    line 1
    line 2
    line 3
    line 4
    line 5
    line 6
    line 7
    line 8
    line 9

Arguments to subcommand::

    In [51]: %%script python2 -Qnew
        ...: print 1/3
        ...:
        ...:
    0.333333333333

    In [50]: %%script --bg --out bashout bash -c "while read line; do echo $line; sleep 1; done"
        ...: line 1
        ...: line 2
        ...: line 3
        ...: line 4
        ...: line 5
        ...:
        ...:
    In [52]: import time
        ...: tic = time.time()
        ...: line = True
        ...: while True:
        ...:     line = bashout.readline()
        ...:     if not line:
        ...:         break
        ...:     sys.stdout.write("%.1fs: %s" %(time.time()-tic, line))
        ...:     sys.stdout.flush()
        ...:
    0.0s: b'line 1\n'0.0s: b'line 2\n'0.0s: b'line 3\n'0.0s: b'line 4\n'0.0s: b'line 5\n'0.0s: b'\n'


%edit编辑命令::

    %ed或%edit编辑一个文件并执行
    如果只编辑不执行，用 ed -x filename 即可。

%run命令运行脚本::

    作用:
    allows you to run any python script and load all of its data directly into the interactive namespace

    special flags:
    1. (-t): timing the execution of your scripts
    2. (-d): Python’s pdb debugger
    3. (-p): Python’s profiler

    实例:
    In [1]: %run ../utils/list_pyfiles.ipy

%debug::

    jump into the Python debugger (pdb) and examine the problem

%pdb::

    IPython will automatically start the debugger on any uncaught exception

%matplotlib::

    Set up matplotlib to work interactively.
    1. %matplotlib
        使用default matplotlib backend in a separate window
    2. %matplotlib inline
        Available only for the Jupyter Notebook and the Jupyter QtConsole.
    3. 指定使用某backend
       %matplotlib gtk    # 指定使用gtk
       %matplotlib qt
       %matplotlib TkAgg

    // You can list the available backends using the -l/--list option:
    %matplotlib --list
    Available matplotlib backends: ['osx', 'qt4', 'qt5', 'gtk3', 'notebook', 'wx', 'qt', 'nbagg',
   'gtk', 'tk', 'inline']

System shell commands::

    ! 表示执行shell命令
    如:
    !ping www.bbc.co.uk

    $将python的变量转化成shell变量

帮助命令::

    %<Cmd>?
    如:
    %matplotlib?

%script命令::

    In [38]: %%script python2
        ...: import sys
        ...: print 'hello from Python %s' % sys.version
        ...:
        ...:
    hello from Python 2.7.16 (default, Dec 13 2019, 18:00:32)
    [GCC 4.2.1 Compatible Apple LLVM 11.0.0 (clang-1100.0.32.4) (-macos10.15-objc-s

    In [39]: %%script python3
        ...: import sys
        ...: print('hello from Python: %s' % sys.version)
        ...:
        ...:
    hello from Python: 3.7.6 (default, Jan  8 2020, 13:42:34)
    [Clang 4.0.1 (tags/RELEASE_401/final)]

    In [40]: %%ruby     # alias of `script ruby`
        ...: puts "Hello from Ruby #{RUBY_VERSION}"
        ...:
        ...:
    Hello from Ruby 2.6.3

    In [41]: %%bash     # alias of `script bash`
        ...: echo "hello from $BASH"
        ...:
        ...:
    hello from /bin/bash

%%bash命令::

    In [43]: %%bash
        ...: echo "hi, stdout"
        ...: echo "hello, stderr" >&2
        ...:
        ...:
    hi, stdout
    hello, stderr

    In [44]: %%bash --out output --err error
        ...: echo "hi, stdout"
        ...: echo "hello, stderr" >&2
        ...:
        ...:

    In [45]: print(error)
        ...:
    hello, stderr


    In [46]: print(output)
    hi, stdout

其他::

    %env显示环境变量。
    
    %hist或%history显示历史记录。
    
    %macro name n1-n2 n3-n4 ... n5 .. n6 ...创建一个名称为name的宏，执行name就是执行n1-n2 n3-n4 ... n5 .. n6 ...这些代码。
    %pwd显示当前目录
    %pycat filename用语法高亮显示一个python文件（不用加.py后缀名）。
    %save filename n1-n2 n3-n4 ... n5 .. n6 ...将执行过多代码保存为文件
    %debug命令在异常点启动调试器。
    %pdb命令来激活IPython调试器，这样，每当异常抛出时，调试器就会自动运行。
    %pylab命令可以使Numpy和matplotlib中的科学计算功能生效。



.. [3] https://ipython.readthedocs.io/en/stable/interactive/tutorial.html#magics-explained