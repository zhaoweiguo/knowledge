.. _puttygen:

puttygen——由openssh密钥生成putty ssh密钥
===============================================

* 有openssh生成的密钥, 如何得到putty ssh的密钥，方法如下，其中<keyfile>为密钥名::

    puttygen <keyfile> -o <keyfile>.ppk -O private

* 有putty ssh的密钥, 如何得到openssh的密钥， 方法如下, 其中<keyfile.ppk>为putty ssh密钥::

    puttygen <keyfile.ppk> -o <keyfile> -O private-openssh

* 其他详情请参看 ``puttygen --help``



