.. _openssl_enc:

openssl enc命令
###############


des 算法::

    $ echo "zhaohang" |openssl enc -des -pass pass:123 -base64
    U2FsdGVkX19j45kavF9gFXUU6uHs2bOC8WyppMHbSNw=
    $ echo "U2FsdGVkX19j45kavF9gFXUU6uHs2bOC8WyppMHbSNw="|openssl enc -des -pass pass:123 -base64 -d 
    zhaohang

aes算法::

    $ echo "zhaohang" | openssl enc -aes-128-cbc -pass pass:123456 -base64
    U2FsdGVkX18YLuqf5Puu3JINbRNEKi9+IiThXFP2mCw=
    $ echo "U2FsdGVkX18YLuqf5Puu3JINbRNEKi9+IiThXFP2mCw=" | openssl enc -aes-128-cbc -pass pass:123456 -base64 -d 
    zhaohang

aes算法对文件::

    $ openssl enc -aes-128-cbc -in <filename.txt> -out <file.bin> -pass pass:123456
    $ openssl enc -aes-128-cbc -d -in <file.bin> -out <file.out> -pass pass:123456





