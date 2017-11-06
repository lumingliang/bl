title: nodejs 的有关thread和fiber的用法
---
### 解释线程和fibers.
1. nodejs是单线程运行，也就是当一个代码在执行(如cpu密集型),其他代码是不会执行的，就算定时器时间到了，却也不会执行，非得等到当前代码执行完毕为止
2. 异步是指，node在执行io密集型代码时候(如fs),不进行阻塞，而是等到抛出io任务给其他人，自己主线程(唯一的线程)继续进行下去，等到空闲了，再检查事件队列，看是否io已经完毕，以便执行里面的回调！但这很容易写出<型的代码.也就是会有一大丢回调
3. fibers就是为了解决异步，但不进行回调的问题而产生的，fibers实际上任是异步，单线程，也就是同一时间只有一个fibers在执行，只有一段代码在执行，
```
var Fiber = require('fibers');
 
var inc = Fiber(function(start) {
    var total = start;
    while (true) {
        total += Fiber.yield(total);
    }
});
 
for (var ii = inc.run(1); ii <= 10; ii = inc.run(1)) {
    console.log(ii);
}
//从run开始执行，可以在run里面传递参数，执行到yield，开始停止执行yield后面的代码，也就是异步，等待异步事件完成后，回到yield(传递参数),并执行yield后面的代码，相当于回调，遇到yield的时候，开始异步，执行其他代码
```
4. 线程，真正的多线程，同一时间有多个线程存在，每个线程互不干扰，多线程可以使用多个cpu，而且使用cpu密集型
[参考nodejs多线程](https://cnodejs.org/topic/518b679763e9f8a5424406e9)
