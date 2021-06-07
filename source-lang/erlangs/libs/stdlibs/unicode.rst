unicode模块
###############


.. function:: characters_to_binary/1/2/3

::

    characters_to_binary(Data).
        characters_to_binary(Data, unicode, unicode).

    characters_to_binary(Data, InEncoding).
        characters_to_binary(Data, InEncoding, unicode).

    % 结构:
    characters_to_binary(Data, InEncoding, OutEncoding) -> Result
    % 类型:
    Data = latin1_chardata() | chardata() | external_chardata()
    InEncoding = OutEncoding = encoding()
    Result = 
        binary() |
        {error, binary(), RestData} |
        {incomplete, binary(), binary()}
    RestData = latin1_chardata() | chardata() | external_chardata()


实例::

    > unicode:characters_to_binary("谢").
    <<232,176,162>>
    > unicode:characters_to_binary("谢", latin1).
    <<232,176,162>>

    > unicode:characters_to_list("谢").
    [35874]









