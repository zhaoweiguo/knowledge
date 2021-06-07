常见命令
================

字符串相关::

    // 【参数】str1, str2 为需要比较的两个字符串
    // 如果两个字符串相等的话，strncmp将返回0
    int strcmp(const char *s1,const char *s2);
    // 【参数】str1, str2 为需要比较的两个字符串，n为要比较的字符的数目
    // 此函数与strcmp极为类似。不同之处是，strncmp函数是指定比较size个字符
    int strncmp ( const char * str1, const char * str2, size_t n );

    // void *memcpy(void*dest, const void *src, size_t n);
    char* src="Golden Global View";
  　char dest[20]; // char* dest = (char *)malloc(20);
  　memcpy(dest, src + 14, 4);//从第14个字符(V)开始复制，连续复制4个字符(View)

::

    // void *malloc(unsigned int num_bytes);
    int *p;
    p = (int*)malloc(sizeof(int) * 128);
    //分配128个（可根据实际需要替换该数值）整型存储单元，
    //并将这128个连续的整型存储单元的首地址存储到指针变量p中
    double *pd = (double*)malloc(sizeof(double) * 12);
    //分配12个double型存储单元，
    //并将首地址存储到指针变量pd中