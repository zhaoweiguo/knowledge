Nginx插件用法 
#################

在你的目录<addonFolder>下新建文件夹<module>, <module>至少有以下两个文件::

    config
    ngx_http_<module>_module.c

"config" for filter modules::

    ngx_addon_name=ngx_http_<your module>_module
    HTTP_AUX_FILTER_MODULES="$HTTP_AUX_FILTER_MODULES ngx_http_<your module>_module"
    NGX_ADDON_SRCS="$NGX_ADDON_SRCS $ngx_addon_dir/ngx_http_<your module>_module.c"

"config" for other modules::

    ngx_addon_name=ngx_http_<your module>_module
    HTTP_MODULES="$HTTP_MODULES ngx_http_<your module>_module"
    NGX_ADDON_SRCS="$NGX_ADDON_SRCS $ngx_addon_dir/ngx_http_<your module>_module.c"

recompile nginx with::

    ./configure --add-module=<addonFolder>/<module>


if you need any dynamically linked libraries, you can add this to your "config" file::

    CORE_LIBS ="$CORE_LIBS -lfoo"   // foo is the library you need





