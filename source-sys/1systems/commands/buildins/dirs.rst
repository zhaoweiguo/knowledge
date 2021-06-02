pushd, popd & dirs命令
######################

start up with the following directories::

    $ pwd
    ~/somedir
    $ ls
    dir1  dir2  dir3

pushd to dir1::

    $ pushd dir1
    ~/somedir/dir1 ~/somedir
    $ dirs
    ~/somedir/dir1 ~/somedir

pushd to ../dir3 (because we're inside dir1 now)::

    $ pushd ../dir3
    ~/somedir/dir3 ~/somedir/dir1 ~/somedir
    $ dirs
    ~/somedir/dir3 ~/somedir/dir1 ~/somedir
    $ pwd
    ~/somedir/dir3

manually change directories to ../dir2::

    $ cd ../dir2
    $ pwd
    ~/somedir/dir2
    $ dirs
    ~/somedir/dir2 ~/somedir/dir1 ~/somedir

Now start popping directories::

    $ popd
    ~/somedir/dir1 ~/somedir
    $ pwd
    ~/somedir/dir1

Pop again...::

    $ popd
    ~/somedir    
    $ pwd
    ~/somedir




参考
====

* How do I use pushd and popd commands?: https://unix.stackexchange.com/questions/77077/how-do-i-use-pushd-and-popd-commands

