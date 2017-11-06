PSQL的使用等
------------
pg的设计数据库总结http://blog.csdn.net/lanonola/article/details/51330044

安装是使用yum 安装来的快
安装后的工作
##### 注意点
template1 是psql里面的模板，用来建立数据库，类似还有template0，template1可以用来当数据库连接，template0不行，在创建数据库时，使用的默认模板是template1

##### 常用命令
```
su - postgres 进入postgres的用户，postgre安装好时会默认创建一个系统用户 postgres
psql 进入psql默认呢数据库
psql test 进入test数据库

进入psql ,记得所有命令都加上;
\l 列出所以数据库
select pg_database_size('test'); 查看数据库大小
\dt 查看所有表 
```
##### 配置外网连接
```
关键是配置好

/var/lib/pgsql/9.3/data/pg_hba.conf
和
/var/lib/pgsql/9.3/data/postgresql.conf

以及打开防火墙
开启端口5432 
/sbin/iptables -I INPUT -p tcp --dport 5432 -j ACCEPT
/etc/rc.d/init.d/iptables save 保存修改
/etc/init.d/iptables status 查看状态
/etc/init.d/iptables restart 重启防火墙
也可以直接在
/etc/sysconfig/iptables加入一行
-A RH-Firewall-1-INPUT -m state –state NEW -m tcp -p tcp –dport 8080 -j ACCEPT
```
数据库备份
```

pg_dump -h localhost -U lumin test > D:/1.sql

psql -U username  databasename < /data/dum.sql
\i /sql
```

##### pg实现地理位置，用插件
http://www.cnblogs.com/strinkbug/p/5145098.html
[pg常用内置函数](http://blog.csdn.net/fred_lzy/article/details/53188082)

##### 常用命令
```
\c databasename 切换数据库
create extension cube;
create extension earthdistance;

```

##### pg 索引类型

1. gin b+-tree gist
2. 前、或后模糊查询，可以b tree 
3. 前后模糊，gin gist rum(需插件).
4. 正则 gin gist
5. 当条件精度低时，用gist ，精度高时gin，全文时用rum
6. http://mt.sohu.com/20170104/n477766782.shtml
