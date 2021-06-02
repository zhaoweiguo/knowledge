gerrit
######

* 简介 [1]_
* 官网 [2]_

gerrit，一种免费、开放源代码的代码审查软件，使用网页界面。利用网页浏览器，同一个团队的软件程序员，可以相互审阅彼此修改后的程序代码，决定是否能够提交，退回或者继续修改。它使用Git作为底层版本控制系统。它分支自Rietveld，作者为Google公司的Shawn Pearce，原先是为了管理Android计划而产生。gerrit同gitlab、github一样可以用于团队管理项目代码和文档，相对于gitlab更加轻量，其运行时所消耗资源较少。


::

    // 其中8091为web访问端口，29418为ssh端口
    docker run \
    --name mygerrit \
    -v $PWD/gerrit_volume:/var/gerrit/review_site \
    -p 8091:8091 -p 29418:29418 \
    -e USER_NAME=zhaoweiguo \
    -e USER_EMAIL=yourEmail@163.com \
    -e AUTH_TYPE=HTTP \
    -e SMTP_SERVER=smtp.163.com \
    -e SMTP_SERVER_PORT=465 \
    -e SMTP_ENCRYPTION=ssl \
    -e SMTP_USER=yourEmail@163.com \
    -e SMTP_CONNCT_TIMEOUT=30sec \
    -e SMTP_FROM=USER \
    -e SMTP_PASS=yourPassword \
    -d openfrontier/gerrit








.. [1] https://blog.csdn.net/u011127242/article/details/79966978
.. [2] https://www.gerritcodereview.com/