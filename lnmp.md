title: 配置lnmp环境

#####lnmp.org官方一键安装包

apt-get install screen  
screen -S lnmp //开启一个screen对话

这个工具可以确保远程命令安装过程中，突然掉线，可以重连后执行screen -S lnmp既可以恢复安装过程

#####nignx添加伪静态：

虚拟主机配置文件位置: /usr/local/nginx/conf/vhost/域名.conf
伪静态规则文件: /usr/local/nginx/conf/ 下

/etc/nginx/nginx.conf

类似apache的.vhost文件，它只是把虚拟主机配置分成一个个域名下的配置,然后融合起来，另外伪静态规则也是分离了，只需在虚拟主机配置下把对应的include进去即可

nginx 配置把多个类型配置分为多块，其实就一个文件即可，但是这样便于管理

配置分为配置nginx错误日志，访问日志。还有最常用的配置虚拟主机，每个虚拟主机可以指定端口和域名，如果端口一样，则通过域名来区别不同的网站 ,端口和域名唯一对应一个目录，就是网站的目录 

##### 开启php错误提示
/usr/local/php/etc/php-fpm.conf加入

php_admin_value[error_log] = /usr/local/php/var/log/php-error.log
php_admin_flag[log_errors] = on

/etc/init.d/php-fpm restart

/etc/local/php/etc/php.ini
加入
error_reporting = E_ERROR
display_errors = On 

apache 目录

usr/local/apache/conf/vhost

/etc/init.d/apache restart
/etc/init.d/nginx restart

service nginx restart
service httpd restart 重启Apache服务

/etc/hosts linux hosts文件
