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
