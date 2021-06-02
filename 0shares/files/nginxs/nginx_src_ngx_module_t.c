


//参考：
//http://blog.csdn.net/livelylittlefish/article/details/6571497
#define NGX_MODULE_V1          0, 0, 0, 0, 0, 0, 1      //该宏用来初始化前7个字段  
#define NGX_MODULE_V1_PADDING  0, 0, 0, 0, 0, 0, 0, 0   //该宏用来初始化最后8个字段


//ngx_module_s是模块的定义
struct ngx_module_s {
  //对于一类模块（由下面的type成员决定类别）而言，ctx_index标示当前模块在这类模块中的序号。
  //这个成员常常是由管理这类模块的一个nginx核心模块设置的，对于所有的HTTP模块而言，ctx_index
  //是由核心模块ngx_http_module设置的。
  ngx_uint_t            ctx_index;

  //index表示当前模块在ngx_modules数组中的序号。Nginx启动的时候会根据ngx_modules数组设置各个模块的index值
  ngx_uint_t            index; 

  //spare系列的保留变量，暂未使用
  ngx_uint_t            spare0;
  ngx_uint_t            spare1;
  ngx_uint_t            spare2;
  ngx_uint_t            spare3;

  //nginx模块版本，目前只有一种，暂定为1
  //前面这7个参数使用NGX_MODULE_V1赋值
  ngx_uint_t            version;


  //模块上下文，每个模块有不同模块上下文,每个模块都有自己的特性，而ctx会指向特定类型模块的公共接口。
  //比如，在HTTP模块中，ctx需要指向ngx_http_module_t结构体。
  void                 *ctx;

  //模块命令集，将处理nginx.conf中的配置项
  // 如，在http模块中，指向ngx_command_t结构体
  ngx_command_t        *commands;


  //标示该模块的类型，和ctx是紧密相关的。它的取值范围是以下几种:
  //NGX_HTTP_MODULE,NGX_CORE_MODULE,NGX_CONF_MODULE,
  //NGX_EVENT_MODULE,NGX_MAIL_MODULE
  ngx_uint_t            type;


  //下面7个函数是nginx在启动，停止过程中的7个执行点
  ngx_int_t           (*init_master)(ngx_log_t *log);         //初始化master
  ngx_int_t           (*init_module)(ngx_cycle_t *cycle);     //初始化模块
  ngx_int_t           (*init_process)(ngx_cycle_t *cycle);    //初始化进程
  ngx_int_t           (*init_thread)(ngx_cycle_t *cycle);     //初始化线程
  void                (*exit_thread)(ngx_cycle_t *cycle);     //退出线程
  void                (*exit_process)(ngx_cycle_t *cycle);    //退出进程
  void                (*exit_master)(ngx_cycle_t *cycle);     //退出master


  //保留字段，无用，可以使用NGX_MODULE_V1_PADDING来替换
  uintptr_t             spare_hook0;
  uintptr_t             spare_hook1;
  uintptr_t             spare_hook2;
  uintptr_t             spare_hook3;
  uintptr_t             spare_hook4;
  uintptr_t             spare_hook5;
  uintptr_t             spare_hook6;
  uintptr_t             spare_hook7;


}
