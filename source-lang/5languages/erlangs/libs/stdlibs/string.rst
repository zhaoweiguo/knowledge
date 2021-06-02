string模块
###################

.. function:: chars/2

::

    结构:
    chars(Character, Number) -> String
    chars(Character, Number, Tail) -> String
    类型:
    Character = char()
    Number = integer() >= 0
    Tail = String = string()

实例::

    erl> string:chars($-,5).
    "-----"

.. function:: chr/2

结构::

    chr(String, Character) -> Index

类型::

    String = string()
    Character = char()
    Index = integer() >= 0

说明::

    Return the index of first/last occurrence of Character in String.
    0 returned if the character does not occur.

.. function:: strip/1/2/3

结构::

  strip/1 === strip(String, both).
  strip/2 === strip(String, Direction, " ").


  strip(String, Direction, Character) -> Stripped
  类型:
  String = Stripped = string()
  Direction = left | right | both
  Character = char()

说明::

  根据需要去除字串前(后)的Character

实例::

  > string:strip("...Hello.....", both, $.).
  "Hello"
  > string:strip("   Hello    ", both).
  "Hello"
  > string:strip("   Hello    ").
  "Hello"

.. function:: str/2

结构::

    str(String, SubString) -> Index
    类型:
    String = SubString = string()
    Index = integer() >= 0

说明::

    返回每一次出现的SubString在String中开始的位置.
    如String不存在SubString则返回0

实例::

    > string:str(" Hello Hello World World ", "Hello World").
    8

.. function:: tokens/2

结构::

    tokens(String, SeparatorList) -> Tokens
    类型
    String = SeparatorList = string()
    Tokens = [Token :: nonempty_string()]

说明::

  Return a list of tokens in ``String`` , separated by the characters in `SeparatorList`

实例::

    % 按空格or字符x分割
    > lists:tokens("abc defxxghix jkl", "x ").
    ["abc", "def", "ghi", "jkl"]


.. function:: to_integer/1

用法::

    to_integer(String) -> {Int, Rest} | {error, Reason}

    类型:
    String = string()
    Int = integer()
    Rest = string()
    Reason = no_integer | not_a_list

说明::

    String以数字开头,
    Int: 返回最前面的数字 
    Rest: 数字后面剩余的string

实例::

    > {I1,Is} = string:to_integer("33+22"),
    > {I2,[]} = string:to_integer(Is),
    > I1-I2.
     11
    > string:to_integer("0.5").
     {0,".5"}
    > string:to_integer("x=2").
     {error,no_integer}







