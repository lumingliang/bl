title:ssh远程登录linux
---
### ssh提供了一套远程登录操纵另外一台主机的密钥对，就像安装了一把锁和钥匙一样，公匙放在服务器上，私匙放在客户机上，公私匙由客户机产生。
公钥就是锁，私钥是钥匙，数据用公钥加密，只有私钥才能解开得到原始数据
#### 步骤如下
1. 客户机 ssh-keygen -t rsa -P '' -f 'filename',默认在.ssh下生产名为filename的公私匙


case 'Bg_Post.php':
case 'Bg_Post.php':
2. 客户机 scp .ssh/filename.pub user@192.168.10.107:~/ ,复制公匙到服务器，
3. chmod 700 .ssh , 服务器~/.ssh 文件需要为700权限
4. cat filename.pub >> .ssh/authorized_keys(此文件权限为600), 将公匙追加到服务器.ssh /xx中,一般到这就可以了，ssh user@ip;
5. 修改 /etc/ssh/sshd_config, 指向公匙位置 
6. 也可以用ssh -i local.pub root@ip 登录到服务器

### 传输文件夹
1. 服务器到本地 (**在本地运行**)
scp -r user@your.server.example.com:/path/to/foo /home/user/Desktop/
2. 本地到服务器（**在本地运行**）
scp -r /path/to/dir user@ip:/dir/
3. 传单个文件则去掉r
scp -i "sinapo-new.pem" ubuntu@52.74.209.168:~/ /d/nodejs

```
tar -czf som.tar.gz dir
scp -r ubuntu@52.74.209.168:~/monitor.tar.gz ~/


openssl 是一种加密算法，可以加密数据、以及签名验证，签名验证用私钥签名，公钥验证 ，加密用公钥加密，私钥解密
~/.ssh/ssh_config文件可以用来实现别名登陆其他服务器
```
Host        cjb

    HostName        216.194.70.6

    Port            22

    User            user

    IdentityFile    ~/.ssh/cjb

```
一个集群的主机能相互登陆的原因是，大家的id_sda 和pub都一样然后known_host一样
