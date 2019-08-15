title: mongoDB 的使用和学习
----
### 安装
1. 安装前应该修补win7bug，下载Windows 7/Windows Server2008 R2 SP1
2. [下载地址](http://www.myfiles.com.cn/soft/0/131.htm)
3. 由于文件过大，算了，直接使用，如果需要，安装在linux即可

4. ubuntu 下二进制安装.[官网](https://docs.mongodb.org/getting-started/shell/installation/)
5. curl -o /url/to/download 
6. tar zxvf 解已经存在压
7. export PATH=<mongodb-install-directory>/bin:$PATH   //添加环境变量
8. mkdit /data/db
9. mongod --dbpath <path to data directory>  // 指定数据的保存路径启动mogondb/

### 引入文件到数据库中
#### 检索数据集 restaurants data
1. 下载实例文件到本地 wget /http/.json
#### 引入本地文件到数据库
```
mongoimport --db test --collection restaurants --drop --file primer-dataset.json

```

mongoimport 命令，还可以指定要连接md数据库的端口和地址，默认为本地和port
1. primer-dataset.json,为本地文件路径
2. test 为数据库名，
3. restaurants 类似一个数据表 collection, 是一个类似数据表的结构
4. --drop ,删除，也就是如果存在就不保存了

### 使用md的shell客户端
#### mongo 是自带的js本地客户端，可以像shell和emacs一样使用tab补全，和查看历史
#### help ,在mongo下type help可以查看帮助


### collection ,所有数据在md中都有一个scope,附在单一的collection上
#### collecton ,相当于一个文件名，文件名内保存着所有属于该文件的数据，想象md就是一个庞大的键值
对应，每个数据库有多个collection，每个collection都是主scope，所有scope下的数据就是该colletion的

#### collection ,集合，有点类似有序数组，但里面是json值
```
db.restaurants.find() //查询restaurants 这个collection下的所有数据

### 索引的原理与应用

1. 索引就像一本词典的形式，当我们拿到一个单词word，需要查找它在哪一页，这时，就需要查看目录，也就是根据单词的首字母来一个个逐一确定它在哪
2. 在储存器中，所有数据都是用单元来表示的，在物理结构上，每一个单元都是独立，也就是同一份文件，在储存器中保存可以有很多个块组成，只是，每个快的尾都连着下一个块的首的地址，所以就能通过找到第一个快的地址来找出整个文件的内容
3. 对于电脑来说，知道了地址就等于知道了一切，获取某一个地址的内容，只需要一步
4. 在数据库中，每一个库都有一个统一的片单元，比如是1024字节，每一个表的每一行都有一个数据类型，每一个类型都有一个确定的大小，假如一行有5个字段，每一个字段平均是50字节，那么一行就需要250个字节，那么数据库的一个片就可以得到4到5行数据。如果有1000行数据，就需要200个块
5. 也就是说，如果需要查找出现name = lumin 的这一行，需要查找200个数据块，如果是按顺序来找的话，就需要200次
6. 建立索引，就是在name 一个字段上，建立一个到字段为排序后的name值和该name所在行地址的新的索引表，当要查询时候，因为已经排序了，(在电脑中，任何文字符号都是ASCI码),都可以进行排序，就可以用二分法查询，即从中间开始，比较要查的在哪一边，然后继续向下查找，也就是2叉树，一共要查log2 200,次，等于8次不到，当数据量很大时候，这个就更明显了
7. 建立索引的关键是排序与唯一，但是每次有新的插入，索引就会发生变化，有时候变化很大，这个需要时间的，但好处是，查询性能高
8. These indexes allow applications to store a view of a portion of the collection in an efficient data structure.


### mongoDB的优点	 
1. 键值架构，相当于json的扩展，值可以是数组，甚至是嵌入的文档，
2. 强大的可伸缩性，数据很容易部署在主从，副本服务器上，还有读写分离等

### 两大要素
1. 集合对应表
2. 文档(document)对应行

### 读操作
1. md读取检索数据从一个单一的colletion
2. 一个查询就相当于一个映射projection，映射对应要查文档中的指定域fields,这个映射决定了从collection中取出哪几个字段fields
3. 查询情况条件，就是criteria
4. 通过设定criteria 和projection 两个限定，就可以得到想要的数据
5. 查询后返回一个cursor，可以通过cursor设定limit，也就是限定多少条拿出来，这种操作称为modify,

#### db.collection.find( { age: { $gt: 18 } }, { name: 1, address: 1 } ).limit(5)  
1. find() 有两个参数，一个是criteria ,一个是projection, 最后返回cursor给limit，skips,sort orders 使用
2. { name:1 ,address:1 } ,表示拿出这两个fields，若_id:0 ,则不取出id

#### de.collection.update({'name':'value'} , {'update document associate to name:value'});
1. 整体更新，var model= db.collection.findOne({'criteria'}); model.name='value'; --.update({'criteria'},model);  //这种更新不仅可以更新原有 fields，还可以加入新的fields
2. 局部更新 ,db.col.update({'criteria'} , {$inc:{age:10}}) 可以原子操作;
	2.1 $set 局部修改, db.col.update({'criteria'} , {$set:{'newfield':'value'}});

3.upseted ,当没有满足update的查询情况的时候，就新增, 改第三个参数为 true
	db.user.update({'name':'waite'},{$set:{'age':3443}},true)
4. 



#### db.collection.insert({'name':'new document associate to this collection'});

#### 索引 
```
function go() {
	for(var i=0;i<1000;i++) {
	db.person.insert({'name':'lumin'+i , 'age' : i});
	}
}
```
1. 上面的记录很多十万条，连插入的时候，在服务器上测试了很久，还是没插入成
2. 为一个fields 为name 建立索引，db.col.ensureIndex({'name':1});
3. 建立唯一索引，唯一索引要求该fields中的值不能重复
	db.person.ensureIndex({"name":1},{"unique":true})
4. 建立组合索引，对于多条件查询，比如查询90年 出生的name同学，可以在年龄和name两个field间建立组合索引
	db.person.ensureIndex({'name':1,'birthday':1})
	db.person.ensureIndex({'birthday':1, 'name':1})
	这里会产生两个索引，因为两个字段的排序，
5. 删除索引 
#### [索引参考,博客](http://www.cnblogs.com/huangxincheng/archive/2012/02/29/2372699.html)


### source 安装，需要scons
1. scons是一个现代化的有依赖管理能力的替代make的一个编译工作，用python编写，需要python2.7
2. scons 安装及下载[官网](http://sourceforge.net/projects/scons/files/scons/2.4.1/)
3. scons all //安装全部组件，包括mongo mongos mongod
4. scons



```
use test
// 查找所有
db.restaurants.find()
// 查找拥有指定域和指定值
db.restaurants.find( { "borough": "Manhattan" } )
// 多级查找
db.restaurants.find( { "address.zipcode": "10075" } )
// 类似

{
"grades" : [

         {
            "date" : ISODate("2014-10-01T00:00:00Z"),
            "grade" : "A",
            "score" : 11
         },
         {
            "date" : ISODate("2014-01-16T00:00:00Z"),
            "grade" : "B",
            "score" : 17
         }
      ]
}
//即有内嵌数组，数组里面任然是文档,直接如下，得到拥有b的所有级别（只要有数组的内嵌文档有一行拥有即可）

db.restaurants.find( { "grades.grade": "B" } )

// 指定查询运算条件
{ <field1>: { <operator1>: <value1> } }
// 查找拥有大于30的内嵌文档
db.restaurants.find( { "grades.score": { $gt: 30 } } )
db.restaurants.find( { "grades.score": { $lt: 10 } } )

// 多条件查询，与
db.restaurants.find( { "cuisine": "Italian", "address.zipcode": "10075" } )

db.restaurants.find(
   { $or: [ { "cuisine": "Italian" }, { "address.zipcode": "10075" } ] }
)

// 排序
db.restaurants.find().sort( { "borough": 1, "address.zipcode": 1 } )


// 更新，默认只更新一条，可以加入参数更新多条符合条件的文档
db.restaurants.update(
    { "name" : "Juni" },
    {
      $set: { "cuisine": "American (New)" },
      $currentDate: { "lastModified": true }
    }
)

db.restaurants.update(
  { "restaurant_id" : "41156888" },
  { $set: { "address.street": "East 31st Street" } }
)

db.restaurants.update(
  { "address.zipcode": "10016", cuisine: "Other" },
  {
    $set: { cuisine: "Category To Be Determined" },
    $currentDate: { "lastModified": true }
  },
  { multi: true}
)


// 每个集合内的每行文档相互独立，没有严格的key value格式限定，但是每一行文档的id是不变得
// 更新整个行，这里整个行的文档的格式会变成以下
db.restaurants.update(
   { "restaurant_id" : "41704620" },
   {
     "name" : "Vella 2",
     "address" : {
              "coord" : [ -73.9557413, 40.7720266 ],
              "building" : "1480",
              "street" : "2 Avenue",
              "zipcode" : "10075"
     }
   },
//   { upsert: true } ,指定为true后，如果能找到匹配的就完全更新，否则插入新的一行文档
)

// 删除所有符合条件
db.restaurants.remove( { "borough": "Manhattan" } )
//只删除一行符合条件
db.restaurants.remove( { "borough": "Queens" }, { justOne: true } )
//操作成功后返回如下对象
WriteResult({ "nRemoved" : 1 })

//删除整个集合 的所有文档,但仍有剩余
db.restaurants.remove( { } )
The collection itself, as well as any indexes for the collection, remain.

// 彻底删除
db.restaurants.drop() 返回true

In MongoDB, write operations are atomic on the level of a single document. If a single remove operation removes multiple documents from a collection, the operation can interleave with other write operations on that collection. In the MongoDB Manual, see Atomicity.

// 聚合，聚合是指分组，类似管道的操作

// 每个stage相当于一个管道，前面的管道执行结果作为后一个管道的输入
db.collection.aggregate( [ <stage1>, <stage2>, ... ] )

// 将集合的文档行按照borough字段的值分组，并排序,输出会得到_id和count(count字段不一定要在文档行中，应该是统计后的输出字段)字段
db.restaurants.aggregate(
   [
     { $group: { "_id": "$borough", "count": { $sum: 1 } } }
   ]
);
	
// 先限定查询条件，再聚合处理（分组、统计）
db.restaurants.aggregate(
   [
     { $match: { "borough": "Queens", "cuisine": "Brazilian" } },
     { $group: { "_id": "$address.zipcode" , "count": { $sum: 1 } } }
   ]
);

// 索引,每个集合自动有_id字段，而且拥有递增索引

// 为集合某一个字段新增一个索引
db.restaurants.createIndex( { "cuisine": 1 } )

// 结果为
{
  "createdCollectionAutomatically" : false,
  "numIndexesBefore" : 1,
  "numIndexesAfter" : 2, //说明新增后集合中有两个索引
  "ok" : 1
}

// 增加复合索引
// 为一个字段增加递增，另一个增加递减的复合索引
db.restaurants.createIndex( { "cuisine": 1, "address.zipcode": -1 } )
```

#### mongo的clients, 负责连接到单一个的mongoDB实例，或者副本实例，或者分片集群中

#### 常用命令
原子操作类似事务，有利于保证数据的插入和完整性
1. 创建数据库 use my_db,如果没有，则新建,
2. db 查看当前数据库
3. show dbs 查看所有数据库,如果一个新建数据库是空的，则不显示
4. db.dropDatabase() 删除当前数据库,删除后，仍然处于当前数据库，只是数据为空，所以不显示
5. 插入mongodb的原始数据是 json，但是实际储存是BSON, 它是一种类json的二进制形式
6. 更新，db.col.update( { "count" : { $gt : 1 } } , { $set : { "test2" : "OK"} } ) , $set为原子操作符，如果原集合中存在该文档对应的key "test2"则更新,如果没有该字段，不做任何
7. 更新中如果用 db.col.update( { "count" : { $gt : 5 } } , { $set : { "test5" : "OK"} },true,true ); ,后面两ture指的是 upsert  <boolean> , multi: <boolean>,,upsert为真如果匹配不成功，则新增一行文档，multi为真则是可以同时修改多行匹配条件的
8. db.col.save({'name': 'value'}) 新增一行文档
9. db.col.save({'_id': objectId('fkdsjf')}, 'something': 'new') 如果save方法指定了_id则会在该行文档修改 
db.col.update({'name': 'v'} , {'some': 'new'}) 这里会直接替换掉匹配的行，因为没有了$set的原子操作，所以会更新
10. db.col.update( { "count" : { $gt : 10 } } , { $inc : { "count" : 1} },false,false ); $inc为数字类型数据的原子操作
11. db.col.find().pretty() 以漂亮的格式显示查询结果 
12. and or的联合使用db.col.find({"somekey": {$gt:50}, $or: [{"by": "菜鸟教程"},{"title": "MongoDB 教程"}]}).pretty()
13. db.col.find({likes : {$lt :200, $gt : 100}}) ,查找大于100小于200
14. $type操作符，丰富了查询的限定条件，$type的值代表着某个字段的值得数据类型，如$type: 1代表着Double类型db.col.find({"title" : {$type : 2}}), string类型
15. db.col.find({},{"title":1,_id:0}).limit(2)  限定只得到两条河条件的数据
16. db.col.find({},{"title":1,_id:0}).limit(1).skip(1)  跳过符合条件的第一条数据，这里将获得第二条 （应该是按照插入顺序，即_id排序)
17. db.col.find({},{"title":1,_id:0}).sort({"likes":-1}) , 查询结果只显示title字段， _id如果不手动设定为0都会附带的, sort方法这里按照 likes (-1降序排序
18.  db.values.ensureIndex({open: 1, close: 1}, {background: true}) . 创建复合索引，并加参数在后台运行（不阻塞进程)

19. db.posts.find({post_text:{$regex:"w3cschool.cc",$options:"$i"}}) 正则表达式的查找，设定$i为忽略大小写
20. db.posts.find({tags:{$regex:"tutorial"}}) ,tags字段的内容为数组，可以查找拥有tutorial的标签的数据
21. title:eval("/"+title+"/i")    // 等同于 title:{$regex:title,$Option:"$i"} 类似模糊查询


22. id是一种分布式的id，要根据id批量删除时，要用比较方法，因为id是与时间戳相关，db.drive.remove({_id:{$gt:ObjectId("5d39863d76dab53cb9696f87")}})
