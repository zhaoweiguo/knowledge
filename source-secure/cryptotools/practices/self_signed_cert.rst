在Linux中新增CA证书
###################

::

    $> cp xxx.crt /usr/local/share/ca-certificates/xxx.crt
    $> update-ca-certificates
    最后检查下面文件最后是否包含新增证书
    /etc/ssl/certs/ca-certificates.crt
    or
    /etc/ca-certificates.conf


Docker::

    FROM alpine

    COPY Letsencrypt_Root_CA.crt /usr/local/share/ca-certificates/
    RUN apk --no-cache add ca-certificates \
      && rm -rf /var/cache/apk/* \
      && update-ca-certificates






