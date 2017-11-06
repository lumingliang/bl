##### 记录一些宝贵的sh、$命令
禁止密码登陆
```
vi /etc/ssh/sshd_config 
service sshd restart
asswordAuthentication no
```
安装l2tp 
```
wget --no-check-certificate https://raw.githubusercontent.com/teddysun/across/master/l2tp.sh
chmod +x l2tp.sh
./l2tp.sh
l2tp -a 
/etc/init.d/xl2tpd start
/etc/init.d/xl2tpd sop
/etc/init.d/xl2tpd stop
/etc/init.d/xl2tpd start
l2tp -l

```

安装pptp
```
wget http://mirrors.linuxeye.com/scripts/vpn_centos.sh
chmod +x ./vpn_centos.sh
./vpn_centos.sh

```
增大虚拟内存
```

dd if=/dev/zero of=/swapfile bs=1024 count=1024000
mkswap /swapfile
swapon /swapfile
 cat /proc/swaps 
 free //查看虚拟内存情况
```
安装php7 
```
wget http://au2.php.net/distributions/php-7.0.13.tar.bz2
tar    -jxvf  php-7.0.13.tar.bz2 

#./configure --prefix=/usr/local/php --enable-mbstring --with-pdo-mysql --with-pgsql --enable-fpm --with-pdo-pgsql --with-zlib --with-openssl --with-curl --without-pdo-sqlite --disable-sqlite3 --enable-zip
./configure --prefix=/usr/local/php --enable-mbstring --with-pdo-mysql --with-pgsql --enable-fpm --with-pdo-pgsql --with-zlib --with-openssl --with-curl --without-pdo-sqlite  --enable-zip
make & make install
cp /home/download/php-7.0.13/sapi/fpm/php-fpm /usr/local/php7/bin

yum -y install libxm12
yum -y install libxml2-devel
pecl install openssl
pecl install curl
pecl install calendar
pear install hash
pecl install x-debug
pecl install zlib

pecl install intl
rpm -qa icu
whereis icu
find /icu
find / icu
find --help
man find
whereis curl
locale icu
locale curl
locale --help
locale -v icu
find /lib64 icu
find /lib icu
```
安装composer
```
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php composer-setup.php

cd /opt/www/luma
php /usr/local/php/composer.phar require imagine/imagine
```

安装postgres
```
wget https://ftp.postgresql.org/pub/source/v9.6.1/postgresql-9.6.1.tar.bz2
tar -jxvf postgresql-9.6.1.tar.bz2

./configure --prefix=/usr/local/pgsql
make
make install
make install-world

// 依赖
rpm -qa | grep readline
yum search readline
yum -y install readline-devel
rpm -qa | grep zlib
yum search zlib
yum install zlib
yum install zlib-devel
make --v

// 安装后注意配置库文件目录
find / -name libpq.so.5
ln -s /usr/local/pgsql/lib/libpq.so.5 /usr/lib/libpq.so.5
ln -s /usr/local/pgsql/lib/libpq.so.5 /usr/lib64/libpq.so.5
vi /etc/profile

vi: export ld_library_path=/usr/local/pgsql/lib
source /etc/profile
iptables -A INPUT -p tcp --dport 5432 -j ACCEPT
ps -ef
netstat
netstat -lnp
postgres -D /usr/local/pgsql/data > logfile 2>&1
centos 6.5
 pg_ctl -D /usr/local/pgsql/data -l logfile start

mkdir /usr/local/pgsql/data
adduser postgres
chown postgres /usr/local/pgsql/data
chown postgres /usr/local/pgsql/data
cd /home/postgres/

initdb -E UTF-8 -D /usr/local/pgsql/data --locale=zh_CN.UTF-8    
创建一个role
create role lumin  CREATEDB login password '123456';
createdb -U lumin test

/usr/local/pgsql/bin/postgres -D /usr/local/pgsql/data >logfile 2>&1 &
/usr/local/pgsql/bin/createdb test
/usr/local/pgsql/bin/psql test
 pg_ctl reload  -D /usr/local/pgsql/data >logfile 2>&1 &

 导入数据
 dropdb test
createdb -U lumin test
psql test
\i /usr/local/pgsql/1.sql
```
安装spinx-for-chinese
```

#wget http://sphinxsearch.com/files/sphinx-2.2.11-release.tar.gz
#tar -xzvf sphinx-2.2.11-release.tar.gz 

wget http://sphinxsearchcn.github.io/downloads/sphinx-for-chinese-2.2.1-dev-r4311.tar.gz
tar -xvf sphinx-for-chinese-2.2.1-dev-r4311.tar.gz 
cd sphinx-for-chinese-2.2.1-dev-r4311
./configure --prefix=/usr/local/sphinx-for-chinese --with-mysql --with-pgsql
./configure --prefix=/usr/local/sphinx-for-chinese  --with-pgsql
./configure --prefix=/usr/local/sphinx  --with-pgsql
make 
make -j4 install
make install
yum install mysql-devel

复制本地一份xdict_1.1.txt到服务器
/usr/local/sphinx-for-chinese/bin/mkdict xdict_1.1.txt xdict
必须用全路径
/usr/local/sphinx/bin/mkdict xdict_1.1.txt xdict
searchd -c /usr/local/sphinx-for-chinese/etc/pgsql.conf 
searchd --stop -c /usr/local/sphinx-for-chinese/etc/pgsql.conf 
indexer  -c /usr/local/sphinx-for-chinese/etc/pgsql.conf --all
searchd -c /usr/local/sphinx-for-chinese/etc/pgsql.conf 
cd /usr/local/sphinx-for-chinese/

//api
iptables -A INPUT -p tcp  --dport 9312 -j ACCEPT
//searchd
iptables -A INPUT -p tcp  --dport 9306 -j ACCEPT
iptables -A INPUT -p tcp  --dport 80 -j ACCEPT
```

安装nginx
```

# wget http://nginx.org/download/nginx-1.10.2.tar.gz
# tar -xzvf nginx-1.10.2.tar.gz 
# cd nginx-1.10.2
vi /etc/yum.repos.d/nginx.repo
```

[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/6/$basearch/
gpgcheck=0
enabled=1
```
yum install nginx
利用官方安装
**阿里云用不了官方源**

useradd -u 288 -g www -M -d /sbin/nologin www
useradd -u 288 -M -d /sbin/nologin www
useradd -u 288 -M  www
userdel -r www
useradd -u 488 www
useradd www
mkdir /var/log/nginx/log
```
nginx: [emerg] socket() [::]:80 failed (97: Address family not supported by protocol)

vim /etc/nginx/conf.d/default.conf
将
listen       80 default_server;
listen       [::]:80 default_server;
改为：
listen       80;
#listen       [::]:80 default_server;

依赖
```

whereis zlib
whereis openssl

```

安装git
```

wget https://github.com/git/git/archive/v2.9.3.tar.gz
tar -xvf v2.9.3.tar.gz 

cd git-2.9.3/
make prefix=/usr/local/git all
make prefix=/usr/local/git install

yum install curl-devel expat-devel gettext-devel openssl-devel zlib-devel
yum install gcc perl-ExtUtils-MakeMaker
 # yum groupinstall "Development Tools"
 # yum install gettext-devel openssl-devel perl-CPAN perl-devel zlib-devel
```
安装imagick
```
# wget https://www.imagemagick.org/download/ImageMagick.tar.gz
# wget https://www.imagemagick.org/download/ImageMagick-6.9.6-7.tar.gz
wget https://www.imagemagick.org/download/ImageMagick-6.9.7-0.tar.gz
tar -xvf ImageMagick-6.9.6-7.tar.gz 
cd ../imagick/ImageMagick-6.9.6-7
./configure --with-jp2=yes
pecl install imagick

# tar -xvf ImageMagick.tar.gz 
# cd ImageMagick-7.0.3-9/
ls
./configure 
make && make install
identify -version

yum install tcl-devel libpng-devel libjpeg-devel ghostscript-devel bzip2-devel freetype-devel libtiff-devel
#sudo yum install ImageMagick-devel
```
安装php中文分词
```
wget http://www.xunsearch.com/scws/down/scws-1.2.3.tar.bz2
tar xjvf scws-1.2.3.tar.bz2 
cd scws-1.2.3
ls
/usr/local/scws/bin/scws -h

./configure --prefix=/usr/local/scws
make && make install

 ls -al /usr/local/scws/lib/libscws.la
/usr/local/scws/bin/scws -h

cd /usr/local/scws/etc
wget http://www.xunsearch.com/scws/down/scws-dict-chs-utf8.tar.bz2
wget http://www.xunsearch.com/scws/down/scws-dict-chs-gbk.tar.bz2
tar xvjf scws-dict-chs-gbk.tar.bz2
 tar xvjf scws-dict-chs-utf8.tar.bz2

cd ~/scws-1.2.3
cd /home/download/scws/scws-1.2.3
cd phpext/

phpize
./configure --help
make
 ./configure --with-scws=/usr/local/scws 
make
make install

```

安装yii
```
yum -y install unzip
git remote add origin git@gitlab.com:luminMara/luma.git
git clone add origin git@gitlab.com:luminMara/luma.git
git clone git@gitlab.com:luminMara/luma.git
unzip luma.zip 
mv vendor* ../vendor
./init
```

依赖
```
yum -y install libxm12
yum -y install libxml2-devel
yum install libcurl-devel
pecl install openssl
yum -y install unzip
yum -y install zip

yum -y install -y readline-devel
yum install zlib
yum install zlib-devel

yum install tcl-devel libpng-devel libjpeg-devel ghostscript-devel bzip2-devel freetype-devel libtiff-devel
yum install curl-devel expat-devel gettext-devel openssl-devel zlib-devel

yum install mysql-devel
yum install iptables iptables-services 
/etc/init.d/iptables stop  
netstat -an
/etc/rc.d/init.d/iptables save
service iptables restart

LD_LIBRARY_PATH
一直搞不定为何pgsql 外部无法连接，原来有这个该死的防火墙
9    ACCEPT     tcp  --  0.0.0.0/0            0.0.0.0/0           tcp dpt:9306 
```

git rm -r --cached  */Runtime/\*      //最终执行命令.
git commit -m"移除Runtime目录下所有文件的版本控制"    //提交

# 安装mysql，采用yum安装
1. 先下载好升级包
2. 安装升级包到yum列表
3. 步骤2后得到了mysql的最新yum源
4. yum repolist enabled | grep mysql
5.  yum install mysql-community-server
可能出错，因为该包过时
6.  yum install postfix-2:2.6.6-8.el6.x86_64
7. service mysqld start
8. sudo grep 'temporary password' /var/log/mysqld.log
查看临时密码
9. mysql -uroot -p
10. ALTER USER 'root'@'localhost' IDENTIFIED BY 'lumin';
外网访问
```
mysql -u root -pvmwaremysql>use mysql;
mysql>update user set host = '%' where user ='root';
mysql>select host, user from user;
mysql>flush privileges;

2,授权用户,你想root使用密码从任何主机连接到mysql服务器

GRANT ALL PRIVILEGES ON *.* TO 'root'@'%'  IDENTIFIED BY 'admin123'  WITH GRANT OPTION;
flush privileges;

如果你想允许用户root从ip为192.168.1.104的主机连接到mysql服务器

GRANT ALL PRIVILEGES ON *.* TO 'myuser'@'192.168.1.104'   IDENTIFIED BY 'admin123'  WITH GRANT OPTION; 
flush privileges;
```
