tiltle:主要是一些小知识
---
1. apt-cg install package
2. apt-cyg的安装
```
wget http://apt-cyg.googlecode.com/svn/trunk/apt-cyg
chmod +x apt-cyg
mv apt-cyg /usr/local/bin/
```
3. 使用
```
apt-cyg install bc
apt-cyg find php //查找

apt-cyg -c /cygdrive/d/downloads/cygwin -m http://mirrors.163.com/cygwin/ find php //指定源查找,c ,设定缓存目录

apt-cyg -m ftp://ftp.cygwinports.org/pub/cygwinports find php

apt-cyg update --mirror http://mirrors.163.com/cygwin/  //更新源

```

###注意，因为nodejs官方不支持新版本的cygwin nodejs，所以也没必要安装了！，最好是利用在win7下的nodejs和npm，可以在cyg界面执行编译等命令！！

#### cygwin 下安装nodejs ,
1. [官网下载](http://cygwin.com/setup.exe)
2. 安装cygwin几个要点

（1）Install from Internet,安装程序在后面步骤会下载大量文件。
（2）Root Directory，是Cygwin的安装目录。
（3）Local Package Directory，是存放所有下载文件的目录，子目录名即下载镜像网址，子目录下的release

**注意安装后创建的快捷方式不准确，需要加上exe**

3. 镜像 
http://mirrors.163.com/cygwin
http://mirrors.sohu.com/cygwin/
4. 安装g++,make,git,vim,curl,wget,python(全部安装)
```
gcc-g++: C++ compiler
gcc-mingw-g++: Mingw32 support headers and libraries for GCC C++
gcc4-g++: G++ subpackage
git: Fast Version Control System – core files（它可以从 github 下载软件最新版源码)
make: The GNU version of the ‘make’ utility
openssl-devel: The OpenSSL development environment,
pkg-config: A utility used to retrieve information about installed libraries
zlib-devel: The zlib compression/decompression library (development)
```
5. 要正常编译nodejs，必须先在Cywgin的ASH模式下执行rebaseall。步骤如下：
```
（1）cmd命令行
（2）进入cygwin安装目录下的bin子目录
（3）运行ash进入shell模式
（4）./rebaseall -v
（5）没有错误，完成，exit退出ash，关闭命令行窗口
```
6. 编译安装nodejs,这里是最后支持的版本了，新版本无法编译
```
wget http://nodejs.org/dist/node-v0.4.12.tar.gz
tar xvfz node-v0.4.12.tar.gz
cd node-v0.4.12/
./configure  //会提示openssl 未找到;;;
make
make install
```
7. 配置DNS
```
cygwin内部是使用windows的DNS查询，而nodejs另外使用的是c-ares库来解析DNS，这个库会读取/etc/resolv.conf里的nameserver配置，而默认是没有这个文件的，需要自己建立并配置好DNS服务器的IP地址，这里使用Google Public DNS服务器的IP地址：8.8.8.8和8.8.4.4。

$ vi /ect/resolv.conf

nameserver 8.8.8.8
nameserver 8.8.4.4
```
8. $node -v 查看版本

9. 安装npm
```
npm下载、安装、使用

npm是nodejs的软件包管理器，可以用它安装所需软件包并发布自己为nodejs写的软件包，它还管理软件包的依赖关系并做了其它一些很酷的事情。
（1）一行命令下载并安装npm

$ curl http://npmjs.org/install.sh | sh

（2）npm安装node扩展包，同样是一行命令下载并安装好软件包

$ npm install <包名>

例如安装mysql：npm install mysql
```

10. cygwin配置
#### 配置硬盘挂载 ln -s /cygdrive/d /d 
参考[cygwin配置](http://www.cnblogs.com/astwish/articles/3700459.html)