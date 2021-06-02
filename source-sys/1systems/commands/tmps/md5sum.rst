.. _md5sum:

md5sum命令使用
===================

md5sum [文件名] 计算文件的 md5 值。同cksum

::

	$>  echo   "hello" | md5sum | cut -d ' ' -f1
	// 如果想获取字符串的其他哈希值，只要把命令中的md5sum 换成其他哈希命令就可以了。例如sha1sum，sha224sum，sha256sum，sha384sum，sha512sum等