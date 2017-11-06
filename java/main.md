##### java 运行原理
```
*.java→*.class→机器码
java编译器 (编译) → 虚拟机(解释执行) →  解释器(翻译) → 机器码

```
java 必须运行在jvm中，java桌面程序跟node桌面程序一样，只是它打包了jvm，所以体积比较大
[java运行解释](http://www.cnblogs.com/o-andy-o/archive/2012/04/11/2442109.html)

1. java类构造器与类同名
2. == 比较的是地址，equal比较的值
3. 类成员变量在函数中可以直接用name不用this，但是如果该函数内存在同名，则需要this，不然使用的都是该局部

##### jre, jdk 区别
jre 包括jvm，客户端使用，运行编译后的.classjava程序
jdk java 开发包，包括了编译java的javac 也有jre http://blog.csdn.net/forwayfarer/article/details/3321410

##### java_home, class_path的作用
1. java_home 是一种约定，给其他java程序提供了找到java目录的一个前缀
2. class_path则是找到java 编译后.class文件的目录,因此一般要在前面加个.;表示当前目录



