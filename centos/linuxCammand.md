title:linux命令聚集
---
### history
1. 可以使用管道，如history | more ,history | tail 
2. C+R搜索历史命令，输入关键词即可
3. !n,重复第n条命令
4. ！关键词，执行和关键词有关的所有历史命令
5. 控制历史命令总数vi ~/.bash_profile
    HISTSIZE=450
    HISTFILESIZE=450
    HISTFILE=/root/.commandline_warrior //可以修改historyfile的路径
6. 删除历史命令中连续重复的重复条目，export HISTCONTROL=ignoredups
7. export HISTCONTROL=erasedups ，删除历史命令中的重复条目
8. vi !:$ ，后者将替换为上一个历史命令的参数
9. history -c 清除所有
### file明令
```
file *
```
*查看文件的类型是什么文件，如可执行二进制和某种程序语言的源码（c++，nodejs，etc)，如果源码头没有标明#!/bin/bash等说明执行的程序类型，就是ASCII字符文件。
### 命令帮助
```
man xxxcommand
```
### 和用户相关
```
finger username
who 
who am i
su 成为root用户
sudo su //以root身份执行
sudo command //root身份执行命令
passwd 更改当前用户密码
passwd user //改某一用户密码
```

### SHELL
1. history,
2. alias //显示别称表
3. alias new_command='command' 设定新的别称
3. env //显示环境变量
4. export var = value ,设定新的环境变量var
5. df -lh 显示所有硬盘使用情况
6. mount 显示硬盘分区挂载
7. mount partition path 挂载某分区到路径
8. unmount partition 卸载分区挂载
9. sudo fdisk -l 显示所有分区
10. cat /proc/cpuinfo
11. cat /proc/meninfo //内存信息
### 网络

1. ifconfig 查看/设置网络接口和ip
2. route 显示路由表
3. netstat 显示当前网络连接状态
4. ping ip
5. host domain 寻找域名对应的ip
6. host ip 反向DNS查询
7. wget 
### 进程
1. top 显示进程
2. ps 显示shell下的进程
3. ps -lu username 显示user用户的进程
4. kill pid ，杀死pid的进程
5, 查看进程，及其对应的端口情况， netstat -tlnp //cmd版，netstat -abo
5, 查看某端口被哪个进程使用， netstat -tlnp|8000

### 文件
1. rm ,file //描述文件，chown, chmod,cat ,cat file1 file2//连接显示,cat file1 >> file2 //连接1中内容到2中，head -n file 显示file的n行，对应tail,
2. diff //对比
3. sort //排序
4. wc file 统计字符，词行数
5. find /path [-name][-size] 'reg' | [dosomthing] 
	5.1 $find /sbin /bin -name core -type f -print | xargs /bin/rm -f 
6. [参考find命令详解](http://www.cnblogs.com/wanqieddy/archive/2011/06/09/2076785.html)
7. tar -xvf xx.gz.tar ,解压并查看解压过程
8. tar -xf
9. tar -cf new.tar dir ,打包 

### 利用正则批量处理文件
1. 删除文件
# shopt -s extglob      （打开extglob模式）
# rm -fr !(file1) //删除除了file1 的文件
2. mv !(dir) dir //移动除了dir外的所有到dir
3. rm `ls | grep -v "aa"`

### 命令组合
[参考](http://blog.csdn.net/taiyang1987912/article/details/41488395)

1. ls | grep -i aa 选择对于ls得到的 过滤，过滤后得到ls中含有aa的结果
2. grep -i aa file 查找 file中含有aa的东西

### 多重shell操作

进入目录后自动显示文件
cdl() {
		cd ${1};
		ls;
}
alias cd=cdl

sed [options] '' file 命令行方式修改文件
