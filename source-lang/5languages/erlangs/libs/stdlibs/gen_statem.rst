gen_statem模块
###################


@todo  [1]_


design_principles
'''''''''''''''''''''''''''


事件驱动状态机::

  State(S) x Event(E) -> Actions(A), State(S')
  在状态S时，发生事件E => 执行A事件，并把状态改为S'


实例:

.. literalinclude:: /files/erlangs/gen_statem_1.erl
   :language: erlang
   :linenos:

什么时候用::

  1.无论事件类型(call, cast, info),每个state共用回一回调代码. 
      Co-located callback code for each state, regardless of Event Type (such as call, cast and info)
  2.延迟事件(替代选择性receive)
      Postponing Events (a substitute for selective receive)
  3.插入事件:从状态机到自身的事件(特别是纯内部事件)
      Inserted Events that is: events from the state machine to itself (in particular purely internal events)
  4.State Enter Calls(state的回调入口与其他states的回调代码共用)
      State Enter Calls (callback on state entry co-located with the rest of each state's callback code)
  5.超时使用简单(状态超时,事件超时,通用超时)
      Easy-to-use timeouts (State Time-Outs, Event Time-Outs and Generic Time-outs (named time-outs))




.. [1] http://erlang.org/doc/design_principles/statem.html



