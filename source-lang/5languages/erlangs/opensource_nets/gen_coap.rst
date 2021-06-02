gen_coap [1]_
##################

启动服务::

  $ ./coap-server.sh
  $ erl -pa _build/default/lib/gen_coap/ebin

  1> application:ensure_all_started(gen_coap).
  {ok,[crypto,asn1,public_key,ssl,gen_coap]}

  2> coap_server:start_udp(coap_udp_socket).
  {ok,<0.78.0>}





.. [1] https://github.com/gotthardp/gen_coap


