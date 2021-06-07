Inet Configuration
#######################

::

    % erl -sname my_node -kernel inetrc '"./cfg_files/erl_inetrc"'


./cfg_files(Unix):

.. code-block:: erlang
   :linenos:

    %% -- ERLANG INET CONFIGURATION FILE --
    %% read the hosts file
    {file, hosts, "/etc/hosts"}.
    %% add a particular host
    {host, {134,138,177,105}, ["finwe"]}.
    %% do not monitor the hosts file
    {hosts_file, ""}.
    %% read and monitor nameserver config from here
    {resolv_conf, "/usr/local/etc/resolv.conf"}.
    %% enable EDNS
    {edns,0}.
    %% disable caching
    {cache_size, 0}.
    %% specify lookup method
    {lookup, [file, dns]}.




