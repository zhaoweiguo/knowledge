docker专用
################

::

    FROM       docker.io/golang:alpine

    // 更新源
    RUN echo "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.4/main" > /etc/apk/repositories
    RUN apk add --update curl bash && \
        rm -rf /var/cache/apk/*

    // 增加证书
    RUN apk add ca-certificates

    // 无cache更新
    RUN apk add --no-cache curl openssl emacs

官方镜像的大小比较::

    REPOSITORY          TAG           IMAGE ID          VIRTUAL SIZE
    alpine              latest        4e38e38c8ce0      4.799 MB
    debian              latest        4d6ce913b130      84.98 MB
    ubuntu              latest        b39b81afc8ca      188.3 MB
    centos              latest        8efe422e6104      210 MB








