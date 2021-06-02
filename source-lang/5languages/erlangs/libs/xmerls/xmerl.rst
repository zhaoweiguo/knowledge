xmerl
########

export_simple/2/3
'''''''''''''''''''''''
说明::

  用指定的回调函数导出"simple-form"的XML内容

结构::

  export_simple(Content, Callback, RootAttrs::RootAttributes) -> ExportedFormat
  类型:
  Content = [Element]
  Callback = atom()
  RootAttributes = [XmlAttributes]

export_simple/2::

  等同于:
  export_simple(Content, Callback, []).

Element结构::

  {Tag, Attributes, Content}
  {Tag, Content}
  Tag
  IOString
  #xmlText{}
  #xmlElement{}
  #xmlPI{}
  #xmlComment{}
  #xmlDecl{}

  % 其中
  Tag = atom()
  Attributes = [{Name, Value}]
  Name = atom()
  Value = IOString | atom() | integer()

实例::

  % 写tsung.xml文件
  file:open(filename:join(Dir,BaseName),[write]),
  Export=xmerl:export_simple([Config],xmerl_xml),
  io:format(IOF,"~s~n",[lists:flatten(Export)])









