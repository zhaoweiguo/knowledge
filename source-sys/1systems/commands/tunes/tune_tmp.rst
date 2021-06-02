调优临时命令
==================




dmsg命令::

  当TIME_WAIT太多时，通过dmsg可以看到，会出现TCP: time wait bucket table overflow这样的错误。



::

	top -H -p <Pid>
	pstree –p 1


	按字节大小分割
	split -b 10m access.log new_file_prefix

	按行数分割
	split -l 300 access.log new_file_prefix

	查看os系统页的大小
	[oracle@skate-test~]$ getconf PAGESIZE