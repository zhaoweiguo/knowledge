git submodule命令
######################################

* set up the submodule the first time::

    cd ~/main
    git submodule add git://<submodule>.git ./subm
    git submodule update --init
    git add .
    git commit -a

* fetch submodule after cloning a repository::

    git clone git://<mainmodule>.git
    git submodule init
    git submodule update

* pull upstream main repo changes and update submodule contents::

    git pull origin master
    git submodule update

* pull upstream changes to the submodules::

    cd ./subm
    git pull origin/master
    cd ..
    git commit ./subm -m "update submodule reference"




* Edit and commit file in your submodule::

    cd ./subm
    edit <file>
    git commit <file> -m "update <file>"
    cd ..
    git commit ./subm -m "update submodule reference"

* Push your submodule changes to the submodule stream::

    cd .subm
    git push origin master


* other::

    git submodule foreach git pull origin master
    or
    git submodule foreach /path/to/some/cool/script.sh

批量::

    git submodule foreach git pull
    git submodule foreach --recursive git submodule init 
    git submodule foreach --recursive git submodule update 


Remove a Submodule within git [1]_
------------------------------------
* Delete the relevant section from the ``.gitmodules``  file. The section would look similar to::

    [submodule "vendor"]
    path = vendor
    url = git://github.com/some-user/some-repo.git

* Stage the ``.gitmodules`` changes via command line using ``git add .gitmodule``
* Delete the relevant section from the ``.git/config`` file, which would like this::

    [submodule "vendor"]
    url = git://github.com/some-user/some-repo.git

* Run ``git rm --cached path/to/submodule`` . Don't include a trailing slash——which will lead to error.
* Run ``rm -rf .git/modules/submodule``
* Commit the change
* Delete the now untracked submodule files ``rm -rf path/to/submodule``



.. [1] http://davidwalsh.name/git-remove-submodule















