title: openshift的一些用法

openshift 中的应用创建后，第一件事就是要连接该应用。连接该应用的方法是使用crt远程连接。

首先需要在setting中加入一个ssh公共密钥，可以在  .ssh中找.pub文件，然后复制所有内容，粘贴在setting中 ssh key中，之后就是设置ssh 的登录名。登录地址。一定要记住用户名就是user@address.com

##### 修改代码
```
// 先从openshift中克隆下来
git clone ssh://570f54fc2d5271e8cc000031@phpl5test-lumin.rhcloud.com/~/git/phpl5test.git/

然后
git add 
git commit -m 'my first commit'
git push
```


