常用
####

IPython provides a rich architecture for interactive computing with::

    A powerful interactive shell.
    A kernel for Jupyter.
    Support for interactive data visualization and use of GUI toolkits.
    Flexible, embeddable interpreters to load into your own projects.
    Easy to use, high performance tools for parallel computing.

Jupyter and the future of IPython::

    1. IPython 3.x是最后一个集成版本
    2. IPython 4.0之后, 如下功能被独立出来成立一个新项目——Jupyter:
        the notebook format, message protocol, qtconsole, notebook web application, etc
    3. IPython专注于interactive Python, part of which is providing a Python kernel for Jupyter.

安装::

    $ pip install ipython

Install and register an IPython kernel with Jupyter::

    $ python -m pip install ipykernel
    $ python -m ipykernel install [--user] [--name <machine-readable-name>] [--display-name <"User Friendly Name">]

.. note:: Beginning with version 6.0, IPython stopped supporting compatibility with Python versions lower than 3.3 including all versions of Python 2.7.

使用::

    $ ipython
    Python 3.7.6 (default, Jan  8 2020, 13:42:34)
    Type 'copyright', 'credits' or 'license' for more information
    IPython 7.12.0 -- An enhanced Interactive Python. Type '?' for help

    In [1]:

The four most helpful commands::

    1. ?
    Introduction and overview of IPython’s features.

    2. %quickref
    Quick reference.

    3. help
    Python’s own help system.

    4. object?
    Details about ‘object’

    5. object??
    for extra details.



