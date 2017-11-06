##### 跨域问题
1. 跨域问题是因为浏览器的限制，区别不同域名不允许访问
2. 解决跨域方法jsonp，cros，一般现代浏览器已经允许cros，只需要后端配合，对于复杂的cros，浏览器先询问cors.domain看是否允许跨域，如果允许则返回相应的文件头，再进行真正的http请求。当然这里有个注意的是跨域cookie没有带去，所以需要一定的技术在请求头强制加入cookie，yii可能已经允许了
3. 设置代理，即将this.com/api通过代理转发到other.com/api上
4. ionic中配置代理服务,ionic.config.json中
```
  "proxies": [{
    "path": "/api",
    "proxyUrl": "http://www.local.jiliha.com"
  }]
```
5. ionic运行在设备上，因为是直接通过//file:访问页面的，所以不存在跨域问题
6. ionic 的页面跳转可能会不允许非本站跳转，可以尝试whiteList插件
7. 参考[cros跨域](http://www.cnblogs.com/aweifly/p/5647819.html)
[ng cros跨域](https://my.oschina.net/blogshi/blog/303758)
[代理跨域](http://ionichina.com/topic/54f051698cbbaa7a56a49f98)

8. 用vscode编写ts，安装vim，js-css-format扩展
    *format 使用方法，a+s+f 或者F1输入 Formatter得到配置文件
    *C+p 可以输入一切想要的
9. 常用命令
```
ionic serve 
ionic build minify
```
10. 必备插件
```
cordova-plugin-compat 1.1.0 "Compat"
cordova-plugin-console 1.0.5 "Console"
cordova-plugin-contacts 2.2.1 "Contacts"
cordova-plugin-crosswalk-webview 2.2.0 "Crosswalk WebView Engine"
cordova-plugin-device 1.1.4 "Device"
cordova-plugin-splashscreen 4.0.1 "Splashscreen"
cordova-plugin-statusbar 2.2.1 "StatusBar"
cordova-plugin-whitelist 1.3.1 "Whitelist"
ionic-plugin-keyboard 2.2.1 "Keyboard"
```
11. 修改ionic cofing.xml文件，使Splashscreen 不自动隐藏
