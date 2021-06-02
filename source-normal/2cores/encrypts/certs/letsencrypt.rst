Let's Encrypt
#############

* Let's Encrypt [1]_


Getting Started With Shell Access [2]_
======================================

实例——Nginx on Debian 9 (stretch)::

    1. SSH into the server with sudo privileges.
    2. Install Certbot:
      $ sudo apt-get install certbot python-certbot-nginx
    3. 生成证书

       a) 生成证书并自动修改nginx配置
          $ sudo certbot --nginx
       b) 只生成证书
          $ sudo certbot certonly --nginx
    4. 证书有效期3个月:
      // 刷新证书(未验证)
      $ certbot renew

IMPORTANT NOTES::

    - Congratulations! Your certificate and chain have been saved at:
     /etc/letsencrypt/live/www.zhaoweiguo.com/fullchain.pem
     Your key file has been saved at:
     /etc/letsencrypt/live/www.zhaoweiguo.com/privkey.pem
     Your cert will expire on 2020-03-19. To obtain a new or tweaked
     version of this certificate in the future, simply run certbot
     again. To non-interactively renew *all* of your certificates, run
     "certbot renew"
    - If you like Certbot, please consider supporting our work by:

     Donating to ISRG / Let's Encrypt:   https://letsencrypt.org/donate
     Donating to EFF:                    https://eff.org/donate-le





.. [1] https://letsencrypt.org/
.. [2] https://certbot.eff.org/