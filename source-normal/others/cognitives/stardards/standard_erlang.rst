Erlang规范
###################
Good coding practices [1]_

文件注释::

  %%%-------------------------------------------------------------------
  %%% @author 赵卫国
  %%% @copyright (C) 2018, <COMPANY>
  %%% @doc
  %%%   简单写清楚这个文件主要功能是什么
  %%% @end
  %%% Created : 22. 八月 2018 15:05
  %%%-------------------------------------------------------------------

公有函数注释::

  %%--------------------------------------------------------------------
  %% @doc
  %% 简单写清楚这个函数主要功能是什么
  %%
  %% @end
  %%--------------------------------------------------------------------

私有函数注释::

  %%--------------------------------------------------------------------
  %% @private
  %% @doc
  %% This function is called for each installed event handler when
  %% an event manager receives any other message than an event or a
  %% synchronous request (or a system message).
  %%
  %% @end
  %%--------------------------------------------------------------------

其他::

  %% 在你认为需要的地方写上注释

增加标注功能::

  %% 如:
  -spec update_gadget_attr(GadgetId::binary(), Attributes::list()) -> ok.






.. [1] http://www.erlang.se/doc/programming_rules.shtml

