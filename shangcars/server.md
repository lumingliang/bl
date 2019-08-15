php

// 查看已安装的php
dpkg -l | grep php

// 查看apt源上缓存的和php有关的
apt-cache search php


sudo apt-get install php7.1-fpm php7.1-curl php7.1-gd php7.1-intl php7.1-json  php7.1-mbstring  php7.1-mcrypt  php7.1-mysql php7.1-pgsql php7.1-readline php7.1-soap php7.1-xml php7.1-bcmath php7.1-dev php-pear


sudo apt-get install php5-dev php-pear
sudo apt-get install php7.1-dev php-pear
sudo pecl install zmq-beta

zmq 安装方法
 sudo apt-get install pkg-config
 sudo apt-get install libzmq3-dev
sudo pecl install zmq-beta



git服务器

 php5                                 5.5.9+dfsg-1ubuntu4.21            all          server-side, HTML-embedded scripting language (metapackage)
ii  php5-cli                             5.5.9+dfsg-1ubuntu4.21            amd64        command-line interpreter for the php5 scripting language
ii  php5-common                          5.5.9+dfsg-1ubuntu4.21            amd64        Common files for packages built from the php5 source
ii  php5-curl                            5.5.9+dfsg-1ubuntu4.21            amd64        CURL module for php5
ii  php5-fpm                             5.5.9+dfsg-1ubuntu4.21            amd64        server-side, HTML-embedded scripting language (FPM-CGI binary)
ii  php5-intl                            5.5.9+dfsg-1ubuntu4.21            amd64        internationalisation module for php5
ii  php5-json                            1.3.2-2build1                     amd64        JSON module for php5
ii  php5-readline

git 新安装

sudo apt-get update

sudo rsync -rltgoDzvO -e 'ssh -p22 -i /home/ubuntu/.ssh/id_rsa'   /etc/apt/sources.list.d/ 'ubuntu@119.29.37.172:~/apt'
  2018-01-23 17:13:19 sudo apt-get install php7.1-fpm php7.1-curl php7.1-intl php7.1-json php7.1-common  php7.1-readline
  773  2018-01-23 17:15:02 ls
  774  2018-01-23 17:15:25 cd /var/www/serverconfig/
  775  2018-01-23 17:15:25 ls
  776  2018-01-23 17:15:43 mkdir php7newinstall
  777  2018-01-23 17:16:03 sudo mv /etc/php/7.1/* ./
  778  2018-01-23 17:16:04 ls
  779  2018-01-23 17:16:51 mv cli fpm ./php7newinstall/
  780  2018-01-23 17:16:55 sudo mv cli fpm ./php7newinstall/
  781  2018-01-23 17:16:56 ls
  782  2018-01-23 17:17:24 sudo mv  mods-available/ /etc/php/7.1/
  783  2018-01-23 17:18:01 sudo cp -r php5/cli php5/fpm/ /etc/php/7.1/
  784  2018-01-23 17:18:09 ls /etc/php/7.1/
  785  2018-01-23 17:18:31 vim /etc/php/7.1/fpm/php.ini
  786  2018-01-23 17:18:40 ls
  787  2018-01-23 17:18:53 sudo /etc/init.d/php7.1-fpm restart


prod


sudo apt-get install php7.1-fpm php7.1-curl php7.1-gd php7.1-intl php7.1-json  php7.1-mbstring  php7.1-mcrypt  php7.1-mysql php7.1-pgsql php7.1-readline php7.1-soap php7.1-xml php7.1-bcmath php7.1-dev 
1. php7.1 , php配置？
2. zmq
```
 sudo apt-get install pkg-config
 sudo apt-get install libzmq3-dev
sudo pecl install zmq-beta
```
3. 代码 + .env
4. 数据库migrate + 特殊数据表同步
5. 测试

6. 安装protoc , protoc 插件、以及该语言的包
