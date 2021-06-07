Poolboy  [1]_
#################

A hunky Erlang worker pool factory

用法::

    1> Worker = poolboy:checkout(PoolName).
    <0.9001.0>
    2> gen_server:call(Worker, Request).
    ok
    3> poolboy:checkin(PoolName, Worker).
    ok

选项::

  name`` the pool name
  worker_module`` the module that represents the workers
  size`` the maximum pool size
  max_overflow`` the maximum number of workers created if pool is empty



* example.app:

.. literalinclude:: /files/erlangs/poolboy_example.app
   :language: erlang
   :linenos:

* example.erl:

.. literalinclude:: /files/erlangs/poolboy_example.erl
   :language: erlang
   :linenos:

* example_worker.erl:

.. literalinclude:: /files/erlangs/poolboy_example_worker.erl
   :language: erlang
   :linenos:






.. [1] https://github.com/devinus/poolboy



