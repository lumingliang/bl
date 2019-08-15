##### 0mq 
1. 一个类似但是功能超越socket的消息队列组件了，可以在各个应用间传递消息，类似socket协议的传递消息
2. php 连接数据库、redis其实都是每个请求进程都连接了一下数据库，都要首先建立连接
3. 0mq 可以实现1:n, n:m的消息传递形式，还可以将消息加入队列中，逐个处理
4. push , pull 模式就是一种分布式、负载均衡[队列模式](http://www.cnblogs.com/rainbowzc/p/3357594.html)
5. 0mq 的多种[作业模式](https://news.cnblogs.com/n/154000/)
6. rpc 协议其实就是不同程序间可以共享代码，实现了java、php间的互相调用，类似轻接口，或者也可以直接用0mq方式来解决
7. zmq 安装，需要安装官方zmq包，win中要先有 libzmq.dll 以及相应的dll
8. linux中需要先安装libzmq 
```
 sudo apt-get install pkg-config
 sudo apt-get install libzmq3-dev
sudo pecl install zmq-beta
```
9. protocol buffer :  将内容变为二进制文件。过程是先装好 protoc，然后得到一个针对某个语言，如php的可执行文件，再利用该文件来进行编码、解码操作。php对于数据定义、加入过程比较麻烦，是一种类操作。
js 是直接对象设定 
需要从源码编译安装特定 protoc，然后利用该protoc 针对 .protoc 生成特定php类文件
