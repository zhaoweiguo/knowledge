certifi
#######

Certifi is a carefully curated collection of Root Certificates for validating the trustworthiness of SSL certificates while verifying the identity of TLS hosts. It has been extracted from the Requests project.

* 文档 [1]_

安装::

    $ pip install certifi


Usage::

    >>> import certifi
    >>> certifi.where()

    // from the command line:
    $ python -m certifi
    /usr/local/lib/python2.7/site-packages/certifi/cacert.pem




.. [1] https://pypi.org/project/certifi/