title:use ubuntu
---
## 查看系统版本和cpu
### 查看cpu
```
more /proc/cpuinfo
```
#### 其中clflush size 显示了系统是多少位
### 查看系统版本
```
cat /etc/issue
```

### yum使用
1. 配置仓库，修改默认仓库vi /etc/yum.repos.d/CentOS-Base.repo
2. 可以配置多个仓库，yum repolist all
3.  新增的话可以在/etc/yum.reops.d/目录下新建.reop文件
4. yum [list|info|search|provides|whatprovides] xxxx
5. yum [install|update] xxxx
6. yum remove xxx

### 环境变量 
1. 环境变量分为系统(/etc/profile)，用户(~/.bash_profile)，临时(export定义)三种
2. set ,重置本地已有变量， unset xx清除变量，如set TEST = Test, unset $TEST;
3. export 新增变量
4. 设置永久变量需要改配置文件，/etc/profile,~/.bashrc,~/.bash_profile,等,修改用法
5. export NEW=something
5. 修改后马上生效，运行，source /etc/profile.

### 配置路径环境变量，使命令能在所有目录使用
```
1. export PATH=$PATH:/usr/locar/new/bin
export PATH=$PATH:/usr/locar/new/bin
这条命令的意思为: 使PATH自增:/usr/locar/new/bin,
既PATH=PATH+":/usr/locar/new/bin";

2.
``` 
vi /etc/profile ,在适当位置添加，
PATH=$PATH:/etc/apache/bin 
$source profile(source /etc/profile) 
或者
./profile
```

### 永久配置alias
0. alias显示当前所有别名设置,
1. 使用alias l='ls -al';生成的是临时的
2. .bash_profile 或.bashrc(依据不同ditribute)，
3. 或者自己新建.bash_alias文件，里面可以定义了
4. **也可以用ln -s source dist配置当前可执行文件到/bin路径中
```
一些有用的 alias,
1,模拟dos风格
alias clr=clear
alias cls=clear
alias copy='cp -i'
alias del='rm -i'
alias delete='rm -i'
alias dir='ls -alg'
alias home='cd ~'
alias ls='ls -F'
alias md=mkdir
alias move='mv -i'
alias type=more

alias cd..='cd ..'
```
### pptpd vpn ,
1. 新增用户，vi etc/ppp/chap-secrets
2. 重启服务， /etc/init.d/pptpd restart
3. 若是可执行文件，可以直接复制到/usr/local/bin/jjjj下即可，
4. 查看所有端口信息：

##### 权限
1. chmod -R 777 dir 递归改读写权限
2. chown -R own:own dir 递归赋予用户own 目录dir的权限


##### ubuntu 中自带有方便的应该启动命令类似centos 的sytemctl 

可以不再用init.d去启动
initctl list 查看所有


sudo initctl restart php7.1-fpm
