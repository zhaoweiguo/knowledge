.. _mnesia_example:

Mnesia实例
##################
::

    Write = fun(Keys) -> [mnesia:write({dictionary,K,K}) || K <- Keys], ok end.
    mnesia:activity(sync_dirty, Write, [lists:seq(1, 1000)], mnesia_frag).


