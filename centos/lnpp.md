###### 服务器配置相关
####### lnpp linux6.8+ nginx1.1 postgresql9.6 php7 sphinx2.2
1. 注意nginx在windwos下的配置
```
root /cygdrive/f/lumin/yii/frontend/web/; // 使用cygdrive形式定义好web目录
// 使用windows小写路径形式传递index文件位置
fastcgi_param  SCRIPT_FILENAME  f:/lumin/yii/frontend/web/$fastcgi_script_name;
// 使用cygdrive形式定义access_log
access_log  /cygdrive/c/nginx/logs/b.dev.access.log;
```
2. 两者必须同时严格定义
###### centos 6 下

**在编译php等需要指定某个依赖的dir时，其实有两种方法，如果是应用prefix 安装的依赖那么直接告诉它该路径即可，如果是利用yum安装的，先whereis一下，找出他的目录分配，而这个目录分配其实是有规律的，如，分配在/usr/下的各个子目录 bin man lib lib64 include下，编译是会自动往下面的目录找东西，其实跟安装在prefix的效果是一样的**

1.  wget http://au2.php.net/distributions/php-7.0.13.tar.bz2
2.  tar    -jxvf  php-7.0.13.tar.bz2

安装postgresql
1. 获取源码解压
2. ./configure --help
3. ./configure --prefix=/usr/loca/pgsql
4. 发现有依赖没装，查看安装文档，或看提示，并npm -qa | grep 一下看看是否已安装， yum search 看看该依赖的所有相关包
5. make , make install
6. 安装文档和其他小工具 make install-word等
7. 安装后的环境变量配置，修改/ect/profile 加入 PATH=$PATH:/usr/local/soft等
(8. export LIBRARY_PATH=LIBDIR1:LIBDIR2:$LIBRARY_PATH 设定编译时的动态库位置) // 可不设这里
9. export LD_LIBRARY_PATH=LIBDIR1:LIBDIR2:$LD_LIBRARY_PATH // 设定编译后的动态库位置，以便能让别的程序找到
** 对于LD_LIBRARY_PATH 等这些前面未设置的变量，需要/etc/profile中用export LD_LIBRARY_PATH=/usr/local/pgsql/lib 来定义才能被使用
10. 共享库一般在
ln -s /usr/pgsql-9.4/lib/libpq.so.5 /usr/lib64/libpq.so.5 // 64 位两个都要
ln -s /usr/pgsql-9.4/lib/libpq.so.5 /usr/lib/libpq.so.5
vi /etc/ld.so.conf

```
adduser postgres // postgres 不能用root启动
mkdir /usr/local/pgsql/data
chown postgres /usr/local/pgsql/data
su - postgres
/usr/local/pgsql/bin/initdb -D /usr/local/pgsql/data

修改版 
    initdb -E UTF-8 -D /usr/local/pgsql/data --locale=zh_CN.UTF-8
(initdb -E EUC_CN -D data7 --locale=zh_CN)
locale 决定在哪个国家，-E 是字符集 charater type 或 encoding 或charater encoding 
collate 排序 排序参数还有cytpe 排序一般是和charater encoding 绑定的
psql -l 查看所有数据库情况
创建一个role
create role lumin  CREATEDB login password '123456';
createdb -U lumin test

/usr/local/pgsql/bin/postgres -D /usr/local/pgsql/data >logfile 2>&1 &
/usr/local/pgsql/bin/createdb test
/usr/local/pgsql/bin/psql test
 pg_ctl reload  -D /usr/local/pgsql/data >logfile 2>&1 &

/sbin/iptables -I INPUT -p tcp --dport 5432 -j ACCEPT
/etc/rc.d/init.d/iptables save 保存修改
/etc/init.d/iptables status 查看状态
/etc/init.d/iptables restart 重启防火墙

 导入数据
 dropdb test
createdb -U lumin test
psql test
\i /usr/local/pgsql/1.sql
```
##### php-7
phpize 是用来编译pecl extension的，当一个source不是pecl extension则不能用它
```
$ cd extname
$ phpize
$ ./configure
$ make
make install
这种安装往往会得到一个ext.so文件，自动放在php.ini中的ext配置目录下，可能不需要继续在php.ini中指定即可
```
pecl 安装一些外部的库的扩展，extension，如gd，往往都需要依赖源库的安装
pear 也可以安装php库，目前两者区别在于pear对php7的库支持更多
php 安装后，可以用pecl安装额外的库支持，如gd等，比较方便
依赖的扩展zlib 压缩，openssl 作加密，datetime php core自带，fileinfo , gd 相关的png, jpg各种surport, pcre perl 一样的兼容正则表达式
intl 国际化，同时也是icu的一个包装，即依赖ICU库ICU只是一个库
iconv 字符集转化，内建
exif 读取图片meta，内建
hash 提取内容的唯一摘要，内建
zlib 压缩，需要在编译时--with-zlib
openssl 生成密码等，需要编译时 --with-openssl ，另有mcypt加密，这个已经不维护，可以不用它，系统/usr下自带yum安装了openssl，但是在编译时with-openssl=/usr 反而不工作，最后去除了这个使用它自动查找就可以了
ctype 验证字符集是否正确，内建，其实这是一个c函数库--enable-ctype内建，并default
zip 可用pecl安装/usr/local/php/lib/php/extensions/no-debug-non-zts-20151012/zip.so
json 也是内建的
libxml 编译时，自动带--with 需要依赖libxml2安装
curl 内建，必须加，注意编译往往需要用到的是依赖的源码，如include，lib下的文件
cenlader 日历，需要编译加入--enable-calendar 
xdebug pecl安装后 zend_extension=/usr/local/php/lib/php/extensions/no-debug-non-zts-20151012/xdebug.so
在php源码包中找pdo_mysql，手动进入目录编译，得到  /usr/local/php/lib/php/extensions/no-debug-non-zts-20151012/
mb_string 多类型字符转化，即一个带有多个字符集编码的字符串操作，编译时--enable-mbstring 
sapi server api 与服务器cli交互的api
 ./configure --prefix=/usr/local/php --with-pdo-mysql --with-pgsql --enable-fpm --with-pdo-pgsql
 ./configure --prefix=/usr/local/php --with-pdo-mysql --with-pgsql --enable-fpm --with-pdo-pgsql with-pdo-mysql with-
 ./configure --prefix=/usr/local/php7 --with-pdo-mysql=/usr --with-pgsql --enable-fpm --with-pdo-pgsql --with-zlib=/usr --with-openssl=/usr --with-curl=/usr --without-pdo-sqlite --enable-zip
 // 初步使用
'./configure' '--prefix=/usr/local/php7' '--with-pdo-mysql' '--with-pgsql' '--enable-fpm' '--with-pdo-pgsql' '--with-zlib' '--with-openssl' '--with-curl' '--without-pdo-sqlite' '--enable-zip
./configure --prefix=/usr/local/php --enable-mbstring --with-pdo-mysql --with-pgsql --enable-fpm --with-pdo-pgsql --with-zlib --with-openssl --with-curl --without-pdo-sqlite --disable-sqlite3 --enable-zip
 编译时内存不足用[参考](https://www.centos.org/docs/5/html/5.2/Deployment_Guide/s2-swap-creating-file.html)

 ```
**若 php 安装在特殊目录 $php_prefix, 则请在 configure 后加上 --with-php-config=$php_prefix/bin/php-config**说明了如果安装在其他目录，可能还需要分别指定各个所需的目录，如include等

 dd if=/dev/zero of=/swapfile bs=1024 count=1024000 // 添加1000M 的swapfile
mkswap /swapfile
swapon /swapfile // 让swapfile立即生效
To enable it at boot time, edit /etc/fstab to include the following entry
/swapfile swap swap defaults 0 0
 cat /proc/swaps or free // 查看是否已经生效

 **php extension dir :$  php -i | grep extension_dir即可查看，一般不用主动修改
./php -i|grep include_path

 ```
##### 安装imageimagick 
有些安装./configure --help并没有说明--with-png 等所需要的依赖，此时查看官方文档也没有说明该依赖，这时需要google查一下，到底需要什么依赖
```
yum install tcl-devel libpng-devel libjpeg-devel ghostscript-devel bzip2-devel freetype-devel libtiff-devel
yum install ImageMagick-devel // 有了上面那个即可，这个并未使用
http://www.imagemagick.org/download/delegates/
```

##### 安装nginx的编译包
 ```
vi /etc/yum.repos.d/nginx.repo
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/OS/OSRELEASE/$basearch/
gpgcheck=0
enabled=1
yum install nginx

 ```
 nginx 配置中，user nginx www 代表了用户和组
##### 安装git
由于在centos默认仓库上的git版本落后，所以用源码安装
```

 wget https://github.com/git/git/archive/v2.9.3.tar.gz
yum install curl-devel expat-devel gettext-devel openssl-devel zlib-devel
yum install gcc perl-ExtUtils-MakeMaker
cd git-2.8.1
make prefix=/usr/local/git all
make prefix=/usr/local/git install
```

##### 部署yii
1. 注意git .gitignore的每层都要配置好，对于vendor目录，本地.gitignore一定要与服务器的同步一致

##### 部署yii
1. 注意git .gitignore一定要与服务器的同步一致

##### php 异步编程
1. php 的扩展大多依赖某个c库，其实就是c的源码，因为都是利用源码编译的。
2. php 是建立在c语言之上的，有很多类、extension都是直接对c函数库的封装
3. libevent 是一个c库，用来异步编程
4. swoole是国人写的一个c库，绑定了php，区别于普通的php extension，很强大

##### 安装sphinx 
安装官网http://sphinxsearchcn.github.io/
