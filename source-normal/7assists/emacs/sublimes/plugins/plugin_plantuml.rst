.. _sublime-plantuml:

plantUML插件
###################

* 下载jar包 [1]_
* 复制到目录 /Users/zhaoweiguo/bin/design
* 新增文件 <mac地址>::

    {
        "shell_cmd": "java -jar /Users/zhaoweiguo/bin/design/plantuml.1.2019.5.jar -charset UTF-8 $file",
        "path":"/Library/Java/JavaVirtualMachines/jdk1.8.0_191.jdk/Contents/Home/bin",
        "env": {"GRAPHVIZ_DOT":"/usr/local/homebrew/bin/dot"}
    }

mac地址::

    /Users/zhaoweiguo/Library/Application Support/Sublime Text 3/Packages/User/[Local]PlantUML.sublime-build


PlantUML生成环境::

    {
        "shell_cmd": "java -jar <path>/plantuml.jar -charset UTF-8 $file",
        "path":"<path>/jdk1.8.0_191.jdk/Contents/Home/bin",
        "env": {"GRAPHVIZ_DOT":"/usr/local/homebrew/bin/dot"}
    }
    说明：
    本质是执行:
    java -jar <path>/plantuml.jar -charset UTF-8 $file
    其中
    $file是指当前文件



.. [1] http://plantuml.com/zh/download



