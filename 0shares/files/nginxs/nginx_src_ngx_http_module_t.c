
//HTTP框架在读取,重载配置文件时定义了由ngx_http_module_t接口描述的8个阶段
//这8个阶段的调用顺序应该是：
/*
create_main_conf
create_srv_conf
create_loc_conf
preconfiguration
init_main_conf
merge_srv_conf
merge_loc_conf
postconfiguration
*/
typedef struct {
  ngx_int_t   (*preconfiguration)(ngx_conf_t *cf);  //解析配置文件前调用
  ngx_int_t   (*postconfiguration)(ngx_conf_t *cf); //完成配置文件解析后调用

  void       *(*create_main_conf)(ngx_conf_t *cf);  //当需要创建数据结构用户存储main级别的全局配置项时候调用
  char       *(*init_main_conf)(ngx_conf_t *cf, void *conf); //初始化main级别配置项

  void       *(*create_srv_conf)(ngx_conf_t *cf); //当需要创建数据结构用户存储srv级别的全局配置项时候调用
  char       *(*merge_srv_conf)(ngx_conf_t *cf, void *prev, void *conf); //srv覆盖策略

  void       *(*create_loc_conf)(ngx_conf_t *cf); //当需要创建数据结构用户存储loc级别的全局配置项时候调用
  char       *(*merge_loc_conf)(ngx_conf_t *cf, void *prev, void *conf); //loc覆盖策略
} ngx_http_module_t;


