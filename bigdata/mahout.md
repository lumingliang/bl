##### 配置环境

3.1、配置Mahout环境变量
# set mahout environment
export MAHOUT_HOME=/home/yujianxin/mahout/mahout-distribution-0.9
export MAHOUT_CONF_DIR=$MAHOUT_HOME/conf
export PATH=$MAHOUT_HOME/conf:$MAHOUT_HOME/bin:$PATH
3.2、配置Mahout所需的Hadoop环境变量
 # set hadoop environment
export HADOOP_HOME=/home/yujianxin/hadoop/hadoop-1.1.2 
export HADOOP_CONF_DIR=$HADOOP_HOME/conf 
export PATH=$PATH:$HADOOP_HOME/bin
export HADOOP_HOME_WARN_SUPPRESS=not_null

http://itindex.net/detail/51681-mahout
