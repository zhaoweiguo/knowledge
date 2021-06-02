.. _muslibc:

musl libc
#########

简介
====

第一次知道musl libc是在使用golang的http模块时, 由于配置/etc/hosts改变域名指向不成功遇到的 :ref:`问题 <question_muslibc_glibc>`

* Alpine用的是musl libc而拒绝glibc，因为它小、简单、安全，而glibc有很多问题，并认为如果alpine使用了glibc就不在是alpine
* 使用oracle java的某些旧版本会遇到问题因为它指定使用glibc
* golang的http模块硬编码使用glibc默认的/etc/nsswitch.conf文件

参考
====

* https://github.com/gliderlabs/docker-alpine/issues/11
* https://stackoverflow.com/questions/34729748/installed-go-binary-not-found-in-path-on-alpine-linux-docker
* https://blog.csdn.net/liumiaocn/article/details/89702529