##### 微信公众号配置
1. 申请测试号，扫描即可
2. appId:用在前端使用微信jsDk，并且配置好js安全域名， 在该域名下的js才可以调用
3. 服务端接收微信消息，需要填写url和token , token可以随意填写,token 用作加密
4. 网页登陆或公众号登陆，需要设置回调域名。当用户授权后，会跳转到该回调域名，重定向回调域名可以选择设置任何域名,如用vue开发时，应重定向到vue的域名下，让该js获取url参数的code，也即是，谁需要第一手获得code就是谁处理
4. oauth详解：1.网页向微信服务器(或app)发起需要授权(设置好回调)，用户得到授权提示，用户确认授权，微信服务器检测用户同意，并使浏览器跳转到1.中的回调地址并附加上code, 回调地址中利用code得到了很多消息
5. jsdk的获取只对当前url有效，所以还要动态的传递url过来，对于前后端分离的应用
