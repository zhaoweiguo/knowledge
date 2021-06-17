sha256加密
=================
实例::

  # 验证网上下载包
  // 1.下载安装文件
  curl -LO https://fastdl.mongodb.org/osx/mongodb-osx-ssl-x86_64-3.4.9.tgz
  // 2.下载sha256
  curl -LO https://fastdl.mongodb.org/osx/mongodb-osx-ssl-x86_64-3.4.9.tgz.sha256
  // 3.验证
  shasum -c mongodb-osx-ssl-x86_64-3.4.9.tgz.sha256

实例::

    neo@netkiller ~ % sha256sum /etc/hosts
    be0b4786b1169533329b2ab5292d8d1c16bbea5bd24c882a983ab4b754a398c8  /etc/hosts

    neo@netkiller ~ % sha1sum /etc/hosts
    48bea81a95c75efa52608a9d384126be3131e40f  /etc/hosts

    neo@netkiller ~ % sha224sum /etc/hosts
    65bf519aa94d15c3e62406b8e1f8dd8b7fb513a5dac439606f954822  /etc/hosts

    neo@netkiller ~ % sha384sum /etc/hosts
    65478594d45d1f1054bea0f19b320607682a2c96c6efe39de9ab0a176a2623b94728937346b1ede6b92cb36c013b0d93  /etc/hosts

    neo@netkiller ~ % sha512sum /etc/hosts
    275a4258fb570d897c67a65a65e73ac1e38cdb4166b1fdf290d7f6361892f81d663cbab51a32cf827a4d4bc26edcd0a34bed36c170dc373058f3606c02c1c5ae  /etc/hosts








    



