xmerl_scan模块
#####################

file/1/2
'''''''''''''
结构::

  file(Filename::string()) -> {xmlElement(), Rest}
  等同于: file(Filename, []).

  file(Filename::string(), Options::option_list()) -> {document(), Rest}
  类型:
  Rest = list()

说明::

  解析xml文档的文件

实例::

  % 读取tsung.xml文件
  erl> xmerl_scan:file(Filename, [{fetch_path,["/usr/share/tsung/","./"]},
                                  {validation,true}]).

解释::

  {fetch_path, PathList}: 设定Filename查询路径

string/1/2
'''''''''''''''
结构::

  string/1 等同于
  string(Text, []).

  string(Text::list(), Options::option_list()) -> {document(), Rest}
  类型:
  Rest = list()

说明::

  Parse string containing an XML document



常见问题
''''''''''
fatal: {error,{error_missing_element_declaration_in_DTD,tsung}}::

  没有指定dtd文件，如
  <!DOCTYPE tsung SYSTEM "/usr/local/share/tsung/tsung-1.0.dtd">




