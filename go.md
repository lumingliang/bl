title: golang learning
----
### go 是google 出品的一个真正编译性语言，它的速度很快，可以媲美c，c++，当然，还有原生的支持多并发，所以可以说是nodejs的强大对手，还有许多很现代化的功能，或者说是完全的各个语言集合的强大语言

----

### 基本语法
#### 包(package)
```
// package.go  文件名
package main // 每个文件就是一个包，这是包名

import (   //要引入的包名 ,在本包中，能使用的只是这里引入的包，其他未引入的包不能使用
	"fmt"
	"math/rand"
)

func main() { // 每个包都有主函数，类似c中的
	fmt.Println("My favorite number is", rand.Intn(10))
}

```
#### 函数
```

package main //包名

import "fmt" //引入的包，用"" ,字符串用""  ,如果引入包但未使用，会发生错误

func add(x int, y int) int { // 变量类型需要声明在变量后面，函数返回值类型声明在func 后 ,也可以x, y int
	return x + y  
}
//声明多个变量
// var i int 或  var c, python, js bool 
//变量初始化
var i, j = 1, 2 // 当有初始化的时候，就不需要声明变量类型

func main() {
	fmt.Println(add(42, 13))
}

// 声明后返回值


package main

import "fmt"

func split(sum int) (x, y int) { // 此处已经声明返回的是两个int类型的值
	x = sum * 4 / 9
	y = sum - x
	return
}

func main() {
	fmt.Println(split(17))
}

```
### 变量初始化

```

package main

import "fmt"

var i, j int = 1, 2  //在函数外面，变量声明都要以var开头,但在函数里面，可以用 := 代替

func main() {
	k := 3 //如上所述 
	var c, python, java = true, false, "no!"
	fmt.Println(i, j, c, python, java)
}
```

### 常规变量类型
```
bool

string // ""

int  int8  int16  int32  int64 //整数，分别用n位二进制表示，注意溢出问题，就是所保存数不能大于2的n次方 ,其中int 的位数和电脑有关，32位系统，就是32位，64位就是64
uint uint8 uint16 uint32 uint64 uintptr //存二进制，unit 位数与系统有关

byte // alias for uint8

rune // alias for int32
     // represents a Unicode code point

float32 float64

complex64 complex128




package main

import (
	"fmt"
	"math/cmplx"
)

var (
	ToBe   bool       = false
	MaxInt uint8     = 8<<3 - 1  //左移后会变大，如果移位后得到的值大于unit8所能容纳的最大值，将会有溢出错误
	z      complex128 = cmplx.Sqrt(-5 + 12i)
)

func main() {
	const f = "%T(%v)\n"
	fmt.Printf(f, ToBe, ToBe)
	fmt.Printf(f, MaxInt, MaxInt)
	fmt.Printf(f, z, z)
}


// 变量初始化如果没有显示初始化explicit

0 for numeric types, //0 ,数字型的包括int float等
false the boolean type, and
"" (the empty string) for strings.
// 变量如果有初始化，那么变量类型就视初始化给的值而定

///静态值
	const Pi = 3.14 //静态值不可以 := 

// const 类型的可以储存高精度的数字
const (
	Big   = 1 << 100
	Small = Big >> 99
)

func needInt(x int) int { return x*10 + 1 }
func needFloat(x float64) float64 {
	return x * 0.1
}
func main() {
	fmt.Println(needInt(Small))
	fmt.Println(needFloat(Small))
	fmt.Println(needFloat(Big))
}
```
#### 类型转换
```
var i int = 42
var f float64 = float64(i)
var u uint = uint(f)

Or, put more simply:

i := 42
f := float64(i)
u := uint(f)
```

### 循环，只有 for
```
package main

import "fmt"

func main() {
	sum := 0
	for i := 0; i < 10; i++ {
		sum += i
	}
	fmt.Println(sum)
}

// 可以放空前后
for ; sum < 1000; {
		sum += sum
	}

// while 用 for 替代

    sum := 1
	for sum < 1000 {
		sum += sum
	}
	fmt.Println(sum)
//无限循环	
	for {
		}
```
### if 和 else ,if后面声明的新变量和新短语句可以在 else中使用，但不可以在if else 外使用 
```

import (
	"fmt"
	"math"
)

func pow(x, n, lim float64) float64 {
	if v := math.Pow(x, n); v < lim {
		return v
	} else {
		fmt.Printf("%g >= %g\n", v, lim)
	}
	// can't use v here, though
	return 
}

func main() {
	fmt.Println(
		pow(3, 2, 10),  //两个pow的调用比Println 先，时同时运行的
		pow(3, 3, 20),
	)
}
```


####### go项目目录结构
http://blog.studygolang.com/2012/12/go%E9%A1%B9%E7%9B%AE%E7%9A%84%E7%9B%AE%E5%BD%95%E7%BB%93%E6%9E%84/
go 语言依赖 
https://studygolang.com/articles/2147

go 的命令
http://wiki.jikexueyuan.com/project/go-command-tutorial/0.1.html


```
go run xx.go 在线运行
go build  以当前目录main.go为基准，build exe

```
下载好go后，先配置好GOPATH 所有依赖都会在此目录的src下面
每一个目录即包名，包名下面的文件名可以直接使用。函数引用包名.文件名.func
主文件包名，为main
package 名可以与目录名不一样
引入时候先
```
"github.com/googollee/go-socket.io" 到目录名
然后下面有个名为xxx.go pakcage 名为socketio 的文件，改文件里面有func函数
外部使用时 socketio.func
即同一目录下的文件名不太重要，但是要统一包名
```

###### go指针
指针在编译语言中，用来操作、访问变量，而不是该变量的复制版本
a := &b 获取b的指针
*a 得到b的值， 一般如果b是数据或者结构体等复杂类型变量，可以用a直接使用
但是在使用前的类型声明时，要声明a是一个指针 (a *b)

type xx =int8 创建一个新的类型


###### go 面向对象
go中类用type xx struct来实现，后面跟一丢方法
go map 类型，类似字典 var a  map[keyType]valueType
```
rating := map[string] float32 {"C":5, "Go":4.5, "Python":4.5, "C++":2 }
// 复杂的val类型
myMap := map[string] personInfo{"1234": personInfo{"1", "Jack", "Room 101,..."},}

```
 map是一种引用类型，如果两个map同时指向一个底层，那么一个改变，另一个也相应的改变。

 go 协程 
 https://blog.csdn.net/u011304970/article/details/76168257


 golang 接口，只是一种声明，用于类型限制
 一个类不用显式的声明是实现了这个接口，只需要在定义变量时声明是这种接口类型，然后传过来的类又有该些方法即可。接口就相当于一个契约

 interface{}是可以传任意参数的，

 ```
 if v2, ok := v.(string);ok

 先赋值v2,ok := v.(string) 看是否成功，成功就是if ok 
 ```

###### 处理错误
 当一个函数在执行过程中出现了异常或遇到 panic()，正常语句就会立即终止，然后执行 defer 语句，再报告异常信息，最后退出 goroutine。如果在 defer 中使用了 recover() 函数,则会捕获错误信息，使该错误信息终止报告。
 ```
 func catch(nums ...int) int {
 defer func() {
  if r := recover(); r != nil {
   log.Println("[E]", r)
  }
 }()

 return nums[1] * nums[2] * nums[3] //index out of range
}
 ```

 golang defer 函数会在return执行后（但并没有真正return，并且停掉），开始执行。
 ```
 func f() (result int) { 

    result = 0 //return语句不是一条原子调用，return xxx其实是赋值＋RET指令 

    func() { //defer被插入到return之前执行，也就是赋返回值和RET指令之间 

        result++ 

    }() 

    return

}
该函数声音result 是返回值，那么直接写return 会将内部的变量result 返回。
如果内部没有该变量，会自动生成该变量 如return nil 会赋值 result = nil 
 ```

##### 小贴士
 import 就是import整个目录，然后整个目录下的文件都可以随意用
 因为是编译性语言，只要知道目录就不用声明文件了
 处于同一个目录下的两个文件，互相引用不用声明,不用import就可以直接用
 每个文件都有一个packname，引用时，先声明目录，然后用packname.xxx来访问

 go中的类：先用strut声明变量，然后用func传递接收者来获得函数


 go get 出现报错并不一定是因为包没装好，而是因为go get 可能会自动编译包，然后该包下没有.go文件


###### protobuf
 是一个通讯格式。可以用该语言特定的exe或者执行文件，产生一个该语言的文件，直接在程序里面使用，用来对数据进行交换
 一个.proto 文件可以用在多种语言

 golang种
 ```
 下载protoc.exe,proto生成.go文件的工具 https://github.com/google/protobuf/releases
 复制到go的bin下面
 go get -u github.com/golang/protobuf/proto

go get -u github.com/golang/protobuf/protoc-gen-go （到该目录去编译获得protoc-gen-go 执行文件并放到go 的bin下面
 ```
####### 结构体复制
 golang map是引用传值
 ```
    T1 := &TestS{1}
    T2 := *T1
    T3 := &T2   
    T3.a = 5
    log.Print(T1)
    log.Print(T3)

 ```
