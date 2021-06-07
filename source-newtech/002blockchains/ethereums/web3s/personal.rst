personal Namespace
##################

personal_newAccount(创建新帐户)
===============================

+---------+-------------------------------------------------------+
| Client  | Method invocation                                     |
+=========+=======================================================+
| Console | personal.newAccount()                                 |
+---------+-------------------------------------------------------+
| RPC     | {"method": "personal_newAccount", "params": [string]} |
+---------+-------------------------------------------------------+

实例::

    > personal.newAccount()
    Passphrase: 
    Repeat passphrase: 
    "0x5e97870f263700f46aa00d967821199b9bc5a120"

The passphrase can also be supplied as a string::

    > personal.newAccount("h4ck3r")
    "0x3d80b31a78c30fc628f20b2c89d7ddbf6e53cedc"

personal_unlockAccount
======================

+---------+--------------------------------------------------------------------------+
| Client  | Method invocation                                                        |
+=========+==========================================================================+
| Console | personal.unlockAccount(address, passphrase, duration)                    |
+---------+--------------------------------------------------------------------------+
| RPC     | {"method": "personal_unlockAccount", "params": [string, string, number]} |
+---------+--------------------------------------------------------------------------+

实例::

    > personal.unlockAccount("0x5e97870f263700f46aa00d967821199b9bc5a120")
    Unlock account 0x5e97870f263700f46aa00d967821199b9bc5a120
    Passphrase: 
    true

Supplying the passphrase and unlock duration as arguments::

    > personal.unlockAccount("0x08268e9540b8d21f0867ce436e792777737ecfb6", "q1w2e3r4", 300)
    true

just override the default unlock duration, pass null as the passphrase::

    > personal.unlockAccount("0x5e97870f263700f46aa00d967821199b9bc5a120", null, 30)
    Unlock account 0x5e97870f263700f46aa00d967821199b9bc5a120
    Passphrase: 
    true



personal_listAccounts(列出帐户列表)
===================================

+---------+---------------------------------------------------+
| Client  | Method invocation                                 |
+=========+===================================================+
| Console | personal.listAccounts                             |
+---------+---------------------------------------------------+
| RPC     | {"method": "personal_listAccounts", "params": []} |
+---------+---------------------------------------------------+


::

    > personal.listAccounts
    ["0x5e97870f263700f46aa00d967821199b9bc5a120", "0x3d80b31a78c30fc628f20b2c89d7ddbf6e53cedc"]



