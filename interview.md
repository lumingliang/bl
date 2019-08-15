#### by lumin  19.02.2016
永远要记得查看这里日记

---------------------------------------------------

### web前端面试题
-----------

#### XMLHttpRequest 
中文可以解释为可扩展超文本传输请求。Xml可扩展标记语言，Http超文本传输协议，Request请求。XMLHttpRequest对象可以在不向服务器提交整个页面的情况下，实现局部更新网页。当页面全部加载完毕后，客户端通过该对象向服务器请求数据，服务器端接受数据并处理后，向客户端反馈数据。 XMLHttpRequest 对象提供了对 HTTP 协议的完全的访问，包括做出 POST 和 HEAD 请求以及普通的 GET 请求的能力。

有1. open, 2. send, 3. recieve, 4. abort方法

#### 进程与线程区别

进程在执行时拥有独立内存，线程是共享内存，线程运行在进程中，

#### 语义化HTML
如 h1-h6, p, 列表用ul，li，可以在没有样式的情况下仍然保持清晰的结构，也有利于屏幕阅读器，爬虫的抓取，

#### 网络爬虫
又称网络机器人，根据一个或者一组URL作为目标，有选择的访问web页面和相关链接，,过滤掉与主题无关的策略，获取所需信息，并建立索引，
三个主要问题
1. 抓取目标的描述和定义
2. 对网页数据的分析和过滤
3. 对URL的搜索策略

#### seo(search engine optimize)
分为文章seo和图片seo,内部优化有：META标签，如title,keywords,description,
链接优化，如alt属性 ，外链，友链互换等。

网站pr(pagerank)值是谷歌评价网站好坏的标准，从1-10;

#### 网站资源访问优化
1. 压缩，合并
2. cdn托管
3. 静态资源缓存，启动浏览器的缓存cache-control /，构建一个比较完整的静态资源缓存方案

#### 减少页面加载的方法
1. 图片优化，压缩
2. 压缩css，较少http请求
#### doctype文档类型
包括html,xhtml,有三种DTD 类型，strict,tranditional,frameset
#### 原型继承_proto_, prototype,js会向上查找原型链,知道找到该属性为止
1. js面向对象，

```
//父
function P1 () {
this.name = '';
}
P1.prototype = function() {
doSomething;
}

function P2() {
this.id = '';
}
// P2的原型指向一个p1实例
P2.prototype = new P1();

// 或者有
function P2() {
P1.call(this, name);
this.name = '';
}
```
2. 一个对象的constructor始终指向创建当前对象的构造函数
每一个函数都有一个prototype属性，这个属性也是一个对象，这个对象的constructor,就默认指向这个函数
```
function p1() {
this.name = '';
}
function p2 () {
}

// 继承p1
p2.prototype = new p1();
此时prototype指向了一个新的对象，它的 constructor变化了，需要重新指向p2()
```

#### 圣杯布局
利用负边距，使浮动元素后面的元素可以移上来

#### 浏览器加载页面
从上到下，渲染也是，渲染和下载是同时的，挤压拉伸，满进慢出，弧形运动

#### http状态码
304缓存，500服务错误，200ok，404 notfound,请求失败
#### js数据类型
undefined, null ,boolean,number,string

#### css样式置顶，有利于提高加载速度，

#### js跨域
网络安全不可以访问不同域的内容（协议，端口，域名），但是js脚本却可以
```
src='?callback=dosomthing'
function dosomthing(data) {

}

php
$data = 'kdfj';
echo $_GET['callback'].(该函数加数据)
```
#### 时间委托
如onclick等是事件，事件委托是指本来在该元素上绑定的事件，利用别人来做，一般是它的父元素，优点是在比如一个<ul>下有多个<li>每个li元素要绑定一个点击后改变背景颜色事件，就要给每个元素元素绑定，但是利用时间委托只要绑定父元素，然后获取ev.target即可.还有一个优点是，如果动态添加li元素，后面加入的还有效
stopPropagation（）阻止事件冒泡

jquery对象转js对象利用[index]或者get(index) 方法，dom对象转jquery,前面加$()

#### CMD,AMD
CMD,commonjs,是服务器加载模块规范，nodejs就是采用这种规范，一个单独的文件就是一个模块，加载同步，前面的加载完成后面的才可以加载，浏览器采用AMD，非同步，
#### csrf攻击
利用别人的cookie缓存，伪装别人提交表单，这就需要伪装者发给a这个带有操作的图片，当a点击了这个图片，就会提交了
#### XSS
cross-site-script,允许别人的代码运行在自己的网站上，o，防止方法，echo时用htmlspecialchars来防止，输入的数据直接显示。yii html::encode
#### 防sql
bind 方法
addslashes对输入，暂时放弃用mysql_real_escape_string
#### 模块化工具的特点

1. 灵活架构，功能分离，
2. 多人协作
3. 单元测试
4. 追求更松的耦合度
#### mvvm

双向绑定，view变动自动反应在model,真正将页面与逻辑数据分离，mvc中，	view仍然依赖model



### js n进制转m进制

var bit = parseInt(1111,2); // 声明为2进制
bit.toString(10); //转为10进制

#### this指向


#### 伪对象

boolean,数字，字符串，有属性和方法
#### 类型转换

```
boolean.toString();
number.toString();
转换为数字
paseInt('13432', 进制);
paseFloat('212.dkf')//nan // 如果转换不成功返回NAN
强制类型转换利用
Boolean('hi'); //true
sting(null) ;  //'null'
Sting.slice(top, end),切割字符串，从top 到 end

```

#### instanceof , typeof
判断变量是否为空，或者是哪种类型
```
 if(typeof a!="undefined"){alert("ok")}
a instanceof b?alert("true"):alert("false"); //a是b的实例？真:假

但 if (window instanceof Object) alert('Y');else alert('N');
得'N'
所以，这里的 instanceof 测试的 object 是指 js 语法中的 object，不是指 dom 模型对象。
使用 typeof 会有些区别
alert(typeof(window)) 会得 object
```
typeof用于window是对象，但是instanceof不是

-----------------------------------

### php,mysql,jquery 常见面试
php: 
mvc: model,view,controller中控制读取用户输入，model负责数据库交互

css有三种引入方式，一个外部，一个是内部定义，一个是内联

php不支持多重继承

get和post区别，get信息在url中，且传递数据有限，为1k，post更安全,无上限,修改php.ini的max_file_size

php 中获取图片大小方法
getImageSize(), ImageSx()获取宽度

php中的PEAR,即php extension and application repository,php功能扩展

php 定义常量
define('some', 30);

不用按钮提交表单，在js中执行form.submit();

session,cookie,前者保存在服务器中，cookie保存在浏览器，都可以通过设定时间，每次请求都需要判断session，cookie是否存在，正确来获得用户的标志

数据库事务，就是一组数据库操作，要么失败，要么成功，如果一个失败，都会回滚，

print() 打印简单变量值，print_r()数组，对象等，echo ()字符串

版本管理工具，git,svn; 常用模板，smarty, blade

echo strrev($a); 字符串翻转

#### 数据库查询优化
使用join连接来代替子查询，索引，优化查询语句，建立外键

数据库读写分离：一般是写的压力小于读的压力，读库多个，写库一般一个，读库中存着经常被读的信息（一般是缓存系统），写库负责更新新增等，并同步数据到读库。

```
//外键
如一张表中保存着学生的id，成绩和身份信息，那么可以用外键将成绩和身份分为两个表，其中id作为两个的id，这样两表虽然独立，但是保留了数据的完整性，即操作就像只有一张表一样，但是查询速度更快.这时的规则是，主表的主键是外表的外键，但这个外表的外键不一定是它自己的主键。
```

mysql获取当前时间now.date();

php 常用函数
```
substr(string, start, length)// 字符串截取;w
ord(string) //返回首个字符的ASCII值
ord(substr(string,start, 1)) // 返回ASCII,如果大于0xa0则为中文码
echo $_SERVER['REMOTE_ADDR'] //输出客户端ip
strlen($string);
mb_substr() //中文截取无乱码 

setCoolie('name', 'value') //设置cookie
setCoolie('name', '') //删除 coolie
//必须把start放在第一句
session_start();
$_SESSION[name] = value;
echo $_SESSION[name];    //使用session
isset($_SESSION[name]);   // 判断
unset($_SESSION[name]);   //删除
session_destroy()；             //消耗所有session

preg_match($rex, $string) //返回真假
preg_replace($rex, $replace, $sting)将stirng中匹配的内容变为$replace
strpos("$str Hello world!","world"); //如果匹配world则返回world,不然就是false

//获取url扩展名
$path = parse_url($url);
echo pathinfo($path['path'],PATHINFO_EXTENSION);  //php

//js重定向函数
window.location.href = 'new href';

$list = explode('/', $a) ;将字符串$a 分解为数组
implode('', $arr);将数组合并为字符串
strtolower($string) //字符串转小写

p = i++ //先将i值给p再自加，
p = ++i //先自加再给值

//php读取网页
$ctx = stream_context_create(array( 'http' => array( 'timeout' => 1
file_get_contents('ww', 0 , $ctx);

// php中魔术函数
_construct, __destruct(), __call() //对象调用某个方法，如果不存在会调用该函数；__get() //读取对象的一个属性时，如果不存在会调用它，__set() // 设定一个属性值，如果不存在该属性，调用它。

// 连接mysql
$con = mysql_connect('local', 'root', 'pwe');
$db = @mysql_select_db('DB', $con)
$query = 'select * from user where name = "you"'
$results = mysql_fetch_row(mysql_query($query) ); //注意执行查询、操作用mysql_query()，处理结果集用mysql_fetch_row等

mysql_query("INSERT INTO `user` (name,tel,content,date) VALUES      ('小王','13254748547','高中毕业','2007-05-06')") 

mysql_query("UPDATE `user` SET date='".$nowDate."' WHERE name='张山'");

mysql_query("DELETE FROM `user` WHERE name='张四'");

// create, insert, select, update, delete
CREATE DATABASE database_name

CREATE TABLE table_name
(
column_name1 data_type,
column_name2 data_type,
column_name3 data_type,
.......
)

INSERT INTO table_name (column1, column2,...)
VALUES (value1, value2,....)

SELECT column_name(s) FROM table_name

SELECT column FROM table
WHERE column operator value

//对记录排序
SELECT column_name(s)
FROM table_name
ORDER BY column_name

UPDATE table_name
SET column_name = new_value
WHERE column_name = some_value

DELETE FROM table_name
WHERE column_name = some_value


// 超全局
$GLOBALS
$_SERVER
$_REQUEST
$_POST
$_GET
$_FILES
$_ENV
$_COOKIE
$_SESSION

// 文件
$myfile = fopen("webdictionary.txt", "r") or die("Unable to open file!");
echo fread($myfile,filesize("webdictionary.txt"));
fclose($myfile);

$myfile = fopen("newfile.txt", "w") or die("Unable to open file!");
$txt = "Bill Gates\n";
fwrite($myfile, $txt);
$txt = "Steve Jobs\n";
fwrite($myfile, $txt);
fclose($myfile);
```

include,遇到错误忽略，require遇到错误会停止，
include用到时加载,当再次执行文件时，会重新加载
 require一开始加载，当再次执行该文件时，不会重新加载
 _once,已经加载过的不会加载

 heredoc是一种特殊字符串，可以设置自定义的标签，该标签内都是认为是一个字符串
 ```
 $str= <<<SHOW
 my name is 
 SHOW
 ```

 php ,asp,jsp局别，前者是免费的，后者是编译执行

 php传值，复制值，引用，提高性能。
 
 mysql_fetch_row()从结果集取出一行数组，作为枚举
 mysql_fetch_array() 从结果集取出关联数组

 GD库是一个处理图片的api库。，如缩略图，水印等。

#### 常见需求
```
递归历遍目录，读取父目录，while输出所得子集的数组，while中判断是否为目录，如果为目录，则递归调用，如果不为，则输出，这里需要记住如果是. ..要忽略;w

```
队列先进先出，堆栈先进后出

####判断不同客户端，如是手机还是电脑，以便呈现不同页面
user_agent , 判断网关等，

#### php 错误处理
```
if(!file_exists("welcome.txt"))
 {
 die("File not found");
 }
else
 {
 $file=fopen("welcome.txt","r");
 }

 // php内建了错误处理函数，可以自己建立一个错误处理函数，当发生错误时，调用自定义处理函数

function customError($errno, $errstr)
 { 
 echo "<b>Error:</b> [$errno] $errstr<br />";
 echo "Ending Script";
 die();
 // 将处理函数设置为自定义的
 set_error_handler("customError");}

 // 手动触发错误用
trigger_error("Value must be 1 or below");
```
php异常处理就是当错误发生时，会在此处中断，(即改变了函数正常的执行流程);
```
throw new Execption('som');
如果没有异常处理函数，则会发生报错，未处理的异常

try {  } catch (Execption $e) {  } 可以处理异常
```

#### 文件上传
```
<form action="upload_file.php" method="post"
enctype="multipart/form-data">
<label for="file">Filename:</label>
<input type="file" name="file" id="file" /> 
<br />
<input type="submit" name="submit" value="Submit" />
</form>

if ((($_FILES["file"]["type"] == "image/gif")
|| ($_FILES["file"]["type"] == "image/jpeg")
|| ($_FILES["file"]["type"] == "image/pjpeg"))
&& ($_FILES["file"]["size"] < 20000))
  {
  if ($_FILES["file"]["error"] > 0)
    {
    echo "Return Code: " . $_FILES["file"]["error"] . "<br />";
    }
  else
    {
    echo "Upload: " . $_FILES["file"]["name"] . "<br />";
    echo "Type: " . $_FILES["file"]["type"] . "<br />";
    echo "Size: " . ($_FILES["file"]["size"] / 1024) . " Kb<br />";
    echo "Temp file: " . $_FILES["file"]["tmp_name"] . "<br />";

    if (file_exists("upload/" . $_FILES["file"]["name"]))
      {
      echo $_FILES["file"]["name"] . " already exists. ";
      }
    else
      {
      move_uploaded_file($_FILES["file"]["tmp_name"],
      "upload/" . $_FILES["file"]["name"]);
      echo "Stored in: " . "upload/" . $_FILES["file"]["name"];
      }
    }
  }
else
  {
  echo "Invalid file";
  }
```


#### xss攻击
利用网站漏洞，设法要网站运行自己想要的代码，一般需要把自己的代码写在http请求中，如url,表单域，常规思维是：提交带有自己代码的请求，然后服务器对请求进行解析，并且输出自己的代码，得到了运行。

这里有两种 ，如在表单域，比如自己的账号的文章中写带有恶意代码的<script>标签，然后提交，如果服务器不进行过滤，将会保存这份代码，当别人访问自己文章时，就会在它自己的浏览器渲染并输出代码，运行它，就达到了目的.
[参考](http://blog.csdn.net/ghsau/article/details/17027893)
```
// 有php 代码
<?php 
echo $_GET['textaera'];

//在textaera域里面，输入<script> alert('coolie') </script>则浏览器会解析代码并执行，达到了执行自己的代码

1. 如有一个博客网站，我写了自己的文章，并赋了一些代码，然后提交，会保留在服务器上，这时别人浏览我的文章，需要解析并输出代码，这样就可以在他的浏览器运行了。
```
	
###### 面试题升级
1. 数据结构和算法
数据结构有数组、链表、栈（用在递归）、队列（消息队列）
集合 : list set map
算法：冒泡排序、等
2. mysql 优化方法
使用not null，join的语句要索引，一行时limit 1，
前加explain一下select语句来判断
使用enum而不是varchar
垂直分表经常用和不经常用分开
水平分表，设定水平分表，动态取表等
读操作用myisam，写innodb

3. 跳表是一种有序序列查询非常快的方案，以空间换时间，跳表的结构是在有序序列中，提取出一些关键的值，一层一层比较下来
4. 数组查找为O(1)，利于查找不利于增删，链表不利于查找，利于增删，哈希表是数组和链表的结合，有两者的优点[参考哈希表实现](http://www.cnblogs.com/xingzc/p/5765572.html)

php error_reporting 
将 display_errors = Off 改为display_errors = On
另外还要配置错误级别：将
error_reporting = E_ALL     改为：
error_reporting = E_ALL & ~E_NOTICE
应为php默认是显示所有错误的，而有些无害的提示我们不需要显示，所以设置如上！

php运行机制：sapi接口（cgi，cli，apache2 handeler，先将代码编译为opcode，然后在zend引擎里面执行。核心数据结构为hashTable, oo，extions，各种内置函数array()。

php redis应付秒杀，常规是查看库存，看是否大于0.可以用锁等 for update也可以，排队队列、抢购结果队列、库存队列


##### 面试问题
腾讯后台开发工程师面试经验：每一次面试都有收获，但是很遗憾
2018-04-21 14:31:26 | 来源：职业圈
为了帮助职业圈网友能够及时了解腾讯的面试流程以及面试过程所涉及的面试问题，职业圈小编把刚获得的腾讯面试经验马上编辑好，快速提供给大家，以便能够尽快帮助到有需要的人。这次面试总共花了10天。面试形式包括电话面试。

面试过程
每一次面试都有收获，但是很遗憾，腾讯收的是全方面的人才，大公司从来都不缺技术。可能腾讯即使没有进，但是给我带来最大的收获就是要有自信、有气场、会说话，这在美团面试中给了我很大的帮助。 

面试过程中面试官提了哪些问题
1. 自我介绍
介绍完了就从我简历第一条一直往下问
2. 说一下c/c++源文件如何从代码变成可执行程序的（程序的编译链接）
3. 常用的数据结构有哪些？
4. 数据结构排序和查找算法你知道的有哪些？各个的时间复杂度和空间复杂度？
5. 快速排序的实现？
6. 快速排序非递归如何实现？
7. 快速排序是稳定的吗？排序的稳定性是如何定义的？
8. C++的STL中的vector说一下
9. vector初始化10个大小，之后push_back超出了怎么办？
10. map底层
11. 红黑树有了解吗？说一下你对红黑树的理解。
12. Linux下常用的命令有哪些
13. 查看一个进程打开的文件怎么查看
14. 如何查看指定进程打开的端口号
15. linux系统编程，说一下IO复用poll，epoll
16. 听说过哪些http服务器（我说了apache/nginx/lighttpd）
17. 使用哪些？
18. tcp的五层结构
19. tcp的建立和断开（三次握手四次挥手），最后说道TIME_WAIT状态结束
20. 他问TIME_WAIT状态持续多长时间，为什么会有TIME_WAIT状态
下面问项目相关的，
21. 大概讲一下这个项目负载均衡是干嘛的？
22. 半同步半异步模型说一下。（因为我简历上写了）
23. 如果一个客户端请求异常是如何处理的？
24. 然后他又说这个客户端如果请求连接之后再无响应怎么办？
25. 对数据库了解吗？
26. 听说过redis和memcached吗？
27. 问从memcache中读数据比mysql快吗？为什么快啊？
28. 那从内存读数据一定比磁盘快吗？
29. 然后说内核源码这块他不是很懂，就先不问了。后面会有安排。

二面是经理面
腾讯二面（电话）：
1. 开始的时候问一些调解的话。
2. 你当时为什么要写负载均衡这个项目
3. 写这个项目的过程中遇到什么样比较难处理的问题？我说了配置的热加载和健康性检测
4. 什么是配置的热加载？
5. 进程间通信有哪些？
6. 你平时用过哪些？举个例子，我说了http端用的多进程，进程间使用消息队列通信，并使用信号量控制进程的同步互斥关系
7. 多路复用select、poll、epoll的区别？我说了源码，他后来问了简单的epoll为什么比poll和select高效？
8. 学习上或者说是生活上遇到过什么挫折吗？怎么应对的？
9. 对异地工作有什么看法吗？
10. 有没有想过考研？
11. 你还有什么问题？
一共30多分钟吧。感觉像是总监，说话的语气和一面的面试官明显不一样。这一面个人感觉基本没有问题。

腾讯hr面
1. 自我介绍
2. 项目是不是跟着学校老师？
3. 为什么不是和老师做？我当时说的是老师用的是c#和java，要我现学，我当时想准备春招，在复习，时间不允许，而且我个人觉得语言只是工具，我把c++学深入了之后，以后在工作中遇到如果要用其他语言的话，我是很乐意去学习，不想现在学那么多语言，只有广度没有深度。她说哦，了解了。
4. 什么时候能参加实习呢？大概多久呢？3-9月都可以吗？
我这个问题就答的sb了，我说4到9吧，尽可能学习表现好能留下来，如果留不下来跑一跑秋招 (真的傻逼了这后半句)
5. 家是哪的，父母介意异地工作吗？
江苏，不介意。
6. 女朋友对异地工作呢？
这个问题我个人没有答好，可能太想按之前准备的答案上回答了，答的特别不好。不在这里说了。
7. 深圳和北京工作有什么意见吗？
我说都可以。
8. 我这边没问题了，你还有什么问题吗？ 

有关面试流程的相关细节问答
你是通过何种渠道获得这次面试机会的？ 
答:校园招聘 

整个面试花费了多长时间？（从接到面试消息到得到结果） 
答:10天

面试形式包括哪些？ 
答:电话面试 

你觉得这次面试的难度如何？ 
答:困难 

你对这次面试的整体感觉怎么样？ 
答:一般 

这次面试的结果如何？ 
答:面试未得到工作


######
io 多路复用，是先用红黑树维护活跃的socket，然后当网卡有数据时，将数据复制到维护的epool对象中，调用wait时，直接得到的就是可用的socket
然后进程再对可用的socket进行循环处理


先使用ps -ux查看进程PID。  使用lsof -p 1430（进程PID） 此时可以获取打开的文件信息，类型、大小、节点信息等。  ll proc/1430/fd，

查看端口号 ps -ef | grep tomcat 得到进程id  netstat -nap | grep 1095查看端口号

根据端口查看对应进程，查看占用8080端口的进程id，为1095

netstat -tunlp | grep 8080
根据进程id查看进程信息，查看进程id为1095的进程信息

ps -ef | grep 1095

根据进程id杀死进程，杀死进程id为1095的进程

kill -9 1095
