匿名认证与 ACL 文件
=========================


Allow Anonymous::

  ## 默认开启，允许任意客户端登录:
  ## Allow Anonymous authentication
  mqtt.allow_anonymous = true

Default ACL File::

  ## EMQ 支持基于 etc/acl.conf 文件或 MySQL、 PostgreSQL 等插件的访问控制规则。
  ## ACL nomatch
  mqtt.acl_nomatch = allow
  ## Default ACL File
  mqtt.acl_file = etc/acl.conf

Define ACL rules in etc/acl.conf. The rules by default::

  ## 允许|拒绝  用户|IP地址|ClientID  发布|订阅  主题列表
  %% Allow 'dashboard' to subscribe '$SYS/#'
  {allow, {user, "dashboard"}, subscribe, ["$SYS/#"]}.
  %% Allow clients from localhost to subscribe any topics
  {allow, {ipaddr, "127.0.0.1"}, pubsub, ["$SYS/#", "#"]}.
  %% Deny clients to subscribe '$SYS#' and '#'
  {deny, all, subscribe, ["$SYS/#", {eq, "#"}]}.
  %% Allow all by default
  {allow, all}.

访问控制规则采用 Erlang 元组格式，访问控制模块逐条匹配规则::

            ---------              ---------              ---------
  Client -> | Rule1 | --nomatch--> | Rule2 | --nomatch--> | Rule3 | --> Default
            ---------              ---------              ---------
                |                      |                      |
              match                  match                  match
               \|/                    \|/                    \|/
          allow | deny           allow | deny           allow | deny

注::

  默认规则只允许本机用户订阅’$SYS/#’与’#’





