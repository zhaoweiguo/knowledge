
//这个结构定义了一个HTTP请求。
struct ngx_http_request_s {
  uint32_t                          signature;         /* "HTTP" */

  // 这个请求对应的客户端连接
  ngx_connection_t                 *connection;  //当前request的连接

  // 指向存放所有HTTP模块的上下文结构体的指针数组
  void                            **ctx;  //上下文

  // 指向请求对应的存放main级别配置结构体的指针数组
  void                            **main_conf; //main配置

  // 指向请求对应的存放srv级别配置结构体的指针数组
  void                            **srv_conf;  //srv配置

  // 指向请求对应的存放loc级别配置结构体的指针数组
  void                            **loc_conf;  //loc配置

  /*
    在接收完HTTP头部，第一次在业务上处理HTTP请求时，HTTP框架提供的处理方法是ngx_http_process_request。
    但如果该方法无法一次处理完该请求的全部业务，在归还控制权到epoll事件模块后，该请求再次被回调时，将通过ngx_http_request_handler方法来处理，
    而这个方法中对于可读事件的处理就是调用read_event_handler处理请求。也就是说，HTTP模块希望在底层处理请求的读事件，重新实现read_evet_handler方法。
  */
  ngx_http_event_handler_pt         read_event_handler;

  /*
    与read_event_handler回调方法类似，如果ngx_http_request_handler方法判断当前事件是可写事件，则调用write_event_handler处理请求。
  */
  ngx_http_event_handler_pt         write_event_handler;

#if (NGX_HTTP_CACHE)
  ngx_http_cache_t                 *cache;
#endif

  // upstream机制用到的结构体
  ngx_http_upstream_t              *upstream;  //load-balance，如果模块是load-balance的话设置这个
  ngx_array_t                      *upstream_states;
  /* of ngx_http_upstream_state_t */

  /*
    表示这个请求的内存池，在ngx_http_free_request 方法中销毁。它与ngx_connection_t中的内存池意义不同，当请求释放时，
    TCP连接可能并没有关闭，这时请求的内存池会销毁，但ngx_connection_t的内存池不会销毁
  */
  ngx_pool_t                       *pool;     //连接池

  // 用于接收HTTP请求内容的缓冲区，主要用于接收HTTP头部
  ngx_buf_t                        *header_in;

  /*
    ngx_http_prcess_request_headers 方法在接收，解析完HTTP请求的头部后，会把解析完的每个HTTP头部加入到headers_in的headers连表中，
    同时会构造headers_in中的其他成员
  */
  ngx_http_headers_in_t             headers_in; //request的header
  /*
    HTTP模块会把想要发送到HTTP相应信息放到headers_out中，期望HTTP框架将headers_out中的成员序列化为HTTP相应包发送给用户
  */
  ngx_http_headers_out_t            headers_out; //response的header，使用ngx_http_send_header发送

  // 接收HTTP请求中包体的数据结构
  ngx_http_request_body_t          *request_body; //response的body

  // 延迟关闭连接的时间
  time_t                            lingering_time;

  /*
    当前请求初始化时的时间。如果这个请求是子请求，则该时间是自请求的生成时间；如果这个请求是用户发来的请求，则是建立起TCP连接后，第一次接收到可读事件时的时间
  */
  time_t                            start_sec;

  // 与start_sec配合使用，表示相对于start_sec秒的毫秒偏移量
  ngx_msec_t                        start_msec;

  ngx_uint_t                        method;
  ngx_uint_t                        http_version; //http的版本

  ngx_str_t                         request_line;
  ngx_str_t                         uri;  //请求的路径 eg '/query.php'
  ngx_str_t                         args; //请求的参数 eg 'name=john'
  ngx_str_t                         exten; 
  ngx_str_t                         unparsed_uri;

  ngx_str_t                         method_name;
  ngx_str_t                         http_protocol;

  /*
    表示需要发送给客户端的HTTP相应。out中保存着由headers_out中序列化后的表示HTTP头部的TCP流。在调用ngx_http_output_filter方法后，
    out中还会保存待发送的HTTP包体，它是实现异步发送的HTTP相应的关键
  */
  ngx_chain_t                      *out; //输出的chain

  /*
    当前请求既可能是用户发来的请求，也可能是派生出的子请求，而main则标识一系列相关的派生子请求的原始请求，
    我们一般可以通过main和当前请求的地址是否相等来判断当前请求是否为用户发来的原始请求。
  */
  ngx_http_request_t               *main;

  // 当前请求的父请求。注意，父请求未必是原始请求
  ngx_http_request_t               *parent;

  // 与subrequest子请求相关的功能。
  ngx_http_postponed_request_t     *postponed;
  ngx_http_post_subrequest_t       *post_subrequest;

  /*
    所有自请求都是通过posted_requests这个单链表来链接起来的，执行post子请求时调用的ngx_http_run_posted_requests
    方法就是通过遍历该单链表来执行子请求的。
  */
  ngx_http_posted_request_t        *posted_requests;

  ngx_http_virtual_names_t         *virtual_names;

  /*
    全局的ngx_http_phase_engine_t结构体中定义了一个ngx_http_phase_handler_t 回调方法组成的数组，
    而phase_handler成员则与该数组配合使用，表示请求下次应当执行以phase_handler作为序号指定的数组中的回调方法。
    HTTP框架正是以这种方式把各个HTTP模块集成起来处理请求的。
  */
  ngx_int_t                         phase_handler;

  /*
    表示NGX_HTTP_CONTENT_PHASE阶段提供给HTTP模块处理请求的一种方式，content_handler指向HTTP模块实现的请求处理方法。
  */
  ngx_http_handler_pt               content_handler;

  /*
    在NGX_HTTP_ACCESS_PHASE阶段需要判断请求是否具有访问权限时，通过access_code来传递HTTP模块的handler回调方法的返回值，
    如果access_code为0，则表示请求具备访问权限，反之则说明请求不具备访问权限
  */ 
  ngx_uint_t                        access_code;

  ngx_http_variable_value_t        *variables;

#if (NGX_PCRE)
  ngx_uint_t                        ncaptures;
  int                              *captures;
  u_char                           *captures_data;
#endif

  size_t                            limit_rate;

  /* used to learn the Apache compatible response length without a header */
  size_t                            header_size;

  // HTTP请求的全部长度，包括HTTP包体
  off_t                             request_length;

  ngx_uint_t                        err_status;

  ngx_http_connection_t            *http_connection;

  ngx_http_log_handler_pt           log_handler;

  // 在这个请求中，如果打开了某些资源，并需要在请求结束时释放，那么都需要在把定义的释放资源方法添加到cleanup成员中。
  ngx_http_cleanup_t               *cleanup;

  unsigned                          subrequests:8;

  /*
    表示当前请求的引用次数。例如，在使用subrequest功能时，依附在这个请求上的自请求数目会返回到count上，每增加一个子请求，
    count数就要加1。其中任何一个自请求派生出新的子请求时，对应的原始请求（main指针指向的请求）的count值都要加1.又如，
    当我们接收HTTP包体的时候，由于这也是一个异步调用，所以count上也需要加1，这样在结束请求时，就不会在count引用计数未清零时销毁请求。
  */
  unsigned                          count:8;

  // 标志位，目前仅由aio使用
  unsigned                          blocked:8;

  // 标志位，为1表示当前请求正在使用异步文件IO
  unsigned                          aio:1;

  unsigned                          http_state:4;

  /* URI with "/." and on Win32 with "//" */
  unsigned                          complex_uri:1;

  /* URI with "%" */
  unsigned                          quoted_uri:1;

  /* URI with "+" */
  unsigned                          plus_in_uri:1;

  /* URI with " " */
  unsigned                          space_in_uri:1;

  unsigned                          invalid_header:1;

  unsigned                          add_uri_to_alias:1;
  unsigned                          valid_location:1;
  unsigned                          valid_unparsed_uri:1;

  // 标志位，为1表示URL发生过rewrite重写
  unsigned                          uri_changed:1;

  /*
    表示使用rewrite重写URL的次数。因为目前最多可以更改10次，所以uri_changes初始化为11，而每重写URL一次就把uri_changes减1，
    一旦uri_changes等于0，则向用户返回失败
  */
  unsigned                          uri_changes:4;

  unsigned                          request_body_in_single_buf:1;
  unsigned                          request_body_in_file_only:1;
  unsigned                          request_body_in_persistent_file:1;
  unsigned                          request_body_in_clean_file:1;
  unsigned                          request_body_file_group_access:1;
  unsigned                          request_body_file_log_level:3;

  unsigned                          subrequest_in_memory:1;
  unsigned                          waited:1;

#if (NGX_HTTP_CACHE)
  unsigned                          cached:1;
#endif

#if (NGX_HTTP_GZIP)
  unsigned                          gzip_tested:1;
  unsigned                          gzip_ok:1;
  unsigned                          gzip_vary:1;
#endif

  unsigned                          proxy:1;
  unsigned                          bypass_cache:1;
  unsigned                          no_cache:1;

  /*
   * instead of using the request context data in
   * ngx_http_limit_zone_module and ngx_http_limit_req_module
   * we use the single bits in the request structure
   */
  unsigned                          limit_zone_set:1;
  unsigned                          limit_req_set:1;

#if 0
  unsigned                          cacheable:1;
#endif

  unsigned                          pipeline:1;
  unsigned                          plain_http:1;
  unsigned                          chunked:1;
  unsigned                          header_only:1;

  // 标志位，为1表示当前请求是keepalive请求
  unsigned                          keepalive:1;

  // 延迟关闭标志位，为1表示需要延迟关闭。例如在接收完HTTP头部时如果发现包体存在，该标志位会设置1，而放弃接收包体会设为0
  unsigned                          lingering_close:1;

  // 标志位，为1表示正在丢弃HTTP请求中的包体
  unsigned                          discard_body:1;

  // 标志位，为1表示请求的当前状态是在做内部跳转
  unsigned                          internal:1;
  unsigned                          error_page:1;
  unsigned                          ignore_content_encoding:1;
  unsigned                          filter_finalize:1;
  unsigned                          post_action:1;
  unsigned                          request_complete:1;
  unsigned                          request_output:1;

  // 标志位，为1表示发送给客户端的HTTP相应头部已经发送。在调用ngx_http_send_header方法后，若已经成功地启动相应头部发送流程，
  // 该标志位就会置1，用来防止反复地发送头部。
  unsigned                          header_sent:1;
  unsigned                          expect_tested:1;
  unsigned                          root_tested:1;
  unsigned                          done:1;
  unsigned                          logged:1;

  // 表示缓冲中是否有待发送内容的标志位
  unsigned                          buffered:4;

  unsigned                          main_filter_need_in_memory:1;
  unsigned                          filter_need_in_memory:1;
  unsigned                          filter_need_temporary:1;
  unsigned                          allow_ranges:1;

#if (NGX_STAT_STUB)
  unsigned                          stat_reading:1;
  unsigned                          stat_writing:1;
#endif

  /* used to parse HTTP headers */

  // 状态机解析HTTP时使用stats来表示当前的解析状态。
  ngx_uint_t                        state;

  ngx_uint_t                        header_hash;
  ngx_uint_t                        lowcase_index;
  u_char                            lowcase_header[NGX_HTTP_LC_HEADER_LEN];

  u_char                           *header_name_start;
  u_char                           *header_name_end;
  u_char                           *header_start;
  u_char                           *header_end;

  /*
   * a memory that can be reused after parsing a request line
   * via ngx_http_ephemeral_t
   */

  u_char                           *uri_start;
  u_char                           *uri_end;
  u_char                           *uri_ext;
  u_char                           *args_start;
  u_char                           *request_start;
  u_char                           *request_end;
  u_char                           *method_end;
  u_char                           *schema_start;
  u_char                           *schema_end;
  u_char                           *host_start;
  u_char                           *host_end;
  u_char                           *port_start;
  u_char                           *port_end;

  unsigned                          http_minor:16;
  unsigned                          http_major:16;

}



