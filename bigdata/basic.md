##### 大数据的一些基本知识
0. it界比较好的工具集：http://www.runoob.com/w3cnote/github-tools.html
数据集集合：https://github.com/caesar0301/awesome-public-datasets
1. 列储存，列储存其实也是一张非常大的表，只是它的存储方式是按照列来进行分割的，并且对每一列的数据进行压缩，即利用词典进行映射，这样保证每一列都是数字，整个表非常大，每个列的数据非常多，一般需要扫描整个列，这就需要分布式发挥了强大的作用
2. java安装配置，下载jdk.rpm包，rpm -ivh java.rpm, 目录一般会在/usr/java/下面,配置/etc/profile
```
export JAVA_HOME=/usr/java/jdk1.8.0_131
export PATH=$JAVA_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
```
3. qps : 每秒查询次数、tps：每秒事务处理次数，pv，页面访问次数
4. 全文检索http://blog.csdn.net/starshine/article/details/43758767
5. 一些有用资源下载，linux 公社http://linux.linuxidc.com/
6. 开始配置集群搞了很久，原来是网络不太通，用虚拟机复制的时候，一定要重新设置ip不然很麻烦
7. haddoop 的rootdir要跟hbase 的rootdir一样即端口值
8. **http://developer.51cto.com/art/201609/516716.htm**
9. hdfs 插件for ecplise 可以打开
10. 创建haddoop 应用步骤：1. 安装mvn, 2. 配置mvn 3. 重启构建普通mvn项目，修改pom.xml,保存让其自动下载依赖jar，新建java class ，右键export,复制到服务器。


yarn jar first.jar first.WordCountEx /tmp/input/words_01.txt /tmp/output/1007_05
11. 
12. hadoop 插件http://www.cnblogs.com/mephisto/p/4857723.html
13. http://eric-gcm.iteye.com/blog/1807468 hadoop mapreduce 经典案例 



