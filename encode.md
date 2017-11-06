### 讲述有关编码的问题

#### 基本概述
计算机只能处理数字，如果需要处理文本，必须把文本转化为数字，8位一个bytes,共有0到255个整数，就可以利用这255个整数表示255个字符，最初ASCII表示所有英文字母和一些符号，（编译器，电脑知道什么时候这些整数表示真正的数字，什么时候代表符号）

字符'0'和 数字0是不一样的

'A'在ASCII中十进制是65，二进制是01000001, 但是 Unicode是十六位，因此，聪明的办法是Unicode中再前面补0来表示A,补8个0;但是这样会浪费内存，于是动态长度的UTF8出现了，即常用的英文字母被编码成1个字节，汉字通常是3个字节，只有很生僻的字符才会被编码成4-6个字节。如果你要传输的文本包含大量英文字符，用UTF-8编码就能节省空间：

UTF-8编码有一个额外的好处，就是ASCII编码实际上可以被看成是UTF-8编码的一部分，所以，大量只支持ASCII编码的历史遗留软件可以在UTF-8编码下继续工作。

在计算机内存中，统一使用Unicode编码，当需要保存到硬盘或者需要传输的时候，就转换为UTF-8编码。如：用记事本编辑的时候，从文件读取的UTF-8字符被转换为Unicode字符到内存里，编辑完成后，保存的时候再把Unicode转换为UTF-8保存到文件：



### nodejs只支持utf-8编码,对于node js buffer流编码转换问题
[参考](https://segmentfault.com/a/1190000002787763)
