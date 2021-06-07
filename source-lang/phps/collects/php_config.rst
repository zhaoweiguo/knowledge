.. _php_config:

MySQL配置文件实例详解
################################



.. literalinclude:: /files/phps/php.ini
   :linenos:



配置文件说明
---------------------
::

    ; 配置文件加载顺序
    ; 1. SAPI module specific location.
    ; 2. The PHPRC environment variable. (As of PHP 5.2.0)
    ; 3. A number of predefined registry keys on Windows (As of PHP 5.2.0)
    ; 4. Current working directory (except CLI)
    ; 5. The web server's directory (for SAPI modules), or directory of PHP
    ; (otherwise in Windows)
    ; 6. The directory from the --with-config-file-path compile time option, or the
    ; Windows directory (C:\windows or C:\winnt)
    ; See the PHP docs for more specific information.
    ; http://php.net/configuration.file









