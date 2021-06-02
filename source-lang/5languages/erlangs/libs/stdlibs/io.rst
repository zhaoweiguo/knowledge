io模块
##########

get_line/1/2
''''''''''''''''''
结构::

  get_line(Prompt) -> Data | server_no_data()
  get_line(IoDevice, Prompt) -> Data | server_no_data()
  类型:
  IoDevice = device()
  Prompt = prompt()
  Data = string() | unicode:unicode_binary()
  server_no_data() = {error, ErrorDescription :: term()} | eof

说明::

  从标准输入读取一行(使用Prompt提示)

实例::

  erl> io:get_line("> ")
  > (input)
  (input)
  erl> io:get_line("input: ")
  input: (input)
  (input)









