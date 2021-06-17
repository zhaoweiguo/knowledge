第三章
================

Nginx Http模块调用简化流程:

.. figure:: /images/nginxs/nginx_src_book_module_chapter_3-1.png
   :width: 100%

**ngx_int_t** 的封装::

  typedef intptr_t ngx_int_t;
  typedef uintptr_t ngx_uint_t;

**ngx_str_t** 数据结构::

    typedef struct {
        size_t len;
        u_char *data;
    } ngx_str_t;

    // 字符串对比函数
    #define ngx_strncmp(s1, s2, n) strncmp((const char *) s1, (const char *) s2, n);

**ngx_list_t** 数据结构::

    typedef struct ngx_list_part_s ngx_list_part_t;
    struct ngx_list_part_s {
        void            *elts;
        ngx_uint_t      nelts;
        ngx_list_part_t *next;
    }
    typedef struct {
        ngx_list_part_t    *last;
        ngx_list_part_t    part;
        size_t             size;
        ngx_uint_t         nalloc;
        ngx_pool_t         *pool;
    } ngx_list_t;

ngx_list_t内存分布:

.. figure:: /images/nginxs/nginx_src_book_module_chapter_3-2.png
   :width: 100%

ngx_list_t相关函数::

    //用于创建新链表
    ngx_list_t *ngx_list_create(ngx_pool_t *pool, ngx_uint_t n, size_t size);
    //用于初使化一个已有链表
    static ngx_inline ngx_int_t ngx_list_init(ngx_list_t *list, ngx_pool_t *pool, ngx_uint_t n, size_t size);
    //用于添加新元素
    void *ngx_list_push(ngx_list_t *list);

**ngx_table_elt_t** 数据结构(为http头部量身定制)::

    typedef struct {
        ngx_uint_t      hash;
        ngx_str_t       key;
        ngx_str_t       value;
        u_char          *lowcase_key;
    } ngx_table_elt_t;

**ngx_buf_t** 数据结构::

    typedef struct ngx_buf_s ngx_buf_t;
    typedef void* ngx_buf_tag_t;
    struct ngx_buf_s {
        u_char      *pos;
        u_char      *last;
        off_t       file_pos;
        off_t       file_last;

        u_char      *start;
        u_char      *end;
        ngx_buf_tag_t   tag;
        ngx_file_t      *file;

        ngx_buf_t       *shadow;

        unsigned     temporary:1;    // 临时内存标志位
        unsigned     memory:1;      //标志位
        unsigned     mmap:1;         //
        unsigned     recycled:1;
        unsigned     in_file:1;
        unsigned     flush:1;
        unsigned     sync:1;
        unsigned     last_buf:1;
        unsigned     last_in_chain:1;
        unsigned     last_shadow:1;
        unsigned     temp_file:1;
    }

**ngx_chain_t** 数据结构::

    typedef struct ngx_chain_s ngx_chain_t;
    struct ngx_chain_s {
        ngx_buf_t     *buf;
        ngx_chain_t   *next;
    };




如何将自己的nginx模块编译进Nginx
---------------------------------------


config文件的写法::

    ngx_addon_name=<ngx_http_mytest_module>
    HTTP_MODULES="$HTTP_MODULES <ngx_http_mytest_module>";
    NGX_ADDON_SRCS="$NGX_ADDON_SRCS $ngx_addon_dir/ngx_http_mytest_module.c"








