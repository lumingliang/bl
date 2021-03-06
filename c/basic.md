##### c语言相关的一些基础
1. 电子原件组合构成了各种01组合，每个原件有高低电平来表示10,8位表示一个字节。一个字节可以代表（存储）一个英文字母、一个文字等。另外1024byte=1kb，1024k=1m。
2. 8进制用3位表示，满8进一0000；16进制用4为表示0x0000；2、8、16进制的互相转化只需要不足补0即可。15在15进制是F。
3. ASCII用8位（一个btye）表示26个字母以及一些常用的符号。共有256种组合。Unicode编码，用16进制表示，4位16进制，即16位。分为17组平面，0号平面用4位16进制表示，1号平面以上就要用5位或6位16进制数了。utf(Unicode transform format)-8是一种折中的方案，随着符号编码的增加，内存中会用8位到32二进制去表示。而utf-16和uft-32分别是至少用16和32位存储这些符号。
4. c语言的运行，分为预处理、编译为汇编代码、汇编为目标文件、链接成可执行文件几个步骤。

###### 数据结构
0. 数据结构是指具有特定关系的数据元素的集合
1. 数据以一定的关系的逻辑表示，数据在计算机内的存储方式是固定的，需要特定的算法来实现特定的数据结构，数据结构应该是逻辑表示。[数据结构的特点](http://blog.csdn.net/xiaolang85/article/details/10214981)
2. 数据结构三个层：抽象层（逻辑）、结构层（存储）、实现层（算法）
3. 物理结构：顺序结构，数据元素放在一段连续的地址空间中，随机访问访问，插入和删除不方便。
链式结构：每个元素放在独立的地址空间，每个独立的地址空间称为节点，每个节点保存着关联（下一个）节点的地址。删除和插入方便，空间利用率高，随机访问不方便。
4. 算法需要考虑问题，创建、销毁；插入、删除；获取、修改；排序，查找。
5. 数据结构：堆栈（可以基于顺序表或者链表物理结构实现）；队列：（顺序表或链式表）；链表：基于双向线性表实现。二叉树。
6. 堆栈：底部不通，后进先出。类似瓶子装水
7. 队列：先进先出，类似排队。
8. 二叉树：也是通过基本存储方式实现的，可以顺序式和链表式
###### 算法复杂度
即用语句的执行频度表示，同时将规模和语句执行次数做一个相除趋于常数的函数的主要部分表示。

[数据结构百度文库ppt详解](https://wenku.baidu.com/view/65a32f1a4b35eefdc8d333b4.html)

9. 二分法，即将数据折半后比较，要求数据是已经排序的，任何数据在计算机中都是数值，时间复杂度为O(logn).随着问题规模的增大，趋于平缓
```
二分查找的基本思想是将n个元素分成大致相等的两部分，去a[n/2]与x做比较，如果x=a[n/2],则找到x,算法中止；如果x<a[n/2],则只要在数组a的左半部分继续搜索x,如果x>a[n/2],则只要在数组a的右半部搜索x.

时间复杂度无非就是while循环的次数！

总共有n个元素，

渐渐跟下去就是n,n/2,n/4,....n/2^k，其中k就是循环的次数

由于你n/2^k取整后>=1

即令n/2^k=1

可得k=log2n,（是以2为底，n的对数）

所以时间复杂度可以表示O()=O(logn)
```

10. 顺序查找法的时间复杂度是O(n).必须应用在有序数据结构上
11. 二叉树的时间复杂度是O(logn).应用在二叉树上
12. 跳表时间复杂度O(logn).
13. [常用排序算法时间复杂度](http://blog.chinaunix.net/uid-21457204-id-3060260.html)
14. hashTable
15. hash索引 的方法其实就是将key映射为地址，因为得到了地址对于磁盘来说就是一次性定位，所以很快，为什么要建立各种索引，就是因为更多情况下，很多东西的key都无法搞成地址，或搞成地址就会失去了比较排序等功能。地址是一次性定位，得到了地址就得到了数据

16. b tree 是一种数据结构，通过设定好的逻辑就可以实现对元素快速定位
17. 二叉树讲究遍历

insert into public.car_config_option select (data->>'name') as name,(data->>'id')::int as id,(data->>'group') as group, (data->>'unit') as unit from import.car_config_option;
insert into public.car_config_option_value_copy select (data->>'model_id')::int as model_id,(data->>'option_id')::int as option_id,(data->>'value') as value from import.value;

alter table name modify column id int not null auto_increment, add primary_key id; id;
18. 倒排索引，将一个文档切割能各个单词，然后维护一个词典记录了每个出现的单词，索引内容记录了单词，以及在哪个文档出现过
19. gin gist 等属于倒排索引
20. bitmap 是一种用位来表示元素的方法，如用第3位为1表示uid=3的人在其中，最后统计它的基数即可，统计基数是用 HyperLogLog redis有实现

21. 语法
```
异或^，不同为1，同为0，
#define val 宏定义，相当于变量，但是它是编译时候，会直接把变量替换

条件编译
#ifdef 
#else
#enif

类型别名，为一个类型重新定义一个别名
typedef unsigned char unit8_t

extern 提示编译器变量定义在其他文件中，要在其他文件中去找

static 申明的局部变量，函数执行完成后，值仍然保存，不被释放，初始化时候，只被初始化一次，
static 申明的函数，仅在当前文件内可以用

__week 定义的函数，是弱函数，可以给上层程序重写该函数，如果用户重写，那么就调用用户重写的

struct 结构体，同一组变量用数组，不同组用结构体
typedef struct {
    
}name


```


###### 进制
16进制 0x 四位二进制表示一位16进制
8 位一个字节，1k 1024个字节，1024k 1M 

###### 谈变量和指针变量
内存中变量的存在是 地址：值，cpu先要寻址，然后取出该地址的值。变量名实际上就是异味着地址，而指针变量则是另外一个变量名，它的值存放着它要指向的地址。

```
一级指针，用于一维数组
T *arr_t = new T[N];
二级指针，用于二维数组
T **arr_t = new T*[N];
for (int i = 0; i < N; ++i) {
  arr_t[i] = new T[M];
}

数组的操作，自带指针、地址等概念
```
###### c语言里面的类型
```
都是数值
char 8位
int 32 位 sign int 32位 但是最高位是符号

const 定义值不可以改变
static 全局
```

###### c语言的堆和栈
栈是先进后出，相当于一个水桶放水
而堆就不同了，堆是一种经过排序的树形数据结构，每个结点都有一个值。

通常我们所说的堆的数据结构，是指二叉堆。堆的特点是根结点的值最小（或最大），且根结点的两个子树也是一个堆。

由于堆的这个特性，常用来实现优先队列，堆的存取是随意，这就如同我们在图书馆的书架上取书。

###### 函数调用过程
每一次函数调用都是一个过程。
这个过程称之为：函数的调用过程
该过程要为函数开辟栈空间，用于本次函数的调用临时变量的保存、现场保护。这块栈空间称之为函数栈帧。

函数调用前先保存函数调用的下一条指令地址，然后调用函数后，会将函数调用所有变量出栈，回到下一条指令开始执行


###### 函数指针
函数指针的定义方式为：
函数返回值类型 (* 指针变量名) (函数参数列表);

void的字面意思是“无类型”，void *则为“无类型指针”，void *可以指向任何类型的数


