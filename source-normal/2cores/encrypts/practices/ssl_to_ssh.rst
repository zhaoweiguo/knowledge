OpenSSL转OpenSSH密钥
###########################

openssl的公钥例子::

    —–BEGIN PUBLIC KEY—–
    MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC7vbqajDw4o6gJy8UtmIbkcpnk
    O3Kwc4qsEnSZp/TR+fQi62F79RHWmwKOtFmwteURgLbj7D/WGuNLGOfa/2vse3G2
    eHnHl5CB8ruRX9fBl/KgwCVr2JaEuUm66bBQeP5XeBotdR4cvX38uPYivCDdPjJ1
    QWPdspTBKcxeFbccDwIDAQAB
    —–END PUBLIC KEY—–

openssh的公钥例子::

    ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAAAgQC7vbqajDw4o6gJy8UtmIbkcpnkO3Kwc4qsEnSZp/TR+fQi62F79RHWmwKOtFmwteURgLbj7D/WGuNLGOfa/2vse3G2eHnHl5CB8ruRX9fBl/

linux::

    ssh-keygen -e -f ~/.ssh/id_rsa.pub > ~/.ssh/id_rsa_pub.pem
    ssh-keygen  -f ~/.ssh/id_rsa_pub.pem -i -m RFC4716 > ~/.ssh/id_rsa.pub

windows::

    1)Use the puttyGen
    2) Run puttygen and click generate
    3) Run your mouse round the blank part for a while.
    4) Enter a keyphrase (and repeat)
    5) Click save public key and save it <path>\publickey
    6) Click save private key and save it <path>\privatekey (extension gets added automatically, this is no good for spoon, but good for putty)
    7) Click Conversions->Export OpenSSH key and save as <path>\sshkey.pem
    8) In the main window is you key for pasting into OpenSSH authorized_keys file. Copy this in its entirety and past it into your ubuntu machine in /home/<user>/.ssh/authorized_keys file.
    9) Ok, you can close putty key generator.
    10) Utilize the .pem in the tool.



