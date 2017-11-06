###### mysql 的较深入研究，基础、原理、安装、使用、配置、优化
事务所具备的特性
ACID automicity consistency(一致性) isolation durability(持久性)
DBMS中一条sql就是默认的事务
```
DDL：数据库模式定义语言，关键字：create
DML：数据操纵语言，关键字：Insert、delete、update
DCL：数据库控制语言 ，关键字：grant、remove
DQL：数据库查询语言，关键字：select
```

###### mysql 安装
```
yum -e --nodeps mysql57-community-release.noarch
rpm -qa |grep mysql
rpm -e --nodeps mysql-community-release-el7-5.noarch
yum install mysql-community-server
https://dev.mysql.com/get/mysql57-community-release-el6-11.noarch.rpm

```
另：主动配置法
```
http://dev.mysql.com/downloads/mysql/ 下载linux通用二进制包，先用迅雷下载，后传到主机上
解压后 移动到 /usr/local/mysql 中
创建mysql 用户 useradd -U mysql -d /usr/local/mysql/ -s /sbin/nologin
创建data目录（即数据存放目录），/data/mysql
修改basedir datadir权限为mysql ： chown -R mysql.msyql /data/mysql 
执行初始化： bin/mysqld --initialize --user=mysql --basedir=/usr/local/mysql --datadir=/data/mysql 记得获取临时密码
bin/mysql_ssl_rsa_setup  --datadir=/data/mysql 这个用来干啥的？

cd support-files 修改配置文件: cp my-default.cnf /etc/my.cnf
cp mysql.server /etc/init.d/mysql 注意/etc/init.d/mysql 文件是一个sh脚本，需要修改里面的basedir , datadir

/etc/my.cnf 关键配置分为 mysqld(server 端) mysql(客户端)  注意配置好相同的datadir,basedir, 以及socket path 默认存在/tmp下

初次登陆: 用临时密码并 修改  set password=password('root');
远程登陆： grant all privileges on *.* to 'root'@'%' identified by '123456'; flush privileges;
添加系统路径到msyql export PATH=/usr/local/mysql/bin:$PATH
配置开机启动：
chmod 755 /etc/init.d/mysql
chkconfig --add mysql
chkconfig --level 345 mysql on

```

1. 索引类型，有btree、哈希索引、全文索引。索引是帮助mysql高校获取数据的数据结构
2. mysql中没有用二叉树实现而是用了b+tree来实现索引是因为效率更高。还有btree也非常高效。

[mysql索引详解](http://blog.jobbole.com/24006/)
3. mysql里面的锁
```
页级:引擎 BDB。
表级:引擎 MyISAM ， 理解为锁住整个表，可以同时读，写不行
行级:引擎 INNODB ， 单独的一行记录加锁
```

4. mysql 读写分离设置

```
show databases;
show tables;

```
5. myssql 在centos安装方式，yum安装，先安装好yum 的仓库配置包，注意版本，centos 7 用el7,6则6，然后配置disable某些版本的仓库，安装即可，对于不是最新安装要删除/var/lib/mysql 下面的文件，然后初始化一个mysql :  mysqld --initialize --user=mysql , SET PASSWORD = PASSWORD('123456');
mysql 忘记密码： 设置 /etc/my.cnf 无密码登陆，到mysql.user 表，修改authenticatestring/password
6. mysql 没有连接池、优化方法 (进程池用来优化进程、子进程的创建问题)
```
mysql: mysql-proxy、cobar、atlas 
postgresql: pgbouncer、plproxy、slony 

```
7. msyql 分表方法、mata表，或者用hash对id或者name等信息进行唯一对应，也可以利用一个id发生器、或者用redis队列，定期向队列里面插入数据 

8. flush privileges; 注意开启防火墙

```
去掉密码验证插件
uninstall plugin validate_password
INSTALL PLUGIN validate_password SONAME 'validate_password.so';

GRANT REPLICATION SLAVE ON *.* TO 'repl'@'ec2-54-255-203-82.ap-southeast-1.compute.amazonaws.com' IDENTIFIED BY 'mysql';
grep 'temporary password' /var/log/mysqld.log // 查看临时密码
show slave status;
show master status;
change master to master_host='60.205.230.230', master_user='repl', master_password='mysql', master_log_file='mysql-bin.002333', master_log_pos=0;
change master to master_host='192.168.25.130', master_user='repl', master_password='mysql', master_log_file='master-bin.000002', master_log_pos=0;

flush logs; 后重新配置slave,当然存在一个问题就是主从数据不一致，这个可以percona的pt_table_sync工具结局

创建用于读取日志的数据库用户:        
 mysql>create user repl; //创建新用户        
 //repl用户必须具有REPLICATION SLAVE权限，除此之外没有必要添加不必要的权限，密码为mysql。  
 //说明一下192.168.0.%，这个配置是指明repl用户所在服务器，这 里%是通配符，表示192.168.0.0-192.168.0.255的Server都可以以repl用户登陆主服务器。当然你也可以指定固定Ip。        
 mysql> GRANT REPLICATION SLAVE ON *.* TO 'repl'@'192.168.0.%' IDENTIFIED BY 'mysql';  


my.cnf配置：  
server-id=1 //给数据库服务的唯一标识，一般为大家设置服务器Ip的末尾号  
log-bin=master-bin  
log-bin-index=master-bin.index
binlog_checksum=none

缺东西：  
# binlog-do-db=amoeba_study #用于master-slave的具体数据库#设置二进制日志记录的库           
# binlog-ignore-db=mysql        ##设置二进制日志不记录的库  
# sync_binlog=1      作用：
SHOW MASTER STATUS;

slave
[mysqld]  
2 server-id=2 #slave的标示  
3 relay-log=slave-relay-bin   
4 relay-log-index=slave-relay-bin.index 

```
http://www.cnblogs.com/jr1260/p/6590232.html

垂直分表可以减少io

##### mysql 配置详解
 show variables like 'log_%';

错误日志(Error Log)
2.二进制日志(Binary Log & Binary Log Index)
3.通用查询日志(query log)
4.慢查询日志(slow query log)
5.Innodb的在线 redo 日志(innodb redo log)
6.更新日志(update log)
log=/var/log/mysqld_common.log
log-error=/var/log/mysqld_err.log
log-bin=/var/log/mysqld_bin.bin

mysqlbinlog d:/mysql_log/mysql_bin.000001

mysql 热备（双主），以及redis的主从
http://blog.csdn.net/yangzhenzhen/article/details/8512292


卸载apt-get remove msyql-common时，这些居然也被删了
Removing postgresql-9.3-postgis-2.1 (2.1.2+dfsg-2ubuntu0.1) ...
Removing postgis (2.1.2+dfsg-2ubuntu0.1) ...
Removing libgdal1h (1.10.1+dfsg-5ubuntu1) ...
Removing php5-mysql (5.5.9+dfsg-1ubuntu4.21) ...

安装mysql 
sudo apt-get install mysql-server

以下这两不用运行也会自动安装
sudo apt-get install mysql-client
sudo apt-get install php5-mysql(安装php5-mysql是将php和mysql连接起来 )
