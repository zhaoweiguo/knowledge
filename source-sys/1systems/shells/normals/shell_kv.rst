.. _shell_kv:

shell的key/value相关知识
#############################


实例::

    ARRAY=( "key1:name1" "key1:name1" "key1:name1");

    for animal in "${ARRAY[@]}" ; do
       KEY=${animal%%:*}
       VALUE=${animal#*:}
       printf "%s likes to %s.\n" "$KEY" "$VALUE"
    done




