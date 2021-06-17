认证和ACL
===============



EMQ 消息服务器支持可扩展的认证与访问控制,相关模块::

  emqttd_access_control, 
  emqttd_auth_mod 
  emqttd_acl_mod


emqttd_access_control 模块提供了注册认证扩展接口:

  register_mod(auth | acl, atom(), list()) -> ok | {error, any()}.
  register_mod(auth | acl, atom(), list(), non_neg_integer()) -> ok | {error, any()}.


http://emqtt.com/docs/v2/design.html#auth-acl