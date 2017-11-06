title: a good discription  of utisnips use
----

1. UtisnipsEdit ,进入当前后缀文件的snipets编辑
2. $1 或者 ${1:some} 一个步，或者使它带有缺省值
```
${1:div}
Hello World
${1/\w+\/hello/g} 当两处或者多处有$1时，要用变换（正则使他们的值不太一样）
其中1是跳转步， /\w+\/是正则， hello是要取代的

snippet  r
${1:div}
Hello World
${1/(\w+).*/$1/g}

${1:div}
Hello World
$1
```
3. 交互
  1. 和shell ,`echo hi`
  2. 和vimL , `!v "1+2" = string(1+2)`
  3. 和python , `!p snip.rv = "hello"`

4. 跳转，C+j, C+k
