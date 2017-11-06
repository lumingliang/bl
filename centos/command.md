重启网卡
```
/etc/init.d/network restart
service network start  
service network status
```
和网络配置有关的文件
配置网关、设定ip为静态
```
/etc/sysconfig/network-scripts/ifcfg-eth0

DEVICE="eth0"
HWADDR="00:0C:29:FD:FF:2A"
NM_CONTROLLED="yes"
ONBOOT="yes"
IPADDR=192.168.1.31
NETMASK=255.255.255.0
GATEWAY=192.168.1.1
BOOTPROTO=static
```
配置dns
```
/etc/resolv.conf 
nameserver 202.96.134.133
nameserver 8.8.8.8
```
临时配置
```
ifconfig eth0 10.1.1.10 netmask 255.0.0.0
```
寻找程序所在地方
```
whereis (在环境变量中找)
locale (利用每天更新的库)
find (查找磁盘上的任何东西，可以用正则、简写、函数等)
tar 打包
gzip 对tar后压缩
bzip2 对tar后压缩
xz
压　缩：tar -jcv -f filename.tar.bz2 file
查　询：tar -jtv -f filename.tar.bz2
解压缩：tar -jxv -f filename.tar.bz2 -C dir(欲解压缩的目录)
查看文件大小 du -h max-lengh=1
查看磁盘 df -h
```
源码安装: 配置得makefile 得了它后调用make(自动调用gcc)编译,make install 安装到指定位置
```
./configure --help 查看配置
```
如果是默认安装，会分散安装到/usr/bin usr/lib usr/share/man /etc/ 目录下 
因此为了方便管理，最好手动设定prefix，安装到/usr/local/software目录下，源码copy到usr/local/src/soft/下，然后在/etc/man_db.conf中加入一条，告诉它man目录和bin目录
.so 动态函数库
.a 静态函数库
在linux中有许多函数、函数库都是被各种程序共同使用的，于是把它放到一些目录中，以便给程序运行时调用。其中.so结尾的是动态函数库，在程序运行时载入，平时只记录它所在的位置
静态函数（库）会再编译时直接整合到了安装后的二进制文件中，优点是可以直接独立运行。不需要再次依赖。但不利于升级。
./configure 用到的--with-extension=dir 一般是用到一个包的源码库，所以一般把该路径指向该源码的lib中，当然也要看help例外
一般添加新的功能进去需要重新编译
##### linux 下的目录结构
```
/
/sbin
/home
/opt 第三方软件目录，类似d盘(需要手动)
/tmp
/mnt
/bin 系统程序ls rm 等
/var 可变的，log等文件
/etc 所有软件的默认配置都放在这个目录下 
/usr 下有/bin /lib /local/bin 类似C盘prografiles，一般软件都会默认分散安装到这里
```
##### 常用命令备份
```
删除当前目录下所有 *.txt文件，除了test.txt

rm `ls *.txt|egrep -v test.txt`
#或者
rm `ls *.txt|awk '{if($0 != "test.txt") print $0}'`
#排除多个文件
rm `ls *.txt|egrep -v '(test.txt|fff.txt|ppp.txt)'`
rm -f `ls *.log.1|egrep -v '(access-2010-09-06.log|error-2010-09-06.log)'`
rm -f `ls *.log|egrep -v '(access-2010-09-06.log|error-2010-09-06.log)'`
rm -f `ls *.log|egrep -v '(20100906.log)'`
rm `find . -name *.txt | egrep -v ‘（test.txt|fff.txt|ppp.txt)'`
egrep 是grep 的扩展，还可以使用附加的正则表示式元字符
rpm -qa | grep readline 查看是否安装有某个包
yum search readline 当缺少某个包时，如果自己解决，那就搜索一下当前是否有该包，如果有，那么全网搜索一下该包的相关包，并看具体信息决定是否增加安装

```
##### linux 生疏必要软件/命令
```
iconv 文件编码转码
```


 nohup ../yii /temp/major-group > major.out 2>&1 &
 ps -ef |grep yii

 echo $PATH 查看环境变量

