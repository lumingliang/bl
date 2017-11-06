##### 大数据hadoop基础
1. map, reduce: map 将输入处理成key、value形式；reduce，将map作为输入，同时内部会将map中的key、value进行归类。并将归类后的唯一key、vlues传入reduceer
2. cdh 版本与普通版本区别，cdh是支持yum等方式安装的，它是由一个公司支持的，apache是最原始版
3. 安装，下载h2.8 解压后，先配置etc/hadoop/hadoop-env.sh JAVA_HOME,然后设定本地put使其可以本地登陆
```
ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
  cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
  chmod 0600 ~/.ssh/authorized_keys
```
 配置core-site.xml，注意配置文件系统临时根目录
 ```
<configuration>
    <property>
        <name>hadoop.tmp.dir</name>
        <value>file:/root/java/tmp</value>
    </property>
    <property>
        <name>fs.defaultFS</name>
        <value>hdfs://localhost:9008</value>
    </property>
</configuration>

 ```
 hdfs-site.xml
 ```
<configuration>
    <property>
        <name>dfs.replication</name>
        <value>1</value>
    </property>
  <property>
        <name>dfs.namenode.name.dir</name>
        <value>file:/root/java/tmp/dfs/name</value>
  </property>
  <property>
        <name>dfs.datanode.name.dir</name>
        <value>file:/root/java/tmp/dfs/data</value>
  </property>
</configuration>

 ```
 [参考](http://blog.csdn.net/ehcoing/article/details/70325255)
 开启调度器yarn

mv ./etc/hadoop/mapred-site.xml.template ./etc/hadoop/mapred-site.xml
 ```
<configuration>
        <property>
             <name>mapreduce.framework.name</name>
             <value>yarn</value>
        </property>
</configuration>
 ```
 vim  ./etc/hadoop/mapred-site.xml
 ```
<configuration>
        <property>
             <name>yarn.nodemanager.aux-services</name>
             <value>mapreduce_shuffle</value>
            </property>
</configuration>
 ```

4. 配置步骤，配置项目包括，进程配置hadoop有多个进程，集群配置等
-配置ssh互相登陆，注意主机名应用英文开头，并配置hosts映射
运行自动复制脚本
http://www.powerxing.com/install-hadoop-cluster/
http://www.powerxing.com/install-hadoop-cluster/

hdfs namenode -format force

启动
start-dfs.sh
start-yarn.sh
mr-jobhistory-daemon.sh start historyserver
mr-jobhistory-daemon.sh stop historyserver

//查看异常
hdfs dfsadmin -report

