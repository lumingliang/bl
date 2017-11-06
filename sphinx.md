###有关sphinx的一些技术
-----
强大的全文搜索引擎
#### 安装
下载后，解压，细看里面的文件，会发现有很多必要的东西，根据需求修改一下sphinx.conf.in文件
```
1. 配置bin目录到path，查看是否win下安装了vc2008
2. // 安装服务，注意这里如果不慎会出现1067程序无法启动错误
D:\sphinx-2.2.11\share\doc\api>searchd --install --config ../sphinx.conf --servicename SphinxSearch
// 建立索引，注意指定配置文件路径，绝对路径或当前路径
D:\sphinx-2.2.11\share\doc\api>indexer -c ../sphinx.conf --all
// windows 服务
sc 命令

```
要配置sphinx.conf文件，把SQL语句放到那里面，生成相应的索引，在PHP代码里面传值到里面就会出来查询出来的结果！

##### 先mysql配置熟悉
```
 mysql -D test < D:\32\coreseek-4.1-win32\var\test\documents.sql

 使用coreseek search 测试
 echo 了 | iconv -f gbk -t utf-8 | D:\32\coreseek-4.1-win32\bin\search -c ../etc/mysql.conf --stdin | iconv -f utf-8 -t gbk
```
##### coreseek已经不再更新，现在用sphinx-for-chinese 
1. 还是常规一样做好安装，配置全局bin，修改配置文件，安装词典，安装searchd服务，php端按照官方配置好即可使用
