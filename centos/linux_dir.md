title:linux 下的目录结构
---
### Linux是一个目录结构非常合理科学的系统，有了它的完美目录结构规划，做任何事情，比如安装软件，查找资料等都显得极为方便和整整有条。
### 目录结构，由 / 下分主要分为以下几大目录
1. /bin ,bin是二进制文件，这里一般有系统的命令，如ps ,ls,等,bin下的文件就等于命令
2. /boot ,  启动重要脚本
3. /sbin,用户的二进制文件，如reboot，ifconfig
4. /etc,所有程序的配置文件，一般是/etc/software/xxx_config
5. /dev,设备文件，如usb连接的任何设备
6. /proc,进程信息，是个虚拟文件系统，保存着目前正在运行的多种信息
7. /var,变量文件，如系统日志/var/log,网上下载的一些包和库，/var/lib,邮件,/var/mail,多次重启需要的临时文件,/var/tmp,
8. /tmp,临时文件，每次重启都要删除
9. /usr,用户程序目录，包含了/usr/bin,二进制执行入口（类似exe）/usr/sbin,与usr/bin类似；它和系统更相关点，（二进制文件都在xx/bin中），/usr/lib,软件依赖库，提供给xx/[s]bin用的，/usr/loacl或者/usr/include,包含了程序安装后的内容，
10. /home,家目录，包含了每个用户的档案入口点，如/home/user 
11. /lib,系统库，给/bin,/sbin提供支持，还有/lib64
12. /mnt,挂载点
13. /opt,额外可选插件，附加程序等，类似和系统相关较强的附加程序
14. /media,娱乐文件
15. /usr/share/doc/ 下有许多man文件

以上目录，对应的每个软件都有的bin lib var man
