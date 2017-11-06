title: redis 的学习
---
### 以下是redis的入门用法

#### redis是一个运行在内存的键值对持久性数据库，仅仅通过扁平的键值结构来实现缓存或者高级大型网站的快速读写数据库
安装https://www.hugeserver.com/kb/install-redis-centos/

#### 基本用法

```

 SET name 'value'
 set name1 1
 incr name1   // -> 2
 del name  // -> integer 1 // name已经删除了
 get name1 // ->2
 expire name 100 // integer 1 // 表示操作一个数据，设定name的生存时间为100s
 ttl name // ->int 返回name的生存时间还剩多少，若已经过期（已经被删除），返回-2,若返回-1说明name这个key并没有设定生存时间 
 //若del tt返回 integer 0 ,说明这个key不存在(没有set)

 -------
 list 

 list有点类似于无键名数组['22','rr','44']
 rpush newlist 'value' //创建一个新list并往后增加一个值，
 lpush 'key' value // 往左(往前增加一个值) ,如果没有这个key 则新增一个
 lrange key index1 index2 ,根据索引从哪到哪取出list
 //如 lrange key 0 -1 //取出该key下list的全部 
 // lrange key 0 0 //取出list中第0个

** 对于很多操作，redis都是按照如果本身为空，则新增一个 **
 rpop key ,返回并删除最后一个值，
 lpop key ,返回并删除第一个值

 -----
 set  

 set 和list 的区别是，无序，而且每个值只能出现一次

 有这几个常用命令 SADD 'newset' 'value' 

 sismember 'set' value ,测试一个值是否在set中已经存在

 smembers set ,列出set中所有
 sunion set set1 合并连个set并返回合并后的所有
 srem set 'value' 删除set中某个值

 ----

#### zinter set1 set2 set3 //寻找各个set的交集

sorted set 

//有序的set，因为set是无序的，所以无法通过多少到多少取出他们，于是引入了一个score，是一个数字，用来对set中的每个值排序
zadd hackers time[可以是当前时间戳] value
zrange hackers 0 -1 // 会按照time这个score 的大小排序
zrangebyscore key min[-inf,[33 , (33   ] max withscores [limit offset count] //按照score排序
```
 ZRANGEBYSCORE salary -inf +inf WITHSCORES  limit 0 3  // 选取salary中所有数据后再limit
 ZADD myzset 0 a 0 b 0 c 0 d 0 e 0 f 0 g 
 ZRANGEBYLEX myzset - [c  //zrangebylex //按照sort set 内的元素排序 ，用法与上者类似 

 ----


 hash 

 用来模拟对象,are maps between **strings** fiels and **strings** values 

 hset user:1 name 'jj'
 hset user:1 email 'jfdj' //name 不允许和email 一样，也就是hash内的键(string files)必须唯一
 hmset user:1 name dfjjf email jfdj // 同时设定多个值
 hset user:1 password 'jfjdk'
 hgetall user:1  //返回该hash的所有数据，注意返回的形式是1)name 2)jj 3)email 4)jfdj 连贯的
 hget user:2 name  // 只取出name field 
 hset user:1 name jfdj email fjdf //一次设定多个键值

 //hset 内的元增加，为了防止两个用户同时取出一个键值，并对其修改后没达到应有的效果，对值得增加应采用元增加，
 它的原理是，一次取出后，在没有修改前它是受保护的，不能由两个动作同时取出并增值赋值
安装
 hset u:0 vists 0
 hincrby u:0 vists 1[n] //返回增加后的数值 0+n
 hdel u:0 visets 删除某个键值


 ```

 ### redis只可以根据键找出值，而不能根据值找出键，当然知道了键，并找出值，键值都有了

### 清除所有内容 	
flushall

redis bitmap 可以用来保存一系列的二进制位，利用这些0、1值以及在第几个偏移就可以实现类似对用户登陆统计的功能，如用第三位为1表示用户id=3的人登陆了，redis对bitmap类型自带了如并集、统计等功能

地理位置索引的原理其实是将区域划分、并根据划分的精度映射成一个geohash，一种hash方法是用二进制来表示，得到一串二进制数，比较两个geohash的相似程度即可实现地理位置筛选http://www.cnblogs.com/taoweiji/p/3710495.html

redis 自带geo 功能

redis分区方法，范围分区、hash分区
用一个hash函数将key转换为一个数字，比如使用crc32 hash函数。对key foobar执行crc32(foobar)会输出类似93024922的整数。
对这个整数取模，将其转化为0-3之间的数字，就可以将这个整数映射到4个Redis实例中的一个了。93024922 % 4 = 2，就是说key foobar应该被存到R2实例中。注意：取模操作是取除的余数，通常在多种编程语言中用%操作符实现。

redis 分布式

其中分布式，很多云平台都已经实现了
