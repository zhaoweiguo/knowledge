.. -*- coding: utf-8 -*-
.. _uwsgi_nginx:

uwsgi nginx
#############################


nginx::

    uwsgi_pass unix:///tmp/uwsgi.sock;
    include uwsgi_params;
    or
    uwsgi_pass 127.0.0.1:3031;
    include uwsgi_params;
		
uwsgi_params::

    uwsgi_param QUERY_STRING $query_string;
    uwsgi_param REQUEST_METHOD $request_method;
    uwsgi_param CONTENT_TYPE $content_type;
    uwsgi_param CONTENT_LENGTH $content_length;
    uwsgi_param REQUEST_URI $request_uri;
    uwsgi_param PATH_INFO $document_uri;
    uwsgi_param DOCUMENT_ROOT $document_root;
    uwsgi_param SERVER_PROTOCOL $server_protocol;
    uwsgi_param REMOTE_ADDR $remote_addr;
    uwsgi_param REMOTE_PORT $remote_port;
    uwsgi_param SERVER_ADDR $server_addr;
    uwsgi_param SERVER_PORT $server_port;
    uwsgi_param SERVER_NAME $server_name;
		
		
Clustering::

    upstream uwsgicluster {
        server unix:///tmp/uwsgi.sock;
        server 192.168.1.235:3031;
        server 10.0.0.17:3017;
    }
    //remeber modify your uwsgi_pass directive:
    uwsgi_pass uwsgicluster;
		
Dynamic apps::

    ./uwsgi -s /tmp/uwsgi.sock -C -M -A 4 -m
    

遇到问题(未确认)
----------------------

recv() failed (104: Connection reset by peer) while reading response header from upstream

解决办法，在uwsgi中添加参数``--buffer-size 32768``



upstream prematurely closed connection while reading response header from upstream
解决办法，在uwsgi中添加参数``--limit-post 100000``




