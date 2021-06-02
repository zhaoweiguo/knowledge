常见问题
########

shell中$后加引号有什么用($"string"和$'string') [1]_
=====================================================

实例::

    [root@xuexi ~]# echo 'a\nb'
    a\nb
    [root@xuexi ~]# echo $'a\nb'
    a
    b

以下是man bash关于$"的解释::

    // 如果没有特殊定制bash环境或有特殊需求，$"string"和"string"是完全等价的，使用$""只是为了保证本地化
    A  double-quoted  string  preceded by a dollar sign ($"string") will cause the string to be translated according to the current locale.
    If the current locale is C or POSIX, the dollar sign is ignored.
    If the string is translated and replaced, the replacement is double-quoted.

以下是man bash里关于$'的说明::

    Words of the form $'string' are treated specially.
    The word expands to string, with backslash-escaped characters replaced as specified by the ANSI C standard.
    Backslash escape sequences, if present, are decoded as follows:
      \a     alert (bell)
      \b     backspace
      \e
      \E     an escape character
      \f     form feed
      \n     new line
      \r     carriage return
      \t     horizontal tab
      \v     vertical tab
      \\     backslash
      \'     single quote
      \"     double quote
      \nnn   the eight-bit character whose value is the octal value nnn (one to three digits)
      \xHH   the eight-bit character whose value is the hexadecimal value HH (one or two hex digits)
      \uHHHH the Unicode (ISO/IEC 10646) character whose value is the hexadecimal value HHHH (one to four hex digits)
      \UHHHHHHHH
             the Unicode (ISO/IEC 10646) character whose value is the hexadecimal value HHHHHHHH (one to eight hex digits)
      \cx    a control-x character





.. [1] https://www.cnblogs.com/f-ck-need-u/p/8454364.html