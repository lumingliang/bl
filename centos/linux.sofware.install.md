title: linux 下安装软件的几种方法
----
#### by lumin  10.02.2016
永远要记得查看这里日记

---------------------------------------------------

#### 下载二进制安装包
1. rpm 包是redhat系列的安装包，ubuntu要想使用需要使用alien工具转换为deb包
2. deb包是ubuntu的专利，在图形界面点击就可以像win一样安装
3. Linux Binaries (.tar.xz) 这种安装包是已经编译好的，解压既可以./运行, xz -d file.tar.z 解压，然后tar -xvf file.tar

#### 使用包管理器
1. 


#### 使用源码
tar.gz后缀一般是源码，需要make make install 等
一般步骤是：sudo ./configure、make、make install 

