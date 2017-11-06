title:nodejs的基础学习档
---

#### js中一切都是对象,对象可以直接拿来用了，至于利用函数，原型得到的类，可以视作特殊对象，需要实例化
#### require 传入一个模块名，然后互向node—modules各个文件夹搜索，返回一个导出的对象 
***krequire('./foo');//相对路径，也可以./foo.js,或者绝对路径/home/foo;
#### exports,模块的导出对象，导出公有属性方法等，
exports 是运行环境的一个大对象的，如
```
exports.hello = function () {
    console.log('Hello World!');
};
```
将代码中function函数给了exports对象，所以外部就可以通过require 得到它了
#### 所有模块只执行一次，如果一个模块在一段代码中多次引用，只会require一次
#### 设定环境变量：
NODE_PATH=/home/user/lib:/home/lib
则node require也会向这两个目录搜索模块
#### 包，通过多个模块的组合，入口模块main.js供require使用， 而main.js负责调用包内的其他模块
```
- /home/user/lib/
    - cat/
        head.js
        body.js
        main.js
```
当入口模块名为index.js时，只需要require('/home/user/lib/cat'
 但如果指定了package.json,如下

 ```
 {
    "name": "cat",
    "main": "./lib/main.js"
}
 ```
则也可以了，因为利用'main'告诉了入口模块在哪
#### 命令行的原理其实是一个脚本，头部告诉了该脚本用的语言，如!node,然后使它权限能执行，最后添加到环境变量搜寻的目录中
 ```
 #! /usr/bin/env node
 chmod +x /home/user/bin/node-echo.js
 ln -s /home/user/bin/node-echo.js /usr/local/bin/node-echo
 ```
 usr/local/bin目录下都是二进制文件，同时也是环境变量搜索的地方，
 ### 标准的包目录
 ```
 - /home/user/workspace/node-echo/   # 工程目录
    - bin/                          # 存放命令行相关代码
        node-echo
    + doc/                          # 存放文档
    - lib/                          # 存放API相关代码
        echo.js
    - node_modules/                 # 存放三方包
        + argv/
    + tests/                        # 存放测试用例
    package.json                    # 元数据文件
    README.md                       # 说明文件

 ```
### 版本号，x.y.z ,分别表示主版本，次版本，和补丁版本，若改变向下不兼容，x，改变新增了一些功能，但向下兼容，y，修复一些bug，z 


### nodejs 中模块化和类,对象,对象，函数深入理解
1. 模块的加载方法，'/a.js'绝对路径 , './b.js',相对当前路径 , 'a.js' ,核心模块或者处于node_modules中
2. this,原型链用法
3. module,export,require

### 处于不同文件中的用var声明的变量，只属于该文件，不能被外部文件访问
```
// a.js /moudle a

var name = 'lu';
exports.getName = function() {
	return name;  // 通过exports 自由变量返回对象
}

module 是一个全局变量，module下每一个模块都拥有一个 exports变量，并会在require时候传给要的对象
exports默认为一个空对象
可以通过
module.exports = function() {
	//return obj;
}
重新定义exports  为一个函数，并传值
console.log(name);
// exports 是每一个模块都有的，当b模块require a.js时候， require 传给b.js的就是a.js的exports 变量，每个模块的exports是属于模块内部的，每个都不一样，通过expors传值达到b中对a的引用

//### 如果定义成
module.exports = {
	name: vaule,
    f:function() {

	  }
}
则传给require的值则是一个已经写好的对象
// b.js /moudle 
var a = require('./a.js');  // require 后a.js中的代码会运行的，如console.log() 会运行
var name = 'min';


```



```
var newModule = function(obj) {
	var name = 'lumin'; // 这些变量使不被外界使用的
	var som = obj.som;
	var id = 1;
	var that;
	that = { // 这个对象包含了该模块的所有方法，其实模块和类可以看做同一样东西 
getName: funciton() {
			 //
		 },
setId: function() {
		   //
	   }
	}

	retrun that; //通过返回that提供给传值使用
}

module.exports = newModule;


// b.js

var a = require('./a.js'); //得到的是一个函数，看上面的module.exports
var tt = new a({//obj});
//或者直接 vat tt = a({});
```

### js 原型链
[参考js原型链理解文章](http://www.cnblogs.com/yjf512/archive/2011/06/03/2071914.html)

1. js中所有东西都是对象
2. js中的function可以当做function,对象，和类
3. js 中有三种方法，对象方法，类方法，原型方法(原型专门用来继承的),当然还有普通函数

```

var env = 'env value'; 
function Peple() {
	this.name = 'obj method';
	this.obj = 'obj only'; 
	this.nam = 'for class '

	this.getName = function() {   // 对象方法
		console.log('your name is'+ this.name);

	}
} 

Peple.getName = function() {
	this.env= 'class value'; 
	console.log('using chain in class method'+this.env+this.name); //无法使用到主函数的name,因为类方法是区别开来的
	console.log(this);
	console.log('class method');
}

Peple.prototype.getName = function() {
	console.log('getName'+this.name); //实例化后，当原函数没有这个方法时候，才会调用原型方法
}

Peple.prototype.pro = function() {
	this.name = 'prototype name'; 

	console.log('pro'+this.name); //原型使用自身的对象属性
	console.log(this.obj); // 原型可以调用主函数的对象属性			
	console.log(env); //
}

Peple.getName(); //调用class method
var p1 = new Peple(); //把函数看做类，并实例化
p1.getName(); //调用对象方法，如果没有就找原型方法，如下
p1.pro();



```


#### js 接口，
1. 接口是用来声明一个类应该具有哪些方法和变量，为了使团队合作更加轻松，接口定义了一个严谨的结构，可以让许多类实现而具有不同的功能和统一的接口
2. 当需要调用时，只要指明相应的实现，然后就可以用共同的方法调用，十分方便
3. 当然实现每一个接口的类，工作量其实是蛮大的，js中，可以用注释方法，提醒这个类拥有哪些方法，函数名，等到定义类似的函数时，就可以参照这个注释来创建一个新类
4. 与真正的接口不一样的是，它没有错误检查，也就是当别人创建一个新类时，结构并没有真正的接口那么严谨，也就不能用相同的方法调用了
5. 接口更确切的说是一种标志，每一个类其实都是需要重新创建的


### js 动态变量名，变量的名字保存在字符串或者数组中，而变量定义在当前
```
var sensor1 = {};
var num = 1;
console.log(eval('sensor'+num) ); // 输出{}
```
### js 动态创建变量，确切来说是动态创建全局变量

```
a = [3,4];
this 代表当前的环境，即全局变量
this['actuator'+a[0]] = {};
console.log(actuator3) // {}
```


### js n进制转m进制

var bit = parseInt(1111,2); // 声明为2进制
bit.toString(10); //转为10进制

### nodejs 中的二进制流
```
var b = new Buffer(2); // 创建一个有两个十六进制数的buffer，里面的值未初始化，是随机的,且会储存在一块与当前其他变量不一样的位置，是个静态的
conslole.log(b); // b是一个数组
b[0] = 3;
b[1] = 2; //十六进制格式
b[0] | b[1] //按照十六进制化为二进制16位的或，
b[0] & b[1] //与

b[0] << 5 //左移5位，当大于 2的16次方时溢出 变为0,常规计算时当做整数来计算
b[1] >> 5 // 右移5位


```


### js截取字符串
```
jo

```
[参考文章](http://www.jb51.net/article/42482.htm)


#### js中的与或，是进行二进制操作时候的运算符分别为   | & , 下为一个温湿度传感器I2c例子;


```
var m = require('mraa');

var ic = new m.I2c(0);

var a = ic.address(64); //SHT20 7位地址是1000 000 ,我测试了地址0到125,返回0,但126到256返回5，所以只能用前七位

console.log(a);  // a=0

ic.writeByte(0xF3); //发送触发温度测量命令 ,返回0

setTimeout(read, 90); //因为是no hold mode ,需要等待90ms

function read() {
    var re = ic.read(2); //re 得到的是缓冲区,2个8位十六进制数 

	re[1] = re[1]&0xFC; //低8位后两位置0

    var result = re[0]<<8+re[1]; //高8位左移8位，与低8位合并，得到一个常数

    console.log(result);

    var a = result/Math.pow(2,16);

    var tm = -46.85 + 175.72*a;

    console.log(tm); //所得值与环境温度不匹配
}
```

### js 判读是否存在变量
```
//判断变量i是否存在
typeof(i)=="undefined": 未定义
//是否存在指定函数 
function isExitsFunction(funcName) {
    try {
        if (typeof(eval(funcName)) == "function") {
            return true;
        }
    } catch(e) {}
    return false;
}
//是否存在指定变量 
function isExitsVariable(variableName) {
    try {
        if (typeof(variableName) == "undefined") {
            //alert("value is undefined"); 
            return false;
        } else {
            //alert("value is true"); 
            return true;
        }
    } catch(e) {}
    return false;
}
```
