日志
####

logrus
======

logrus 的作者观点一样，"核心不是性能"::

    printf 类型字符串格式化的日志格式，不再推荐
    现在日志的消费，逐渐从人转向了计算机，结构化的数据和友好的解析方式更重要

* logrus功能强大，性能高效，而且具有高度灵活性，提供了自定义插件的功能
* 很多开源项目，如docker，prometheus等，都是用了logrus来记录其日志
* github: https://github.com/sirupsen/logrus ::

    logrus是目前Github上star数量最多的日志库
    star数量: 8.1k(201808) -> 13.4k(20191024) -> 16.3k(20201027)
    fork数: 1031(201808) -> 1.5k -> 1.8k
    开源协议: MIT

设置打印格式::

    logrus自带两种方式的输出格式: 纯文本和JSON格式的
    &logrus.JSONFormatter
    &logrus.TextFormatter
    // 使用
    log := logrus.New()
    log.SetFormatter(formatter)

设置日志级别::

    // 使用
    log := logrus.New()
    log.SetLevel(level)

    // 日志级别
    var levels = map[string]logrus.Level{
      "panic": logrus.PanicLevel,
      "fatal": logrus.FatalLevel,
      "error": logrus.ErrorLevel,
      "warn":  defaultLevel,
      "info":  logrus.InfoLevel,
      "debug": logrus.DebugLevel,
    }

设置打印函数、文件、行号::

    &logrus.JSONFormatter{
      CallerPrettyfier: func(f *runtime.Frame) (string, string) {
        filename := path.Base(f.File)
        return f.Function, fmt.Sprintf("%s:%d", filename, f.Line)
      },
    }
    &logrus.TextFormatter{
        CallerPrettyfier: func(f *runtime.Frame) (string, string) {
          filename := path.Base(f.File)
          return f.Function, fmt.Sprintf("%s:%d", filename, f.Line)
        },
    }




其他
====

* zap是Uber推出的一个快速、结构化的分级日志库 https://github.com/uber-go/zap::
  
    具有强大的ad-hoc分析功能，并且具有灵活的仪表盘
    star数量: 4.3k(201808) -> 8.6k(20191024)  -> 11k(20201027)
    开源协议: MIT

* seelog提供了灵活的异步调度、格式化和过滤功能: 
* zerolog: https://github.com/rs/zerolog





