title:npm
---
### npm 配置淘宝源三种方法
1. 通过config命令

npm config set registry https://registry.npm.taobao.org 
npm info underscore （如果上面配置正确这个命令会有字符串response）

2. 命令行指定

npm --registry https://registry.npm.taobao.org info underscore

3. 编辑 ~/.npmrc 加入下面内容

registry = https://registry.npm.taobao.org
