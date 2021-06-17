doxygen文档生成工具
=========================

下载安装::

  apt-get install doxygen   // debian相关系统
  brew install doxygen   //darwin相关系统

  MacTeX // mac需要生成pdf格式


使用命令::

    doxygen -g   // 生成配置文件Doxyfile
    doxygen      //执行生成文档命令


配置文件主要选项::

    PROJECT_NAME    项目名称，将作为于所生成的程序文档首页标题
    PROJECT_NUMBER  文档版本号
    OUTPUT_DIRECTORY    程序文档输出目录: doc/
    OUTPUT_LANGUAGE     程序文档语言环境: Chinese

    OPTIMIZE_OUTPUT_FOR_C   如果是制作 C 程序文档，该选项必须设为 YES(还有一些其他类似选项)

    QUIET     设为YES时，让 doxygen 静悄悄地为你生成文档，只有出现警告或错误时，才在终端输出提示信息
    
    RECURSIVE   为YES时,归遍历当前目录的子目录

    GENERATE_LATEX    为NO时, 不生成 latex 格式的程序文档

    # 在程序文档中允许以图例形式显示函数调用关系，前提是你已经安装了 graphviz 软件包

    HAVE_DOT               = YES
    CALL_GRAPH            = YES
    CALLER_GRAPH        = YES

    EXCLUDE_PATTERNS    设定不生成文档文件: */test/*(所有test名字的文件), 支持多个

    EXTRACT_ALL    作用未知，大体是有它会生成文件标签页



