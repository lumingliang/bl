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
分布式session问题
