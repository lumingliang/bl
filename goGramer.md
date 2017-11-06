title: go lang 的学习
----

### win下安装go
官网下载msi，安装后，指定路径，该指定会在Path中添加该/bin ,然后还会添加GOROOT路径所在，因为编译的时候回自动在%GOROOT%/src/name/所在路径寻找name.go,添加自主的GOPATH 可以定义一个自己的工作路径，后面编译会自动在%GOPATH%/src/name/下寻找name.go,并把文件编译在%GOPATH%/bin下

### 写在前面

#### 从对js的基本理解到真正学习一门强大的语言，需要很多时间，而其中我这个战场也拉大了，（因为没有学习稳扎的js，但是因为好奇和时间和一些类似的因素，我决定先尝尝鲜，然后回头再来整合所有）

js中，一切都是对象，那么在go中，也是差不多的（除了一些原始类型，如int等），那么包就可以看做是一个大对象，对包的import，就是对对象的import
```

import (
	"fmt" //包名即路径 
	"math/rand" // 包名应该与路径的最后一个rand一致
)
// import 实际上得到了包的引用，暴露了一个可以引用某个包的变量，和js类似，只是js需要手动
```

#### 定义变量
```
func add(x, y int) int {  //声明在后，函数的返回类型也要声明
	return x + y
}

// 定义多个变量
var c, python, java bool // var开始，类型声明在后

// 声明变量可以在包的头部或者函数体内头部
package main

import "fmt"

var c, python, java bool

func main() {
	var i int
	fmt.Println(i, c, python, java)
}
```
#### 变量初始化
变量都是要用var定义的，如果变量定义时没有初始化，需要在后声明类型，如果已经初始化，则不需要，它的类型会跟初始化值一致
```
package main

import "fmt"

var i, j  = 1, 2
// 变量不允许多次定义，如var i = 8//会报错 

func main() {
	var c, python, java = true, false, "no!"
	fmt.Println(i, j, c, python, java)
}
```
#### 短变量声明
在每个包中，段变量声明只可以在函数体内，函数体外变量声明只能用var 
```
import "fmt"
p := 4 //报错，应改用var p = 4  
func main() {
	var i, j  = 1, 2
	k := 3 //短变量声明必须是要赋值了,也就是初始化
	c, python, java := true, false, "no!"

	fmt.Println(i, j, k, c, python, java)
}
```
#### 多结果返回值
```
package main

import "fmt"

//如果返回值是多个，需要从左往右指定它的类型
func swap(x, y string) (string, string) {
	return y, x
}

func main() {

	a, b := swap("hello", "world")  //变量声明也可以不用指定类型，但要在等号加入 := ,这样得到的类型会像js一样由内部智能分配
	// 上面还用到了连续赋值 a, b := c, d
	fmt.Println(a, b)
}
```
#### 裸return
```
func split(sum int) (x, y int) {
	x = sum * 4 / 9
	y = sum - x
	return // 裸return 会返回在函数头部声明的x, y (int) 类型这两个变量
	//但是裸return会在长函数中伤害可读性
	//但是裸return会在长函数中伤害可读性
}
```
###E go的类型
go  的类型有int ,int8, string等，以下
```
bool

string

int  int8  int16  int32  int64
uint uint8 uint16 uint32 uint64 uintptr //每一个类型都要注意溢出问题

byte // alias for uint8

rune // alias for int32
     // represents a Unicode code point

float32 float64

complex64 complex128
//

// int ,unitptr, 类型一般是32位在32的系统，64位在64位系统

var i int //如果没有初始化，会被赋值默认为0
 var f float64 //总之数字型的复制为0，strign赋值为"",string,需要用双引号
 var b bool // false default

// 类型转换
``
var i int = 42
var f float64 = float64(i) //强制转换左边必须是新的变量，如var f是新的变量
f = float32(i) //会报错
//另外，如果变量声明了，没有被使用，引用，会出现报错，包也一样

i := 42           // int
f := 3.142        // float64
g := 0.867 + 0.5i // complex128


```
#### go 的constans类型

constans 类型，不可以用 := 语法，值和类型不可以被改变
//注意，go中一旦定义了变量为int类型，就不可以直接把int变成string类型

constans类型用于表示数字类型时，可以动态一次性定义为高精度的数字
```

package main

import "fmt"

const (
	Big   = 1 << 100 //如果是int类型，最多只能是64位，但声明为const类型后，Big可以达到更高
	Small = Big >> 99 //新的const 变量，Big 右移99位
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

### 流控制

#### for : go中只有一个循环语句，就是for
for 语句没有了() ,
```
package main

import "fmt"

func main() {
	sum := 1
	for i := 0; i < 10; i++ {
		sum += i
	}
	fmt.Println(sum)
}
```
#### 用for模仿while (continue)
```

package main

import "fmt"

func main() {
	sum := 1
	var i int
	for ; sum < 1000; {
		sum += sum
		i += 1
	}
	fmt.Println(sum, i) //1024 10 ,说明运行了10次，最后才大于1000
}

// 更简洁的写法


func main() {
	sum := 1
	for sum < 1000 {
		sum += sum
	}
	fmt.Println(sum)
}

//死循环

func main() {
	sum := 1
	for i := 0; i < 10;  { //这里没有退出条件，所以会死循环
		sum += i
	}
	fmt.Println(sum)
}

// 更简洁的死循环

func main() {
	for {
	}
}
```
#### if
```
if x < 0 {
	return sqrt(-x) + "i"
}


package main

import (
	"fmt"
	"math"
)

func pow(x, n, lim float64) float64 {
//if 可以先运行一段小代码，但是只拥有局部作用域
	if v := math.Pow(x, n); v < lim {
		return v
	}
	//return v //会报错，提示没有这个变量
	return lim
}

func main() {
	fmt.Println(
		pow(3, 2, 10),
		pow(3, 3, 20),
	)
}

```
if else ,在if中定义的变量，在else代码块中仍然有用
```
func pow(x, n, lim float64) float64 {
	if v := math.Pow(x, n); v < lim {
		return v
	} else {
		fmt.Printf("%g >= %g\n", v, lim)
	}
	// can't use v here, though
	return 
}
```
#### switch 
```

package main

import (
	"fmt"
	"runtime"
)

func main() {
	fmt.Print("Go runs on ")
	switch os := runtime.GOOS; os { //先运行一小段代码，然后该变量在块中有效{}
	case "darwin":
		fmt.Println("OS X.")
	case "linux":
		fmt.Println("Linux.")
	default:
		// freebsd, openbsd,
		// plan9, windows...
		fmt.Printf("%s.", os)
	}
}


//switch 里面的case可以运行小段代码后比较

package main

import (
	"fmt"
	"runtime"
)

func main() {
	fmt.Print("Go runs on ")
	switch os := runtime.GOOS; os {
	case "darwin":
		fmt.Println("OS X.")
	case "linux":
		fmt.Println("Linux.")
	default:
		// freebsd, openbsd,
		// plan9, windows...
		fmt.Printf("%s.", os)
	}
}
```


switch 代替长的if else链, 因为空的switch等于switch true
```
package main

import (
	"fmt"
	"time"
)

func main() {
	t := time.Now()
	switch { //类似switch true ,当下面任何一个成立都会退出
	case t.Hour() < 12:
		fmt.Println("Good morning!")
	case t.Hour() < 17:
		fmt.Println("Good afternoon.")
	default:
		fmt.Println("Good evening.")
	}
}
```

#### defer go中实现事情延时非常简洁(类似js的generate)

虽然有了延时，只是延时到了所有任务执行完毕的下一个循环，但是没有js的手动启动它什么时候执行,由程序循环自动控制
```
package main

import "fmt"

func main() {
	defer fmt.Println("world")

	fmt.Println("hello")
	
	defer fmt.Println("worl")
	fmt.Println("helo")

	//输出
hello
helo
worl
world
	
}
```
go 的defer 机制
遇到了defer关键字的，就先把该事件（语句）存放入一个栈，这个栈是先进后出原则
```

package main

import "fmt"

func main() {
	fmt.Println("counting")

	for i := 0; i < 10; i++ {
		defer fmt.Println(i)
	}

	fmt.Println("done")
}

输出
9
8
7
6
5
4
...
```

#### poiters, 理解指针 
指针a是一个指向变量b的地址的变量，通过&b 可以得到b的地址，通过*a 可以利用指针a来操作变量b

```

var p *int // 声明一个指向int类型的 指针

package main

import "fmt"

func ch(t int) int {
	t = 33
	return t
}

func main() {
	i, j := 42, 2701

	p := &i         // point to i //通过取i的地址，直接赋值给变量p
	fmt.Println(*p) // read i through the pointer //通过指针操作符，*p,操作p所存地址的这个变量
	*p = 88    // set i through the pointer
	ch(*p)  //*p指针传值为对这个指针的复制 ,所以操作不会改变指针指向变量的值
	t := *p //t是*p的一个复制
	fmt.Println(i, t)  // see the new value of i

	p = &j         // point to j
	*p = *p / 37   // divide j through the pointer
	fmt.Println(j) // see the new value of j
}
```
彻底理解指针，变量就是一个地址加一个值，不管是什么东西，在内存中，都是一个地址，一个值
```
var a = 0 //变量a的值是0
a += 5 //为什么直接调用a能改变a的值？因为默认了a就是拿到了a的值得存放地址，有了这个地址就可以操作a的值改变
```
指针是一种间接操作，也就是先知道了某个变量的存放地址，那么知道了地址就要利用指针工具*来操纵它
```
p := 8
t := &p //把p变量的存放地址赋值给t，也就是t的值是一个地址，（出于安全不可以改变t的值了，因为它的值是地址，但是t本身就是一个变量，也有它自己的地址）
*t = 9 //t只能被指针操作符来操作了，也就是t的作用就是用来远程操作p，
g := t //将g的值设置为t的值，也就是p的地址
*g = 10 //同样可以远程操作到p
g = 88 //会报错，因为g存放的是地址，不能改变了，只能传值,
k := &g // k变量保存为g的地址，但是g的值是p的地址，同理k的作用是远程操作g，而g的作用是远程操作p
所以，只能用
**k 来远程操作p，这里要看是什么用，记住地址为了安全，不能修改，只能赋值和远程操作
```

```
// 有关指针的完整例子，永远记得指针只是一个变量，只是有特殊标志，让人知道，只是在操作指针本身的值（地址）， 还是利用它操作它指向的地址的值

package main

import "fmt"

// 指针传值,因此可以实现改变内容，js中为引用传值，与这里实际上是一个道理，go/c中引用的概念相当于一个别名，并不是地址传值
func cha(p *int) int {
	*p = 43432
	return *p
	}

func main() {
	i, j := 42, 2701

	p := &i         // point to i
	fmt.Println(*p) // read i through the pointer
	*p = 21         // set i through the pointer
	fmt.Println(i)  // see the new value of i

	p = &j         // point to j
	*p = *p / 37   // divide j through the pointer
	fmt.Println(j) // see the new value of j
	
	fmt.Println(cha(p), *p, j)
}
```

##### go中复杂类型，如slice, array, map  等

结构体struct 用来更好的规划数据结构，但这非常节省内存
```
package main

import "fmt"

type Vertex struct {
	X int
	Y int
}

func main() {
	fmt.Println(Vertex{1, 2})
}


// 指向struct的指针，默认不用*前置即可操作
type Vertex struct {
	X int
	Y int
}

func main() {
	v := Vertex{1, 2} // 这个是type{value} 形式的，不同于前面value type ,而且是连着的
	p := &v
	t := Vertex{4, 6} 
	p = &t //指向struct的指针可以重新指向该类型的另一个地址
	p.X = 1e9 //直接操作的就是指针
	fmt.Println(v)
}
```
##### array ,数组是要有固定长度的
```
var a [10]int

var a [2]string
a[0] = "Hello"
a[1] = "World"
fmt.Println(a[0], a[1])

// 数组直接返回的是指针，而a[0] 是下一个指针,(记得指针是一种远程操纵，即代表是要操纵当然值(是一个地址)的值)
```
##### Slice是一种可变的“集合”, 类似c中的动态数组,但比它要方便,应该是利用链表思维来实现的。,slice拥有长(length)度和容量(capacity), 只有拥有长度才可以使用a[2]形式读取值，只有拥有容量，才可以切割a := b[:cap[2]], slice有特定的api来动态添加，操作; 创建slice可以直接声明，声明加初始化，或者用make方法；


b := make([]int, 0, 5) // len(b)=0, cap(b)=5

```
//声明一个空slice : x []int //这个 slice长度和容量都是0
//  声明一个非空slice必须先赋值
s := []int{2, 3, 5, 7, 11, 13} // int类型的slice,与数组区别是，[len]不用表明，后面是初始值

fmt.Println("s ==", s)
fmt.Println("s[1:4] ==", s[1:4])

// missing low index implies 0
fmt.Println("s[:3] ==", s[:3])

// missing high index implies len(s)
fmt.Println("s[4:] ==", s[4:])


```

```
// slice动态添加元素
func main() {
	var s []int
	printSlice(s)

	// append works on nil slices.
	s = append(s, 0)
	printSlice(s)

	// The slice grows as needed.
	s = append(s, 1) // func append(s []T, vs ...T) []T
	printSlice(s)

	// We can add more than one element at a time.
	s = append(s, 2, 3, 4)
	printSlice(s)
}

func printSlice(s []int) {
	fmt.Printf("len=%d cap=%d %v\n", len(s), cap(s), s)
}
```
```
for range 历遍一个 slice

var pow = []int{1, 2, 4, 8, 16, 32, 64, 128}

func main() {
	for i, v := range pow {
		fmt.Printf("2**%d = %d\n", i, v)
	}
}

// 历遍slice需要得到它的index和value，当然可以更高效，只使用它的值

func main() {
	pow := make([]int, 10)
	for i := range pow {
		pow[i] = 1 << uint(i) // == 2**i
	}
	for _, value := range pow { //用_, 代表忽略index
		fmt.Printf("%d\n", value)
	}

	// 如果只要索引index
	for i := range pow {
		fmt.Printf(i)
	}
}
```

##### 复杂类型除了slice还有map  (这两个是最基本的),slice可以动态添加，map也可以,创建map必须使用make方法

```

var m map[string]Vertex //声明一个map ,其中要表明key, value的类型

func main() {
	m = make(map[string]Vertex) //实际上还是需要用make方法
	m["Bell Labs"] = Vertex{
		40.68433, -74.39967,
	}
	fmt.Println(m["Bell Labs"])
}

type Vertex struct {
	Lat, Long float64
}

// 以下却不用写make方法
var m = map[string]Vertex{
	"Bell Labs": Vertex{
		40.68433, -74.39967,
	},
	"Google": Vertex{
		37.42202, -122.08408,
	},
}
```

##### 函数与闭包, 函数可以作为值传过来，也可以使用闭包
```
package main

import (
	"fmt"
	"math"
)

func compute(fn func(float64, float64) float64) float64 {
	return fn(3, 4)
}

func main() {
	hypot := func(x, y float64) float64 {
		return math.Sqrt(x*x + y*y)
	}
	fmt.Println(hypot(5, 12))

	fmt.Println(compute(hypot))
	fmt.Println(compute(math.Pow))
}

// 闭包
package main

import "fmt"

func adder() func(int) int {
	sum := 0
	return func(x int) int {
		sum += x
		return sum
	}
}

func main() {
	pos, neg := adder(), adder()
	for i := 0; i < 10; i++ {
		fmt.Println(
			pos(i),
			neg(-2*i),
		)
	}
}
```

操纵map

```
// 有map m
新增或者修改
m[key] = value

获取
m[key]

删除
delete(m, key)

测试map中是否有该key 

elem, ok := m[key]
// 如果有ok为true,且elem等于该key的值
```



#### go中的面向对象
##### 类
go 的面向对象是基于结构体的（struct），结构体本来只有变量，但是应该把函数也看做变量，即把新定义的方法（函数）发送到struct中，然后它接收就可以实现了方法和变量同在，也就是类了。

类的成员有属性与方法，属性是每个类都独立的，而方法是每个类共有的，go中有种机制，可以用strut 定义类中所有属性，然后利用类似接收者机制，把一个方法归结到stuct中使用，合成了一个类

```

package main

import (
	"fmt"
	"math"
)

type Vertex struct {
	X, Y float64
}

func Abs(v Vertex) float64 {  //普通函数,传入一个v, (复制传值)
	return math.Sqrt(v.X*v.X + v.Y*v.Y)
}

func (v Vertex) Abs() float64 { // 类的方法(区别于普通函数，因为它显式表明了接收者是Vertex类型的v，)
	return math.Sqrt(v.X*v.X + v.Y*v.Y)
}

func main() {
	v := Vertex{3, 4}
	fmt.Println(Abs(v))
	v := Vertex{3, 4}
	fmt.Println(v.Abs())
}


// 不管是函数形式还是接收者形式实现“类”，都要利用指针，以便可以直接修改值，和实现更高的效率，（不用复制一份）
package main

import (
	"fmt"
	"math"
)

type Vertex struct {
	X, Y float64
}

func (v *Vertex) Scale(f float64) { //类的方法
	v.X = v.X * f //sturct中使用指针不用前置 *
	v.Y = v.Y * f
}

func (v *Vertex) Abs() float64 { 
	return math.Sqrt(v.X*v.X + v.Y*v.Y)
}

func main() {
	v := &Vertex{3, 4}
	fmt.Printf("Before scaling: %+v, Abs: %v\n", v, v.Abs())
	v.Scale(5)
	fmt.Printf("After scaling: %+v, Abs: %v\n", v, v.Abs())
}
```
##### 接口
接口其实就是换装，即把不同名称的类，（但这些类有共同的方法）附加到接口中，或者反过来说，就是定义接口，然后用不同的类实现它.

go 中的接口实现与go中实现类的方法类似，定义接口时，只需定义接口存在的方法，然后直接让该接口等于任何一个实现了这个方法的类即可

```

type Abser interface { // 声明一个接口
	Abs() float64
}

func main() {
	var a Abser //声明一个接口值
	f := MyFloat(-math.Sqrt2)
	v := Vertex{3, 4}

	a = f  // a MyFloat implements Abser //使用接口实现即使直接赋值
	a = &v // a *Vertex implements Abser //如果实现方法利用指针就要传地址

	// In the following line, v is a Vertex (not *Vertex)
	// and does NOT implement Abser.
	//a = v

	fmt.Println(a.Abs())
}

// 接口实现极为简单（思维当作js中的标识型实现接口）, 只需要在类中有这个方法(实现这个方法)即可
type MyFloat float64

func (f MyFloat) Abs() float64 {
	if f < 0 {
		return float64(-f)
	}
	return float64(f)
}

//这里也是同理,书写接口实现就是写一个类
type Vertex struct {
	X, Y float64
}

func (v *Vertex) Abs() float64 {
	return math.Sqrt(v.X*v.X + v.Y*v.Y)
}
```

```
空接口


type I interface {
	M()
}

type T struct {
	S string
}

func (t *T) M() {
	if t == nil {
		fmt.Println("<nil>")
		return
	}
	fmt.Println(t.S)
}

func main() {
	var i I

	var t *T
	i = t
	describe(i)
	i.M()

	i = &T{"hello"}
	describe(i)
	i.M()
}

func describe(i I) {
	fmt.Printf("(%v, %T)\n", i, i)
}



// 空接口可以包含任何值
package main

import "fmt"

func main() {
	var i interface{} // 这里是一个空接口
	describe(i)

	i = 42
	describe(i)

	i = "hello"
	describe(i)
}

func describe(i interface{}) {
	fmt.Printf("(%v, %T)\n", i, i)
}
```

接口类型判断
```
package main

import "fmt"

func main() {
	var i interface{} = "hello"

	s := i.(string) //判断接口是不是string类型
	fmt.Println(s)

	s, ok := i.(string)
	fmt.Println(s, ok)

	f, ok := i.(float64)
	fmt.Println(f, ok)

	f = i.(float64) // panic
	fmt.Println(f)
}
```


string类型有许多内置方法，如打印时，默认是调用String()方法来输出打印行为，如果实现该接口，那么可以自定义打印输出行为

```
package main

import "fmt"

type Person struct {
	Name string
	Age  int
}

func (p Person) String() string {
	return fmt.Sprintf("%v (%v years)", p.Name, p.Age)
}

func main() {
	a := Person{"Arthur Dent", 42}
	z := Person{"Zaphod Beeblebrox", 9001}
	fmt.Println(a, z)
}
```

##### 错误处理，类似stinger, 每个操作go中都有错误处理接口，只要实现 了自己的错误处理方法，就可以使用自己的方法来处理错误

```
package main

import (
	"fmt"
	"time"
)

type MyError struct {
	When time.Time
	What string
}

func (e *MyError) Error() string {
	return fmt.Sprintf("at %v, %s",
		e.When, e.What)
}

func run() error {
	return &MyError{
		time.Now(),
		"it didn't work",
	}
}

func main() {
	if err := run(); err != nil {
		fmt.Println(err)
	}
}
```

##### go goroutine  

go中的协程，是一种超级轻量化的协程，宏观工作方式类似进程，即运行协程后，协程会在跟当前协程平行的协程中独立运行，(但却可以共享内存), 如果新的独立协程有异步行动，当前协程需要用到，那么当前协程会像同步进程一样等待。但是如果同时创建多条新的协程，这多条协程之间是独立，并且互相平行工作

协程之间通过chanel + 管道来通信，想象每个协程是独立的一个人，然后回监听一条或者多条管道，如果管道有内容过来，就开始特定的工作

```
func sum(a []int, c chan int) {
	sum := 0
	for _, v := range a {
		sum += v
	}
	c <- sum // 将和送入 管道c
}

func main() {
	a := []int{7, 2, 8, -9, 4, 0}

	c := make(chan int) // 声明一个管道
	go sum(a[:len(a)/2], c) //协程独立运行,并往下
	go sum(a[len(a)/2:], c) //协程独立运行,并往下
	go fmt.Println("t") //协程独立运行,因为这个比较快，会先得到返回，
	x, y := <-c, <-c // 从 c 中获取 //后面的必须等待前面所有协程运行完毕才执行,因为管道的另一端没有准备好，会阻塞

	fmt.Println(x, y, x+y)
	fmt.Println(434)
}
```


```
func fibonacci(n int, c chan int) {
	x, y := 0, 1
	for i := 0; i < n; i++ {
		c <- x
		x, y = y, x+y
	}
	close(c) //先是不断向管道中送数据，最后发送一个结束信号
}

func main() {
	c := make(chan int, 10)
	go fibonacci(cap(c), c) //抛出一条新的协程,独立工作，程序往下执行
	for i := range c {  //不断从管道中抽取内容, 直到结束
		fmt.Println(i)
	}

	fmt.Println('test order') //最后运行，因为前面的没有完全运行完
}
```


```
func fibonacci(c, quit chan int) {
	x, y := 0, 1
	for { //不断循环，但是当条件不满足时，会阻塞
		select {
		case c <- x:  //如果可以往管道中送入x值，就执行它
			x, y = y, x+y
		case <-quit: //如果能从管道quit中取出值，就执行它
			fmt.Println("quit")
			return // 结束for循环
		}
	}
}

func main() {
	c := make(chan int)
	quit := make(chan int)
	go func() { //抛出协程，独立工作，往下 执行
		for i := 0; i < 10; i++ {
			fmt.Println(<-c) //这个协程不断读取c管道值十次,一般情况下发送和读取时配套的，所以fibonacci协程会在十次之后不向c管道发送内容了
		}
		quit <- 1
	}()
	fibonacci(c, quit)
}
```

```
// 锁，控制某一个值同一时刻只被一个协程访问

package main

import (
	"fmt"
	"sync"
	"time"
)

// SafeCounter 的并发使用是安全的。
type SafeCounter struct {
	v   map[string]int
	mux sync.Mutex
}

// Inc 增加给定 key 的计数器的值。,类的方法
func (c *SafeCounter) Inc(key string) {
	//c.mux.Lock()
	// Lock 之后同一时刻只有一个 goroutine 能访问 c.v
	c.v[key]++
	//c.mux.Unlock()
}

// Value 返回给定 key 的计数器的当前值。
func (c *SafeCounter) Value(key string) int {
	//c.mux.Lock()
	// Lock 之后同一时刻只有一个 goroutine 能访问 c.v
	defer c.mux.Unlock() //用defer保证一定会被解锁
	return c.v[key]
}

func main() {
	c := SafeCounter{v: make(map[string]int)}
	for i := 0; i < 1000; i++ {
		go c.Inc("somekey") //并发1000个协程
		//fmt.Println(44)
	}

	time.Sleep(time.Second)
	fmt.Println(c.Value("somekey"))
}
```
