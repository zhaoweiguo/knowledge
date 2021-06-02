openssl sha命令
###############


sha1对文件或字符串加密::

    $ openssl sha1 filename.txt 
    SHA1(filename.txt)= cf017022db32f04cb57d2ec1ae6b39751a6155e4

    $ echo "zhaohang" |openssl dgst -sha1 
    cf017022db32f04cb57d2ec1ae6b39751a6155e4

    $ sha1sum filename.txt 
    cf017022db32f04cb57d2ec1ae6b39751a6155e4 filename.txt




