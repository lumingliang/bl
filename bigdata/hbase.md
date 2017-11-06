##### hbase是一种列式存储数据库，一个表包括多个列族，每个列族都有自己的rowkey、timestamp，一个列族里面有多个列，这些列式非结构化的，尽量在设定结构时让所有列都分布在一个或者有限的列族里面。

当行数增多后，一个列族里面的所有行会分布在各个region server中，每个regison server有多个store，每个store只能存一个列族的数据，一个store包括memstore和storefile，storefile又会分裂和合并为一个大的storefile。这些storefile底层按照hadoop规则存在于hdfs中

需要查询一个数据时，需要三级跳，首先查zookeeper，得到__ROOT__表的region位置，然后在__ROOT__表中根据表名和rowkey 查询对应的.META.表再哪个region中，__ROOT__中每一行就是保持.META.中的ip和对应的表名等，再到该.META.  region中用table name rowkey查到对应的存放数据的region

大数据面试题：http://blog.csdn.net/haohaixingyun/article/details/52819563

hbase和hive的区别：hbase要用hbase的语言来操作，hive是yong HQL对hdoop的操作，两者都可以达到对数据进行方便操作的目的，但是hive更擅长是分析，hbase擅长存储

##### hbase常用ddl
http://blog.csdn.net/scutshuxue/article/details/6988348
该博客还有描述pgsql常用的方法
