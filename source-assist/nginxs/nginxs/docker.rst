Docker相关
###############

::

    docker run \
    -p 80:80 -p 8081:8081 \
    --name mynginx \
    -v $PWD/nginx/www:/opt/nginx/html \
    -v $PWD/nginx/config/default.conf:/etc/nginx/conf.d/default.conf \
    -v $PWD/nginx/logs:/wwwlogs \
    -v /home/xg/DockerFile/nginx/conf/htpasswd/gerrit.passwd:/etc/nginx/conf.d/gerrit.passwd \
    -d nginx








