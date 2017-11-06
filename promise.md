title: promise的最新较好实现
----
### 一个相对容易理解的实现，不过没有错误处理机制
js的异步操作，有四种方法，[参考](http://www.ruanyifeng.com/blog/2012/12/asynchronous%EF%BC%BFjavascript.html)
1. 回调
2. 事件监听
3. 发布、订阅
4. promise

### promise模式的简单代码实现
```
//constructor
var Promise = function() {
    this.callbacks = [];
}

Promise.prototype = {
	// 创建promise对象
    construct: Promise,
    resolve: function(result) {
        this.complete("resolve", result);
    },

    reject: function(result) {
        this.complete("reject", result);
    },

    complete: function(type, result) {
		//历遍该promise里面的等待执行的函数，每执行一个就删除一个，前提是里面的操作都不能是异步的
        while (this.callbacks[0]) {
            this.callbacks.shift()[type](result);
        }
    },

    then: function(successHandler, failedHandler) {
        this.callbacks.push({
            resolve: successHandler,
            reject: failedHandler
        });

		// 返回this 该对象，实现链式操作
        return this;
    }
}
```

