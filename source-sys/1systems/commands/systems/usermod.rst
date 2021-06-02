.. _usermod:

usermod命令
============

**简介**

    modify a user account

**概要SYNOPSIS**

    usermod [options] LOGIN

**DESCRIPTION**

    * -a, --append
      给用户增加一个组(必须和 ``-G`` 一起用).

    * -g, --gid GROUP
      The group name or number of the users new initial(初使化) login group. The group must exist.

    * -G, --groups GROUP1[,GROUP2,...[,GROUPN]]]
      以 ``,`` 作分隔, 替换所属用户的组(想增加时,加上 ``-a`` 选项).

**举例**

    * 实例一: 给当前用户增加如下群组::

        usermod -a -G GROUP1[,GROUP2,...[,GROUPN]]]

    * 实例二: 给指定用户gordon增加如下群组::

        usermod -a -G GROUP1[,GROUP2,...[,GROUPN]]] gordon

