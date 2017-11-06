tiltle:linux  下的gcc编译
---
### 用gcc编译的原理是：

1.先写好程序源码（源码中包含了各种内部库和外部库的引用
2.gcc编译源码(对各个源码文件进行编译)
3.gcc进行主副外，程序调用的结合(对编译到的各个源码文件jj.o,进行链接，指定引用外部库的路径)
4.生产了相应的最终binary file,并将配置等安装在主机上

### make编译源码原理：

~make的原理其实是gcc的简化，它省去了gcc编译链接外部内部库调用的一个个写代码的麻烦，也就是集成到了configure中，再运行configure**产生makefile文件**，最后运行makefile文件编译完成. 
如下图
<img src="http://vbird.dic.ksu.edu.tw/linux_basic/0520source_code_and_tarball_files/make_configure.gif">

参考:[鸟哥私房菜](http://vbird.dic.ksu.edu.tw/linux_basic/0520source_code_and_tarball_2.php)

### tarball软件源码编译安装（源码tar.gz:tar打包，zig压缩的结合包)安装
0.  参考README等文件
1. 运行./configure,创建makefile文件
2. optional:  make clean读取makefile中关于安装前得清除工作，清除系统中多余的冲突东西，旧版本等
3. 执行make，在当前目录下得到编译后的各种文件
4. make install ，将编译后的文件安装到指定的（预先设定好的）地方。
5. 别忘了解包的方法tar zxvf XXX

### 软件安装的主要地方
0. /usr/local/software/etc/  ,配置文件
1. /usr/local/software/lib/ 函数库
2. /usr/loacl/software/bin/ 可执行文件
3. /usr/local/software/man/ 软件的使用指南
4. 同时在编译php等需要指定某个依赖的dir时，其实有两种方法，如果是应用prefix 安装的依赖那么直接告诉它该路径即可，如果是利用yum安装的，先whereis一下，找出他的目录分配，而这个目录分配其实是有规律的，如，分配在/usr/下的各个子目录 bin man lib lib64 include下，编译是会自动往下面的目录找东西，其实跟安装在prefix的效果是一样的

## 其中/usr,/local,等目录可选，依据软件的类型而定，如自带，yum，apt，源码安装等，重要的是后面的/etc/等
## 源码安装时候，最好先将tarball源码解压到/usr/local/src/目录下，

###源码安装经验谈，
1. 将源码复制到本地后，执行，./configure, make (some parameter) ,make install, 会在当前该包的目录下生成了/bin,/etc/ ,/lib/ , (/include) ,几大文件夹，在这里直接执行 /bin/中的二进制文件，即可运行该软件， 然而在编译安装的同时，它还将这几大文件夹复制到了对应的， /usr/bin ,/usr/etc/(或者系统的etc)  ,/usr/lib ,/usr/include / ，下，以供全局使用，所以此时直接在当前目录删除该解压后的安装包即可，但这有个缺点就是无法实现要卸载该软件的时候，不知道在系统哪里将软件全部清除掉，所以这时如果还保留了最初的那个解压安装包，就可以执行 ，make uninstall ,达到目的， （但有时候无法卸载，因为软件没有提供该方法);

//我一般都./configure --prefix定制安装目录，到时直接删文件夹。


2.  所以如果没有特别需要，只需要下载二进制码版本，然后放到usr/local/soft  中，再做一个bin到/usr/local/bin   的软连接即可达到程序的全局运行，卸载时候只需要删除该下载包和软连接,	 记住软连接一定要写绝对路径
3. 最方便的方法就是用yum之类的东西了，无需考虑安装后的卸载问题。 

### 软件管理（自动安装）两大体系
1. dpkg管理机制,由debian  linux开发的，ubuntu在用
2. rpm管理机制,由Red Hat,有centos,fedora

### 利用软件管理员安装有多个功能，一种是下载编译好的二进制安装如centos下的xxx.rpm（需要有同样的环境，不能解决依赖关系），一种是xxx.src.rpm,源码安装，还有就是yum，rpm的升级版，可以解决依赖

rp-pppoe -        3.1    -     5        .i386        .rpm
软件名称   软件的版本资讯 释出的次数 适合的硬件平台 扩展名

###rpm 还是tar.gz？
rpm是centos下的软件安装机制，具有方便安装清除等优点，但tar.gz可以适应linux 的所有

### rpm，deb，yum，apt等都会有默认的软件安装地方和操作

### tar.gz 文件也有二进制编译好的(执行包)，直接解压即可使用，解压后有bin/,include,等文件夹，其中bin中就有可执行文件,进入后用./xxx便可.删除时候直接删除，就相当于exe包.rpm与他的区别是，它提供了良好的管理，卸载和查找时候容易
参考，[linux软件安装知识扫盲](http://forum.eepw.com.cn/thread/262947/1)

### 只要是bin目录下的都是可执行文件，只要将bin目录添加到系统环境path就可以直接运行该文件，脚本等
