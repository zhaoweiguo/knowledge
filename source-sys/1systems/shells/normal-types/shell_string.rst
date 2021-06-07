字符串相关
##########

字符串拼接（连接、合并）::

    name="Shell"
    url="http://c.biancheng.net/shell/"
    str1=$name$url  #中间不能有空格
    str2="$name $url"  #如果被双引号包围，那么中间可以有空格
    str3=$name": "$url  #中间可以出现别的字符串
    str4="$name: $url"  #这样写也可以
    str5="${name}Script: ${url}index.html"  #这个时候需要给变量名加上大括号


