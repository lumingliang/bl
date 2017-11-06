title: express框架的深入理解
----
### 从一个最简单的服务器开始，服务器的根本就是传入请求，分析请求，调用本地资源，返回客户端
```
// 引入所需模块  
var http = require("http");  
var t = ''; //用全局变量保存每个不同客户端的信息，用特定的隐藏域与客户端交换通信，认清哪个是该客户端
   
// 建立服务器  
var app = http.createServer(function(request, response) {  
// 创建answer变量  
    var answer = ""; //用私有变量，实现每一个请求的内部不同逻辑 
    answer += "Request URL: " + request.url + "\n";  
    answer += "Request type: " + request.method + "\n";  
    answer += "Request headers: " + JSON.stringify(request.headers) + "\n";  
   
	t += 'add jj' + request.url;
    // 返回结果  
    response.writeHead(200, {"Content-Type": "text/plain" });  
    response.end(answer+t);  
});  
   
// 启动服务器  
app.listen(1337, "localhost");  
console.log("Server running at http://localhost:1337/"); 
```
