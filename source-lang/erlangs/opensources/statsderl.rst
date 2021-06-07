statsderl [1]_
#######################
Environment variables::

  Name      Type                            Default             Description
  base_key  base_key()                      undefined           key prefix
  hostname  inet:ip_address() | inet:hostname() | binary()  {127,0,0,1} server hostname
  port      inet:port_number()              8125                server port
  pool_size pos_integer()                   4                   pool size


Parse Transform::

  -compile({parse_transform, statsderl_transform}).

Examples::

  1> statsderl_app:start().
  ok.

  2> statsderl:counter(["test", $., "counter"], 1, 0.23).
  ok.

  3> statsderl:decrement("test.decrement", 1, 0.5).
  ok.

  4> statsderl:gauge([<<"test">>, $., "gauge"], 333, 1.0).
  ok.

  5> statsderl:gauge_decrement([<<"test.gauge_decrement">>], 15, 0.001).
  ok.

  6> statsderl:gauge_increment(<<"test.gauge_increment">>, 32, 1).
  ok.

  7> statsderl:increment(<<"test.increment">>, 1, 1).
  ok.

  8> statsderl:timing("test.timing", 5, 0.5).
  ok.

  9> statsderl:timing_fun(<<"test.timing_fun">>, fun() -> timer:sleep(100) end, 0.5).
  ok.

  10> Timestamp = os:timestamp().
  {1448,591778,258983}

  11> statsderl:timing_now("test.timing_now", Timestamp, 0.15).
  ok.

  12> statsderl_app:stop().
  ok.

使用实例::

  https://github.com/ferd/vmstats


.. [1] https://github.com/lpgauth/statsderl