title:deamon与服务
---
### **每个系统服务对应一个deamon**,deamon分为两种，一种是stand_alone,另一种是super_deamon,stand-alone,是启动后一直在内存中，而后者是一个系统超级deamon，它常存与内存，负责等待客户端请求来临，并根据来临的请求启动相应的软件程序服务和进程，打开一个新的deamon1，在完成工作后将deamon1删除。
<img src="http://vbird.dic.ksu.edu.tw/linux_basic/0560daemons_files/super_daemon.gif">
### super_daemon处理事情有两种方式
1. 单线程single thread,仅仅开启一个deamon
2.  multi thread ,开多个deamon,

### 服务service对应一个端口，
--- 
1. 出现端口的原因是因为，ip决定了客户端访问的地址，但是主机提供多种服务（deamon），通过port就可以把它导向指定的deamo
2. 查看系统服务信息
---
### 一个大程序可以开多个进程，一个进程对应有一个唯一的进程号PID，一个进程会有一个唯一端口号用来对外界服务，（但一个进程可以对应多个端口)
1. 进程实际上是一堆二进制文件，任何二进制文件的执行都会得到一个PID号，从登陆的 shell( 执行的是.bash二进制文件） ,开始，在它里面运行的都是子进程，
ps -l 可以查看父PPID子PID进程间的PID号关系，



### 通讯协议

1. ip协议 对应网络层， TCP ,对应传输层， Http ,是应用层 ，而socket,是利用ip/tcp对其的底层函数做一个api封装，因此它本身不是一种协议，而是一个接口，通过socket,便可以使用 ip/tcp,
2. TCP和UDP使用IP协议从一个网络传送数据包到另一个网络。把IP想像成一种高速公路，它允许其它协议在上面行驶并找到到其它电脑的出口。TCP和UDP是高速公路上的“卡车”，它们携带的货物就是像HTTP，文件传输协议FTP这样的协议等。
3. UDP 不保证连接的成功，只负责把数据发送出去，TCP需要三次握手，


```
cat /etc/services
```
### 
### deamon启动脚本，在/etc/init.d/下


### socket.io 学习
1. 此类有很多知识都涉及到了
