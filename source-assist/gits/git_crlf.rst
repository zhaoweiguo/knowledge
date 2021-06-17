CRLF换行符问题
---------------------------------------
* 换行符::

    CR回车:\r
    LF换行:\n
    Windows/Dos CRLF \r\n
    Linux/Unix LF \n
    MacOS CR \r

* AutoCRLF::

    #提交时转换为LF，检出时转换为CRLF
    git config --global core.autocrlf true

    #提交时转换为LF，检出时不转换
    git config --global core.autocrlf input

    #提交检出均不转换
    git config --global core.autocrlf false

* SafeCRLF::

    #拒绝提交包含混合换行符的文件
    git config --global core.safecrlf true

    #允许提交包含混合换行符的文件
    git config --global core.safecrlf false

    #提交包含混合换行符的文件时给出警告
    git config --global core.safecrlf warn


* 问题::

    如果你的源文件中是换行符是LF,而autocrlf=true
    此时git add就会遇到 fatal: LF would be replaced by CRLF 的错误.
    有两个解决办法:
    1. 将你的源文件中的LF转为CRLF即可【推荐】
    2. 将autocrlf 设置为 false

    如果你的源文件中是换行符是CRLF,而autocrlf=input
    此时git add也会遇到 fatal: CRLF would be replaced by LF 的错误.有两个解决办法:
    1. 将你源文件中的CRLF转为LF【推荐】
    2. 将autocrlf 设置为true 或者 false



    在Mac上设置 autocrlf = input
    在Windows上设置autocrlf = true(默认值)

    Windows:(true)
    提交时,将CRLF 转成 LF再提交
    切出时,自动将LF 转为 CRLF;

    MAC/Linux:(input)
    提交时,将CRLF 转成 LF再提交
    切出时,保持LF即可

    这样即可保证仓库中永远都是LF


http://greyfocus.com/2015/05/line-breaks-with-git/::

  //core.autocrlf
  # Sets the value of the eol configuration property to CRLF. During the
  # normalization process, all line breaks will be converted to CRLF
  git config core.eol CRLF
  //core.autocrlf
  



    
