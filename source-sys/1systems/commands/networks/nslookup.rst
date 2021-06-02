nslookup命令
#####################

安装::

	yum install bind-utils

结构::

	nslookup -qt=type domain [dns-server]
	nslookup -query=type domain [dns-server]
	// 调试
	nslookup -debug -query=type domain [dns-server]


type可以是以下这些类型::

	A 地址记录
	AAAA 地址记录
	AFSDB Andrew文件系统数据库服务器记录
	ATMA ATM地址记录
	CNAME 别名记录
	HINFO 硬件配置记录，包括CPU、操作系统信息
	ISDN 域名对应的ISDN号码
	MB 存放指定邮箱的服务器
	MG 邮件组记录
	MINFO 邮件组和邮箱的信息记录
	MR 改名的邮箱记录
	MX 邮件服务器记录
	NS 名字服务器记录
	PTR 反向记录
	RP 负责人记录
	RT 路由穿透记录
	SRV TCP服务器信息记录
	TXT 域名对应的文本信息
	X25 域名对应的X.25地址记录

实例::

	#　使用8.8.8.8对百度就行解析
	nslookup -qt=A WWW.BAIDU.COM 8.8.8.8

	nslookup -qt=mx baidu.com 8.8.8.8


交互模式::

	$ nslookup
	> www.baidu.com //以默认的上连DNS服务器来查询
	...
	> server 8.8.8.8 //更改了上连的DNS服务器地址
	...
	> set all  // 列出nslookup工具的常用选项的当前设置值
	...
	> set class=[value]  // 更改查询类，而不同的类设定了不同的协议族: 
		IN：Internet类（默认）
		CH：Chaos类: 几乎灭绝，曾经BIND套装用Chaos来协助检查版本号信息
		HS：Hesiod类: 仅在M.I.T（Massachusetts Institute of Technology，即麻省理工学院）范围内使用，现在甚至已经无人使用
	> set [no]debug    // 用来设置是否进入调试模式
	> set [no]d2       // 开启了高级调试模式，会输出很多nslookup内部工作的信息，包括了许多函数调用信息
	> set domain=[name]    // 设置默认的域。这样的话，对于所有不包含“.”的查询请求，都会自动在尾部追查此域
		如:
		> set domain=baidu.com //设置默认域为baidu.com
		> image // 等同于image.baidu.com
    > set domain= 		// 清除domain设置
    > set port=[value]  // DNS默认的服务端口是53
    > set type=[value]	// 也可以写成set querytype=[value]，用于更改信息查询类型
    	常用的type值如下:
    	A：查看主机的IPv4地址
		AAAA：查看主机的IPv6地址
		ANY：查看关于主机域的所有信息
		CNAME：查找与别名对应的正式名字
		HINFO：查找主机的CPU与操作系统类型
		MINFO：查找邮箱信息
		MX：查找邮件交换信息
		NS：查找主机域的域名服务器
		PTR：查找与给定IP地址匹配的主机名
		RP：查找域负责人记录
		SOA：查找域内的SOA地址
		UINFO：查找用户信息
    >  retry=[number] / timeout=[number]	// 可以用来设置查询重试的次数，以及每次查询的超时时限








