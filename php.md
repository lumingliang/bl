title: 介绍php的有关学习，包括语法，配置，以及扩展等
----
#### php 命令
```
看是否是线程安全的
php -i|find "Thread"
一般情况下，作为apache模块的都是TS
而使用php-fpm的是NTS
```

#### php数组
1. 索引数组
2. 关联数组
3. sort($array) ,数组排序,对数组进行key的升序排列
4. rsort() 逆向排序	
5. ksort() ,asort() ,给关联数组排序
6. [数组操作详解](http://blog.163.com/inewzou@yeah/blog/static/131005870201111102947591/)

7. private 声明的函数变量，不能被new得到的实例引用，只能被内部的public函数间接调用
8. 往数组里面增加新元素，[参考](http://www.php230.com/1410670681.html)
9. 在数组尾部加入新元素 []
10. array_flip( array $trans )  将数组翻转，key , value 对换，重复的会除去
11. strtr( string $str, string $from, string $to ) 
    strtr( string $str, [] $replace_pairs ) 
    将$str 从$from 替换为$to ,或根据$replace_pairs数组批量替换
12. suffle 将数组顺序打乱
13. extract() 将数组化为变量
14. compact() 将变量化为数组键值对

```
<?php
$queue = array('a', 'B');
$queue['front'] = 'hello';
/*
输出
Array
(
    [0] => a
    [1] => b
    [front] => hello  
)
*/
?>
```

10. '$array' //里面的$没有转义，将被解析为变量

11. php对象用 -> 获得，数组用 ['key'] ; php数组转对象 (object)$arr // 是只能一级数组

12. implode("\n", $items) ;  将数组化为字符串, 注意$strings 在后

13. php 中的trow , try catch 其实就是一个中断，看到 trow 就执行trow语句然后直接跳到catch中，并往catch传入一个exception实例,执行catch代码段

14. php 命名空间，php的 require只是对代码简单的加载，思考每个php文件中有一个类，如果区别这每个类的不同呢，一个是利用路径不同作为标志，可是php中没有实现，而是用命名空间来实现了。
```
use \foo(); 调用全局函数foo();
use foo(); 调用该命名空间下的foo();

new \D(); 创建定义在全局空间中的类 D的对象，如果没有就尝试自动加载
```

如上，namespace 其实是和类的路径是分离的，每次require后还需要从新使用use，composer所做的就是在一定规则的命名空间下实现类的自动require; 这样只需要use就不用require，因为它已经帮助完成了。它的逻辑就是通过一个composer.json里面的文件，定义一个命名空间头对应特定的全局路径,然后用到这个命名空间时就从这个对应中对应下来就好了。

***自动加载***

对于不能正常加载的类，php会去执行自动加载方法，该方法只要在开始地方实现就好，一般就是传入一个类的函数给它，到时候会自动调用这个函数的加载逻辑。

##### php static

php 中的静态方法、静态变量用static关键字声明，静态方法或者变量在外部只能以::形似使用，在内部需要用self:: / parent:: ，静态方法与普通方法不能混用。

静态方法不需要实例化即可使用
```
class Foo {
    public static function aStaticMethod() {
        // ...
    }
}

Foo::aStaticMethod();
$classname = 'Foo';
$classname::aStaticMethod(); // As of PHP 5.3.0
```

new static() 在代码里面新建一个高层类对象
new self() 新建一个当前类的对象

php 中静态方法和非静态方法等都可以混调用，唯一需要注意的是使用self :: $ 等使用静态方法和属性和静态方法

###### php const 常量, 一旦定义值不可变
内部使用self::var得到，外部实例用ClassName::var得到
区别于define 全局定义，(可以改变还是覆盖其值?)
public static $var 静态变量, 可以改值

###### php 中的private 变量在基类定义，子类如有重名并不冲突，因为private 只对该基类有效

##### php 中一些助手函数

```
get_class($instance) 获得这个实例的类名
get_called_class() 一般镶嵌在静态方法中，可以获取调用这个静态方法的最高层类名,如A extend B , 则是得A
call_user_func('func', 'param'); //类似func(param);

// 魔术方法
__toString() 当直接echo 输出对象时会自动调用这个方法

array_merge() 将多个素组合并为一个数组

array array_keys ( array $array [, mixed $search_value [, bool $strict = false ]] ) 返回或者查询一个数组的key

$pos = strops('strings', 'searchString') 查找第一次出现的位置
substr('$string', 0, $pos + 1) 截取字符串
```

##### php 内建类

```
use ReflectionClass;
new ReflectionClass($this or a class name);
将一个类作为参数构造一个新的ReflectionClass实例，就可以通过这个实例来读取类的许多信息。

ArrayAccess是一个接口，实现了这个接口的类的实例，就可以像操作数组一样操作他的元素

php 内置了一些有用的接口、基类，借助这些可以方便的实现其他语言有的功能,如ArrayInterable类，实现数组迭代等。
```

##### '' "" {} 的区别

$test = "test";
echo "$test";//输出test
echo "$testwrong";//不输出任何东西
echo "{$test}wrong";//输出testwrong

echo "{$a['a']}";//这里要{},不然会出错
echo "services[{$name}]"

##### php 中的ob函数

该函数实现服务器输出缓冲功能。
ob_start 打开缓冲区，之后的飞header 信息都不会发送，ob_end_flush 和 flush可以输出缓冲区内容

** php默认有缓冲区内容，当程序未执行完成时，输出不够256字节默认不输出浏览器的**

flush 刷新缓冲区内容
ob_implict_flush(int flag) 打开或者关闭绝对刷新，打开绝对刷新后，不需要频繁调用flush()

ob_get_contents 得到缓冲区内容
ob_get-length

ob_flush();
flush();
```
ob_start();
ob_implicit_flush(false);
extract($_params_, EXTR_OVERWRITE); // 解出变量到当前环境使用
require($_file_); // 直接require ，得到echo等语句

return ob_get_clean(); // 清楚缓冲区，并得到输出string
```
##### php 传值
php中对象都是引用传值


##### 
require_once 加载过就不加载
require 一般放在 PHP 文件的最前面，程序在执行前会先导入所需要引用的文件；
include 一般放在程序的流程控制中，当程序执行时碰到才会引用，简化程序的执行流程。
require 引入的文件有错误时，执行会中断，并返回一个致命错误；
include 引入的文件有错误时，会继续执行，并返回一个警告。
include和require都有返回值,require文件出错时候才没有
