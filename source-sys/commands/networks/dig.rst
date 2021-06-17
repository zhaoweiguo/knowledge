dig命令
#########

::

    dig @{ns1.example.com} {example.com}
    dig @{ns1.example.com} {example.com} {TYPE}
    dig cyberciti.biz a
    dig cyberciti.biz mx
    dig cyberciti.biz ns
    dig cyberciti.biz txt
    dig @ns1.nixcraft.net cyberciti.biz a


其他::

    $ dig +trace cyberciti.biz          # Task: Trace Usage
    $ dig +short cyberciti.biz          # Task: Get Only Short Answer
    $ dig +noall +answer cyberciti.biz any      # Task: Display All Records
    $ dig -x +short {IP-Address-here}           # Task: Reverse IP Lookup
    $ dig +nssearch cyberciti.biz               # Task: Find Domain SOA Record
    $ dig +nocmd +noall +answer {TYPE} {example.com}    # Task: Find Out TTL Value Using dig


::

    dig www.zhaoweiguo.com +nocomments +nocmd
    // +trace可查看更详细信息

    dig +trace  @8.8.8.8 www.baidu.com A

    简化命令:
    +nocmd
    +short
    +nocomment
    +nostat

    dig 全称Domain Information Groper



实例::

  dig @8.8.8.8 www.baidu.com A

正常结果::

	~ dig @8.8.8.8 www.baidu.com A

	; <<>> DiG 9.10.6 <<>> @8.8.8.8 www.baidu.com A
	; (1 server found)
	;; global options: +cmd
	;; Got answer:
	;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 12823
	;; flags: qr rd ra; QUERY: 1, ANSWER: 3, AUTHORITY: 0, ADDITIONAL: 1

	;; OPT PSEUDOSECTION:
	; EDNS: version: 0, flags:; udp: 512
	;; QUESTION SECTION:
	;www.baidu.com.         IN  A

	;; ANSWER SECTION:
	www.baidu.com.      80  IN  CNAME   www.a.shifen.com.
	www.a.shifen.com.   112 IN  A   180.97.33.108
	www.a.shifen.com.   112 IN  A   180.97.33.107

	;; Query time: 58 msec
	;; SERVER: 8.8.8.8#53(8.8.8.8)
	;; WHEN: Mon May 07 23:14:21 CST 2018
	;; MSG SIZE  rcvd: 101

错误结果::

	~ dig @8.8.8.8 www.baidu.com1 A

	; <<>> DiG 9.10.6 <<>> @8.8.8.8 www.baidu.com1 A
	; (1 server found)
	;; global options: +cmd
	;; Got answer:
	;; ->>HEADER<<- opcode: QUERY, status: NXDOMAIN, id: 44290
	;; flags: qr rd ra ad; QUERY: 1, ANSWER: 0, AUTHORITY: 1, ADDITIONAL: 1

	;; OPT PSEUDOSECTION:
	; EDNS: version: 0, flags:; udp: 512
	;; QUESTION SECTION:
	;www.baidu.com1.            IN  A

	;; AUTHORITY SECTION:
	.           86392   IN  SOA a.root-servers.net. nstld.verisign-grs.com. 2018050700 1800 900 604800 86400

	;; Query time: 49 msec
	;; SERVER: 8.8.8.8#53(8.8.8.8)
	;; WHEN: Mon May 07 23:16:30 CST 2018
	;; MSG SIZE  rcvd: 118





