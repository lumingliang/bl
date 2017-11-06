##### 用户与用户组
0. 语言本地化
//export LANG=zh_CN.gbk
export LANG=zh_CN
LC_CTYPE="zh_CN.gbk"

/etc/passwd保存用户id等信息，因为安全问题真正的密码已经分离放到/etc/shadow中，里面记录了真的加密过的密码，以及该密码的有戏哦时间等   /etc/group 保存用户组id等; /etc/passwd 保存用户id对应的基本信息，里面对应好了user 和 group id，以及保存了该用户的一些基本信息，密码分开在/etc/shadow中
*登陆流程*
1. 先找寻 /etc/passwd 里面是否有你输入的账号？如果没有则跳出，如果有的话则将该账号对应的 UID 与 GID (在 /etc/group 中) 读出来，另外，该账号的家目录与 shell 配置也一并读出；

2. 再来则是核对口令表啦！这时 Linux 会进入 /etc/shadow 里面找出对应的账号与 UID，然后核对一下你刚刚输入的口令与里头的口令是否相符？

3. 如果一切都 OK 的话，就进入 Shell 控管的阶段啰！

useradd -u 指定小于500 即系统账号 ，useradd时可能会发生Creating mailbox file:因为默认会在邮箱内做一些事情
userdel -r 删除某个账号
passwd 改变当前账户密码
** linux 中判断一个命令是否能执行成功的前提是权限，需要考虑的是当前是什么用户、要执行什么文件，该用户是否有执行权限
```
1. 假设有个组是g1，你想创建一个用户zs，创建之后这个用户zs就属于g1，可以使用以下命令：
useradd -G g1 zs 或者
useradd -g g1 zs
没错，一个是大写G，一个是小写g，不同的是，使用大写，那么意思是新建的用户zs同时属于自己的zs组，也属于g1组，而小写g的意思就是zs只属于g1组。
2. 假设有个组是g1，现在已经有一个用户zs，现在想更改zs的组，可以使用:
usermod -g g1 zs 或者
usermod -G g1 zs
大小写的意思同上。

```
也可以直接加group名到/etc/group中指定的地方
/etc/ssh/sshd_config PasswordAuthentication no禁止密码登陆
service sshd restart



4. 每一个进程程序启动后，都会自己进入一个系统账号在后台运行，如php-fpm 以www运行，这样就可以自动操作具有该权限的目录

5. ps -ef  查看所有进程的具体信息
6. kill pid  kill -INT pid 杀死所有pid进程，并且所有该pid的子进程

7. 两次tab键，查看可用命令
8. 防火墙/etc/init.d/iptables status查看防火墙状态
9. iptables -L -V 查看防火墙规则和状态[参考](http://blog.csdn.net/zhangzhizhen1988/article/details/8105386)设置防火墙规则
netstat -an | grep 23 (查看是否打开23端口)
/sbin/iptables -I INPUT -p tcp --dport 80 -j ACCEPT
/sbin/iptables -I INPUT -p tcp --dport 22 -j ACCEPT
/sbin/iptables -I INPUT -p tcp --dport 3306 -j ACCEPT
然后保存：
/etc/rc.d/init.d/iptables save
 
查看打开的端口：
 /etc/init.d/iptables status

10. netstat -lnp查看进程和端口关联状态
11. sockect = ip:port
**ip**详解
1. ip = 网络号+主机号，ip + 掩码与运算即可获取网络号，ip+掩码的精简形式是: ip/32 表示多少个8如4个8表示255.255.255.255，用精简形式还可以做ip规则匹配，另外网关是一个重要的东西
2. ipv6用128位表示，每处分16位:分隔
http://blog.csdn.net/yxwmzouzou/article/details/46643609
```
# uname -a # 查看内核/操作系统/CPU信息   或者cat /etc/redhat-release  
# head -n 1 /etc/issue # 查看操作系统版本 
# tail -n 100 file 获取最后十行
# cat /proc/cpuinfo # 查看CPU信息 
# hostname # 查看计算机名 
# lspci -tv # 列出所有PCI设备 
# lsusb -tv # 列出所有USB设备 
# lsmod # 列出加载的内核模块 
# env # 查看环境变量资源 
# free -m # 查看内存使用量和交换区使用量 
# df -h # 查看各分区使用情况 
# du -sh <目录名> # 查看指定目录的大小 
# grep MemTotal /proc/meminfo # 查看内存总量 
# grep MemFree /proc/meminfo # 查看空闲内存量 
# uptime # 查看系统运行时间、用户数、负载 
# cat /proc/loadavg # 查看系统负载磁盘和分区 
# mount | column -t # 查看挂接的分区状态 
# fdisk -l # 查看所有分区 
# swapon -s # 查看所有交换分区 
# hdparm -i /dev/hda # 查看磁盘参数(仅适用于IDE设备) 
# dmesg | grep IDE # 查看启动时IDE设备检测状况网络 
# ifconfig # 查看所有网络接口的属性 
# iptables -L # 查看防火墙设置 
# route -n # 查看路由表 
# netstat -lntp # 查看所有监听端口 
# netstat -antp # 查看所有已经建立的连接 
# netstat -s # 查看网络统计信息进程 
# ps -ef # 查看所有进程 
# top # 实时显示进程状态用户 
# w # 查看活动用户 
# id <用户名> # 查看指定用户信息 
# last # 查看用户登录日志 
# cut -d: -f1 /etc/passwd # 查看系统所有用户 
# cut -d: -f1 /etc/group # 查看系统所有组 
# crontab -l # 查看当前用户的计划任务服务 
开机启动配置
# chkconfig –list # 列出所有系统服务 
# chkconfig –list | grep on # 列出所有启动的系统服务程序 
chkconfig 服务名 on 服务名需在/etc/init.d 中有755权限
# rpm -qa # 查看所有安装的软件包
lsof 查看被使用的文件

```
```
lsof `which httpd` //那个进程在使用apache的可执行文件
lsof /etc/passwd //那个进程在占用/etc/passwd
lsof /dev/hda6 //那个进程在占用hda6
lsof /dev/cdrom //那个进程在占用光驱
lsof -c sendmail //查看sendmail进程的文件使用情况
lsof -c courier -u ^zahn //显示出那些文件被以courier打头的进程打开，但是并不属于用户zahn
lsof -p 30297 //显示那些文件被pid为30297的进程打开
lsof -D /tmp 显示所有在/tmp文件夹中打开的instance和文件的进程。但是symbol文件并不在列

lsof -u1000 //查看uid是100的用户的进程的文件使用情况
lsof -utony //查看用户tony的进程的文件使用情况
lsof -u^tony //查看不是用户tony的进程的文件使用情况(^是取反的意思)
lsof -i //显示所有打开的端口
lsof -i:80 //显示所有打开80端口的进程
lsof -i -U //显示所有打开的端口和UNIX domain文件
lsof -i UDP@[url]www.akadia.com:123 //显示那些进程打开了到www.akadia.com的UDP的123(ntp)端口的链接
lsof -i tcp@ohaha.ks.edu.tw:ftp -r //不断查看目前ftp连接的情况(-r，lsof会永远不断的执行，直到收到中断信号,+r，lsof会一直执行，直到没有档案被显示,缺省是15s刷新)
lsof -i tcp@ohaha.ks.edu.tw:ftp -n //lsof -n 不将IP转换为hostname，缺省是不加上-n参数
```

###### 常用命令
1. env 查看所有环境变量
2. rpm -ivh jdk 默认安装在/usr/java中
3. linux 脚本登陆的执行过程
```
在 刚登录Linux时，首先启动 /etc/profile 文件，然后再启动用户目录下的 ~/.bash_profile、 ~/.bash_login或 ~/.profile文件中的其中一个，执行的顺序为：~/.bash_profile、 ~/.bash_login、 ~/.profile。如果 ~/.bash_profile文件存在的话，一般还会执行 ~/.bashrc文件。因为在 ~/.bash_profile文件中一般会有下面的代码：
```
4. yum install lrzsz rz sz 传输文件
5. 常用环境变量
```
ATH 决定了shell将到哪些目录中寻找命令或程序 
HOME 当前用户主目录 
HISTSIZE　历史记录数 
LOGNAME 当前用户的登录名 
HOSTNAME　指主机的名称 
SHELL 当前用户Shell类型 
LANGUGE 　语言相关的环境变量，多语言可以修改此环境变量 
MAIL　当前用户的邮件存放目录 
PS1　基本提示符，对于root用户是#，对于普通用户是$
hostname [name] 查看/设置主机名
和主机相关变量
vim /etc/rc.d/init.d/network restart  
vim /etc/sysconfig/network
vim /etc/hosts

find $1 -name "*.html" -mtime +1 -print0 |xargs -0 rm -v
find /usr/local/backups -mtime +10 -name "*.*" -exec rm -rf {} \;
ls  -al --time-style=+%D | grep 'date +%D'
```

awk 可以一行一行处理数据，不用内存泄露
http://www.cnblogs.com/xudong-bupt/p/3721210.html

# 查看linux的配置信息
http://www.cnblogs.com/ggjucheng/archive/2013/01/14/2859613.html

ssh 无法连接有可能是登不上的原因
因为ssh没启动
配置sshd_config 实现免root登陆
配置visudo 使得用户有root功能

centos 编译安装通常首先需要安装各种依赖以及各种devel 包
yum -y update
yum groupinstall -y development
yum install -y zlib-dev openssl-devel sqlite-devel bzip2-devel

// 有关centos从服务器版安装的初始化工作
http://kerry.blog.51cto.com/172631/600590/

开机启动
sudo vi /etc/rc.local

两个管理服务的命令
service 
chkconfig --list  

启动windos NFS客户端服务:
1. 打开控制面板->程序->打开或关闭windows功能->NFS客户端
勾选NFS客户端,即开启windows NFS客户端服务.
2.win+R->cmd
mount 192.168.1.10:/home/用户/share X:

http://www.centoscn.com/image-text/config/2015/0111/4475.html

##### 主机间随便登陆
编辑统一版的.ssh/config
复制.ssh文件到各个主机,更改权限
修改hostname
vim 修改了/etc/sysconfig/network下的HOSTNAME后，然后使用sysctl kernel.hostname命令使其立即生效
方法3：修改了/etc/sysconfig/network下的HOSTNAME后，然后使用hostname命令使其生效
[root@Test ~]# hostname DB-Server

##### 配置网络
vi /etc/sysconfig/network-scripts/ifcfg-eth0
service network restart

##### 文件同步
跨服务器复制
cd /tmp/dep && rsync -rltgoDzvO -e 'ssh -p22 -i /home/ubuntu/.ssh/id_rsa'   /tmp/dep-1df7a03016d7368ee2d672f2ad00e9ce/ 'ubuntu@119.29.37.172:/var/www/official//'
