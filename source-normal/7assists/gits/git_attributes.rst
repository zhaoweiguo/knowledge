git gitattributes
=========================

说明::

  .gitigonre 你想要忽略的文件或者目录
  .gitattribute 用于设置文件的对比方式（常用非文本文件）


实例::

  *               text=auto
  *.txt   text
  *.jpg   -text
  *.vcproj  text eol=crlf
  *.sh    text eol=lf
  *.py    eol=lf

  // 说明
  第1行，对任何文件，设置text=auto，表示文件的行尾自动转换。如果是文本文件，则在文件入Git库时，行尾自动转换为LF。如果已经在入Git库中的文件的行尾为CRLF，则该文件在入Git库时，不再转换为LF。
  第2行，对于txt文件，标记为文本文件，并进行行尾规范化。
  第3行，对于jpg文件，标记为非文本文件，不进行任何的行尾转换。
  第4行，对于vcproj文件，标记为文本文件，在文件入Git库时进行规范化，即行尾为LF。但是在检出到工作目录时，行尾自动转换为CRLF。
  第5行，对于sh文件，标记为文本文件，在文件入Git库时进行规范化，即行尾为LF。在检出到工作目录时，行尾也不会转换为CRLF（即保持LF）。
  第6行，对于py文件，只针对工作目录中的文件，行尾为LF。


属性::

  text，控制行尾的规范性。
  如果一个文本文件是规范的，则Git库中该文件的行尾总是LF。

  对于工作目录，除了text属性之外，还可以设置eol属性，或core.eol配置变量。

  eol，设置行末字符
  eol=lf，入库时将行尾规范为LF，检出时禁止将行尾转换为CRLF
  eol=crlf，入库时将行尾规范为CRLF，检出时将行尾转换为CRLF
  crlf，已过时，类似于text
  ident，为路径设置ident属性，路径中的blob对象中的$Id$将会被替换为$Id:char_40_hexadecimal_name
  filter
  利用命令clean,smudge
  diff
  merge，与merge.default配置变量一起确定如何合并文件
  在执行git merge, git revert和git cherry-pick时，如何考虑文件的版本
  Git内置的merge驱动：
  merge=text
  merge=binary
  merge=union
  whitespace，对应core.whitespace配置变量
  在执行git diff, git apply时是否考虑空格。
  export-ignore,export-subst，打包相关的属性
  delta，即Delta压缩
  对于delta=false的路径中的blob对象，不会进行Delta压缩
  encoding，为GUI工具（如gitk, git-gui）设置字符编码，以正确显示匹配的文件内容
  如果该属性未设置，或设置了无效值，则GUI工具会使用配置变量gui.encoding的值。



参考：

  https://git-scm.com/docs/gitattributes


