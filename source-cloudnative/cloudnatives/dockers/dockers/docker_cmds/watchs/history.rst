docker history
######################

Usage::

    // Show the history of an image
    docker history [OPTIONS] IMAGE

实例::
     
    # docker history 94728651ce15
    IMAGE               CREATED             CREATED BY                                      SIZE                COMMENT
    94728651ce15        20 hours ago        /bin/sh -c #(nop) EXPOSE 80/tcp                 0 B                
    09e999b131f4        20 hours ago        /bin/sh -c echo 'Hi, I am in your container'    27 B               
    4af2ef04fb91        20 hours ago        /bin/sh -c apt-get install -y nginx             56.52 MB           
    e98d2c152d1d        20 hours ago        /bin/sh -c apt-get update     




Options::

        --format string   Pretty-print images using a Go template
    -H, --human           Print sizes and dates in human readable format (default true)
        --no-trunc        Don't truncate output
    -q, --quiet           Only show numeric IDs







