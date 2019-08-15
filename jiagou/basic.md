###### php应付高并发
1. 采用redis，或其他东西做一个队列层，并采用一个循环不断从队列中取出数据。
[参考](http://blog.csdn.net/lz0426001/article/details/51441771)
2. php + redis 队列 + crontab
[crontab使用](http://blog.csdn.net/leafgw/article/details/50800153)。分 时 天 月 星期 脚本
3. mysql 高并发时，应列入队列，批量插入。同时用事务会比一条条插入要快。
4. redis 主要有字符串(计数器、key-value存储)、哈希表（字典、json）、列表（队列）、集合（唯一性，交集）、可排序集合（分数、权重、排行榜）。
5. 灵活使用redis的数据结构设计key-value
6. 静态资源的部署，Md5取摘要，开启浏览器缓存，先部署静态资源到cdn，再部署页面。(注意部署间隔时期旧用户有浏览器缓存的和新用户没有浏览器缓存的看到的结果不一样)，于是采用非覆盖式部署方法，即对文件的命名使用摘要值，这样每发布一个文件就是新的文件，不会覆盖原来的文件。先全量部署资源，再部署页面即可

用webpack等工具可以在打包的时候对css、img等资源重新定义改路径到cdn上
也可以为不同的资源放在不同cdn域名上
7. 静态资源用webpack打包压缩后，变成每个页面一个bundle的形式，每个页面用一条语句引入特定的资源即可。页面缓存可以由php设置，静态资源缓存必须由服务器配置，如ngnix。配置好后，资源将会在客户端加入缓存头

比如Nginx后面有一台Tomcat服务器,项目部署在Tomcat服务器,Nginx把所有请求都proxy_pass转发给这台Tomcat服务器,Tomcat返回数据给Nginx,如果Nginx配置了proxy_cache,Nginx就会根据配置把Tomcat返回的js/css/img缓存到Nginx所在服务器的文件系统(proxy_cache_path)中.
```
http://blog.csdn.net/simongyley/article/details/23353619
http://blog.csdn.net/u012236238/article/details/53156792
实用nginx配置
http://www.cnblogs.com/phphuaibei/archive/2011/09/27/2192817.html

英文版配置
https://serversforhackers.com/nginx-caching
```
8. 文件系统，nfs文件系统共享配置

###### 负载均衡和缓存
1. 从前端到后端，逐渐减流
2. 浏览器-dns轮询-nginx反向代理-website('站点前端')-website services('站点后端')-db
3. 以上均是一对多关系
4. db中可以简单的采用hash方式，对于每一个用户都指定到唯一的数据库和前缀表
5. 缓存也是从前端到cdn再到数据库逐渐缓存
6. 浏览器缓存、代理服务器缓存、服务器负载均衡（session统一化）、分库分表、垂直拆分业务


###### 架构控制大并发
1. 要求实时就要负载均衡、缓存、以及用分布式
2. 要求耗时任务处理就要用sub pub后台慢慢处理
3. 消息队列可以用来做应用层解耦、每个模块系统各司其职，但又通过队列互相通信
4. mq使用场景http://www.cnblogs.com/HigginCui/p/6478613.html
5. redis 应用场景http://os.51cto.com/art/201107/278292.htm
6. socket通讯的分布式跟普通网站一个原理，ip_hash到各台服务器、并用redis保存共同信息，以及注意用消息队列给多个主机间交互通讯
http://www.cnblogs.com/php5/p/5253979.html
http://blog.csdn.net/kelong_xhu/article/details/50846483
7. 

##### 分布式方法
http://blog.csdn.net/chunlongyu/article/details/52431200
负载均衡
分布式缓存
分布式文件系统/CDN
分布式RPC
分布式数据库/Nosql
分布式消息中间件
分布式session问题，采用redis session，如果机器上不存在则从redis上找，和重新创建，cookie中保存有session的标号信息，cookie多站点共享一种是域名，一种是通过重定向

##### 数据库分布式
acid 原子性（Atomicity）、一致性（Consistency）、隔离性（Isolation）、持久性（Durability）。一个支持事务（Transaction）的数据库，必须要具有这四种特性

oltp 联机（在线事务处理）、olap在线分析处理


ha 高可用，
主从：从平时不用出事用 从(stanby)
主主：存在冲突问题，可以用任一时候只写一台服务器方法，主键可以设定偏移
 uuid 唯一id可以用php生成 https://www.cnblogs.com/buffer/p/3237483.html
 mysql keepalive 监测宕机

 http://blog.csdn.net/clz1314521/article/details/51695200
 http://blog.csdn.net/sanjay_f/article/details/48916171

 分布式后，每个节点最好都有一个standby备份一下

##### psql分布式
用psql-xl
gtm 全局事务管理模块，接收所有的事务处理请求，可以配置一个gtm proxy集中处理，也可以配置一个standby
Coordinator 协调器负责决定存储哪个节点
datanode 数据节点



##### 语义化版本
4.3.1 4是不向下兼容，3是向下兼容加入功能 1 是向下兼容修复问题


##### 什么是SELinux？
目的在于明确的指明某个进程可以访问哪些资源(文件、网络端口等)。强制访问控制系统 的用途在于增强系统抵御 0-Day 攻击(利用尚未公开的漏洞实现的攻击行为)的能力。所以它不是网络防
举例来说，系统上的 Apache 被发现存在一个漏洞，使得某远程用户可以访问系统上的敏感文件(比如 /etc/passwd 来获得系统已存在用户) ，而修复该安全漏洞的 Apache 更新补丁尚未释出。此时 SELinux 可以起到弥补该漏洞的缓和方案。因为 /etc/passwd 不具有 Apache 的 访问标签，所以 Apache 对于 /etc/passwd 的访问会被 SELinux 阻止。 相比其他强制性访问控制系统，SELinux 有如下优势：

vim /etc/selinux/config


###### 并发
用锁的方法解决并发，确保原子操作
1. 将字段改为非负数值,对于php层-1的有效
2. 使用redis队列，需解决队列存满问题
3. 使用悲观锁，先加锁，禁止其他进程操作，后解锁
4. 乐观锁，使用版本号策略，被别人改了就回滚，有reids的watch
5. 文件锁

###### 消息队列
作用是 控制高并发、先存入消息队列快速响应，后面异步存入数据库
业务解耦
