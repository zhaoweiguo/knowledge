.. _go_clean:

go clean命令
#################

usage::

    $ go clean [-i] [-r] [-n] [-x] [build flags] [packages]
    $ go help clean

-i flag::

    remove the corresponding installed archive or binary (what 'go install' would create).

-n flag::

    print the remove commands it would execute, but not run them

-r flag::

    be applied recursively to all the dependencies of the packages named by the import paths.

-x flag::

    print remove commands as it executes them

-cache flag::

    remove the entire go build cache

-testcache flag::

    expire all test results in the go build cache

-modcache flag::

    remove the entire module download cache, including unpacked source code of versioned dependencies.







