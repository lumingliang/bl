##### 分布式mqtt服务

1. gozmq 的安装，在win7上，需要下载64位版本的MinGw，然后下载64为版本的zmq4.4，安装时安装lib，头文件。

然后第三步：将Zermq安装路径下的include文件夹的头文件复制到D:\mingw\mingw64\lib\gcc\x86_64-w64-mingw32\6.3.0\include路径下，既安装Mingw的相关路径，自行对比我的路径可以找到。
第四步：设置静态库文件，将zeromq装路径下的lib文件夹下的libzmq.lib文件复制到MinGw路径D:\MinGW\x86_64-w64-mingw32\lib下的lib文件夹下，并重命名为zmq.lib。至于选择哪个lib文件，各个版本解释：此处选择v120的。每个lib文件编译的开发环境不同，应用的操作系统也不一样。重命名为zmq.lib是因为gcc在编译的时候会去查找这个文件。

第五步：设置动态库文件，将zeromq安装路径下的bin文件夹下的dll文件复制到MinGw安装路径下的bin文件夹下，不需要重命名。至于选择哪个dll文件，一定要与前一步的dll相对应。在zeromq安装路径下有dll与lib文件，各个版本一一对应。
