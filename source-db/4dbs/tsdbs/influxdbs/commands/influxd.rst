influxd命令
####################

开启认证
-----------

配置文件::

    [http]  
      enabled = true  
      bind-address = ":8086"  
      auth-enabled = true 
      log-enabled = true  
      write-tracing = false  
      pprof-enabled = false  
      https-enabled = false  
      https-certificate = "/etc/ssl/influxdb.pem" 


1、数据备份::

    influxd backup -database <mydatabase> <path-to-backup>




