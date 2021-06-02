.. _mongo_user:

用户使用命令
################

新增用户::

    use admin
    db.createUser({user:"<userName>",pwd:"<pwd>",roles:[{role:"dbOwner",db:"<dbName>"}]})

查看用户::

    db.system.users.find().pretty()








