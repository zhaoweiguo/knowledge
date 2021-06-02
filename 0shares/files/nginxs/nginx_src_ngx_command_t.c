
//
struct ngx_command_s {
  ngx_str_t   name;   // 配置项名, 无空格
  ngx_uint_t  type;   // 配置项type

  // 出现了name中制定的配置项后，将会调用set方法处理配置项参数。
  // 这个可以使用nginx预设的14个解析配置方法，也可以使用自定义的。
  char        *(*set)(ngx_conf_t *cf, ngx_command_t *cmd, void *conf);   // 指令操作

  // 因为有可能模块同时会有main，srv，loc三种配置结构体，指定这个配置项解析完后要放在哪个结构体内
  ngx_uint_t  conf;

  // 表示当前配置项在整个存储配置项的结构体中的偏移位置，可以使用offsetof(test_stru, b)来获取
  ngx_uint_t  offset;

  // 命令处理完后的回调指针，对于set的14种预设的解析配置方法
  void        *post;
}

// 说明
/*
  type:
      NGX_HTTP_MAIN_CONF
      NGX_HTTP_SRV_CONF
      NGX_HTTP_LOC_CONF
      NGX_HTTP_UP_CONF

      NGX_CONF_NOARGS
      NGX_CONF_TAKE1
      NGX_CONF_TAKE2

      NGX_CONF_FLAG
      NGX_CONF_1MORE

  set:
     参数cf: 包含传给指令的参数
     参数cmd: 指向当前的ngx_command_t结构
     参数conf: 指向custom configuration struct

      // setting particular types of values in the custom configuration sturct
      ngx_conf_set_flag_slot
      ngx_conf_set_str_slot
      ngx_conf_set_num_slot
      ngx_conf_set_size_slot

   conf:
      NGX_HTTP_MAIN_CONF_OFFSET
      NGX_HTTP_SRV_CONF_OFFSET
      NGX_HTTP_LOC_CONF_OFFSET

   post:
      ngx_conf_post_t
      ngx_conf_enum_t
      ngx_conf_bitmask_t
      null

 */
