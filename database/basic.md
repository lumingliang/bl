###### 数据库
1. acid atomicity consistency isolation durability
2. ddl database define language
3. tps transaction process system
4. qps 每秒钟处理的事务/request数量
5. 并发数，同时处理的request 数量
6. 并发数=QPS * 平均响应时间
QPS（TPS）= 并发数/平均响应时间    或者   并发数 = QPS*平均响应时间
        一个典型的上班签到系统，早上8点上班，7点半到8点的30分钟的时间里用户会登录签到系统进行签到。公司员工为1000人，平均每个员上登录签到系统的时长为5分钟。可以用下面的方法计算。
QPS = 1000/(30*60) 事务/秒
平均响应时间为 = 5*60  秒
并发数= QPS*平均响应时间 = 1000/(30*60) *(5*60)=166.7
http://blog.csdn.net/wind19/article/details/8600083

###### 数据库必会
1. 数据结构
2. 原理、架构
3. 使用
4. 配置
5. 优化、错误处理
mysql 优化http://www.cnblogs.com/musings/p/5913157.html
http://blog.csdn.net/nightelve/article/details/17393631
mysql存储引擎 http://www.cnblogs.com/xujishou/p/6343431.html


###### 去重sql语言
select * from car_tire_spec a where not exists (select 1 from car_tire_spec where a.tire_spec=tire_spec and
 a.series_name = series_name and a.id <id);

数据实现原理，explain，多路io复用
