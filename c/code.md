##### 编程相关，主要记录一些比较新的和有用的编程手法
1. yield方法在py、js、php中都有，主要是使程序在yield处中断执行，返回一个记录当前程序运行状况（变量）和位置的iterable，需要调用iterable.next()才能使程序不断执行，在for循环里面会自动调用这个方法
2. 带有yield语句的function都是一个特殊的function
斐波那契数列
```
yield后返回的值是b
 def fab(max): 
    n, a, b = 0, 0, 1 
    while n < max: 
        yield b 
        # print b 
        a, b = b, a + b 
        n = n + 1 
//调用
for n in fab(5): 
    print n 
```
