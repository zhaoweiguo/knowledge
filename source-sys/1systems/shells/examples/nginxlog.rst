Nginx日志
#########


::

    #!/bin/bash

    logs_path="/data/nginx/"

    logs_files=(access.log error.log)

    mkdir -p ${logs_path}$(date -d "yesterday" +"%Y")/$(date -d "yesterday" +"%m")/

    for logs_file in "${logs_files[@]}"
    do

        mv ${logs_path}${logs_file} ${logs_path}$(date -d "yesterday" +"%Y")/$(date -d "yesterday" +"%m")/${logs_file}_$(date -d "yesterday" +"%Y%m%d-%H%M%S")

    done

    kill -USR1 `cat /var/run/nginx.pid`



