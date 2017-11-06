title: git  的用法
1. apt-get install git 
2. 配置本地的git用户名与邮箱，git config --global user.name "Your Name"
$ git config --global user.email "email@example.com"
3. mkdir new ,cd new ,
4. git init , 在当期目录下新建空仓库
5. git add foo.txt , git add foo/* ,  添加一些东西到缓存区
    5.1 git rm --cache /path to file/ ,删除缓冲区文件
	5.2 git rm -f /path/ ,先删除缓存，还会从物理中删除
	5.3 touch 创建文件
	5.4 -f 是强制，-r是递归删除
6. git status ,查看现在缓存区的状态，知道是否已经提交到工作区
7. git commit -m 'some discription'; 正式提交到工作区，得到了一个新版本
8. git log 查看各个版本,最后的版本在上
9. 重复以上git add ,git commit ，得到2版本，
10. git reset commit_id ,将版本恢复到某个，可以在git log  中查看,其中HEAD 代表最新版本，HEAD~,代表最新开始倒数第二个，
11. git remote add origin git@github.com:lumingliang/l5_good.git ,添加origin(当前状态)与远程 配对
git push -u origin master, 将origin传到远程
//用 ssh ，将东西推送到github
12. 注意，ssh ,将已有或者新建的公玥传到github ,的ssh中，实现无密码传送
13. git remote remove foo ,删除某个remote;

14. git remote查看有多什么remote, git remote -v 显示更详细


#### 每次提交的版本就像一条时间线，每一次提交，时间线就向前走一步，而master主分支就指向当前的最新点，如果创建了其他dev分支，那么该分支会创建一个指向当前的指针，切换到该dev分支，后面的提交都是只对该指针有效，dev会向前，但是master不会。直到合并后，才会。
15. git branch 查看当前所在分支
16. git branch <name> 创建分支
17. git checkout <name> 切换分支
18. git checkout -b <name> 创建并切换分支
19. git merge <name> 合并某分支到当前(一般切换到master把dev分支合并到master)
20. git branch -d <name> 删除分支

#### 但是当主分支和dev都有新的提交时，合并就会有冲突，git会支出两次提交的不同内容

21. git status会看到合并失败的信息，(two branch are both modified),这时候可以查看该冲突文件内容，会看到git的标志，修改后，再合并，git会以当前修改的版本为基准合并，git log可以看到合并图

#### 多人协作
多人协作是多人一起在同一个分支或不同分支开发，然后都可以用pull看到对方的代码，就像有个自动的代码更新一样，你只需要提交自己的更新，然后解决冲突，最后把所有合并到master,基本步骤如下。
1. 有个原始的master, 在master上创建dev分支，A :git clone得到该master分支，如果A的密钥跟远程origin()的对口，那么就可以用git remote -v查看推送权限
2. A有了推送权限后，可以用git checkout -b deb origin/dev 创建本地的dev分支对应远程的origin/dev 分支，当修改后，commit再push到origin即可
3. 如果push不成功，那么就是有文件的提交跟origin dev的最新提交冲突，需要pull下来解决冲突再提交
4. git pull,(如果失败，说明没有建立本地dev到远程 origin/dev的链接),git branch --set -upstream dev origin/dev来创建,这时再git pull就成功了，
5. pull回来之后，需要解决冲突，方法是，打开本地冲突文件，就会标志出冲突地方，然后修改，最后git commit -m "merge & fix conflit hello.py"后，再push 这样就可以了
缓存区 => 工作区 是git管理，而源码只有一个状态，可以用git来实现对源码与缓存区，缓存区与工作区间的同步,远程提交，只提交源码，缓存区与工作区用来进行版本管理与还原

缓存区监控源码修改，如果源码修改了没有放入缓存区，缓存区会显示没有更新,
##### 版本还原
1. git reset HEAD^ 将工作区的版本还原为上一个版本，这时源码没有改变，只是工作区保存的版本变少了，此时缓存区显示当前修改没有提交，这里就相当于没有执行git commit一样,有利于远程提交，因为远程提交的是工作区里面的最新版本，并不是当前源码
(1) 回退所有内容到上一个版本  
git reset HEAD^  
(2) 回退a.py这个文件的版本到上一个版本  
git reset HEAD^ a.py  
(3) 向前回退到第3个版本  
git reset –soft HEAD~3  
(4) 将本地的状态回退到和远程的一样  
git reset –hard origin/master  
(5) 回退到某个版本  
git reset 057d  
(7) 回退到上一次提交的状态，按照某一次的commit完全反向的进行一次commit  
git revert HEAD   


 git reset --mixed：此为默认方式，不带任何参数的git reset，即时这种方式，它回退到某个版本，只保留源码，回退commit和index信息

    git reset --soft：回退到某个版本，只回退了commit的信息，不会恢复到index file一级。如果还要提交，直接commit即可

    git reset --hard：彻底回退到某个版本，本地的源码也会变为上一个版本的内容

2. 如果要实现源码还原需要用git reset --hard git_log_id(git log后复制id即可)


### 设置终端
```
// 先清除掉.ssh目录下的钥匙,*(为了创建默认，如果技术成熟也可以用新的名)
//在默认~/.ssh/下创建默认的钥匙
ssh-keygen -t rsa -C "angelen10@163.com"
//运行ssh代理
eval "$(ssh-agent -s)"
//添加钥匙到代理
ssh-add ~/.ssh/id_rsa
//应该是利用代理后台运作，当运行ssh时，会自动搜寻该钥匙并给服务端验证

//当然别忘了
 clip < ~/.ssh/id_rsa.pub
 //复制钥匙到剪切板，后粘贴到github指定地方
```

### 部署hexo项目到github.io,需要注意以下
1. _config.yml
```
deploy:
  type: git
  repo: git@github.com:lumingliang/lumingliang.github.io.git
  branch: master
  //注意空格
```
2. 每个账户只有一个github.io网站，该项目下的文件夹作为链接分页，每个文件夹下都有一个index.html,以达到url跳转

#### 常见问题解决

##### 冲突
实际上，本地与远程是分离的，但是本地能push到远程，前提是本地的所有东西必须先进于远程。

有两种情况，远程有些文件新于本地，本地也有先于远程的东西，那么应该做的是：
先git pull ['这里是该origin,一个本地可以拥有多个origin,但是没必要'], [master, 远程的分支] [master, /本地的分支];

pull后提示有没有冲突，说明远程的所有文件已经在本地存在了，那么再commit一遍，于是本地的状态是有远程的所有东西。 就可以push了

还有一种情况，本地保留的版本是前天的，但是昨天有人修改了并push该文件到远程，今天我修改了并尝试push，这时就会push不上，解决方法是，pull一下，然后回提示哪些文件需要解决冲突。接着进入该文件，就会标识有冲突的地方，这样只要再改一下并add, commit即可push 

##### git 比较提交前后的异同
进入目录 git diff 后可以看出哪个文件改了

git status 可以看出哪个文件改了没有提交
git checkout -- file 可以撤销这次对某个文件的更改


##### git 进阶

1. 建立分支 git branch ( 查看所有分支，* 是目前指向的分支 ), git branch branchName 创建一个新的分支 
2. git checkout branchName 切换到某一个分支，
3. git checkout commitName  版本回退到某一个commit
4. git checkout -b branchName 创建并切换到该新分支
5. git reset (HAED|commitName|branchName) fileName 将某个文件撤出stag缓存区, 进入缓存区的文件，即使后来删了工作区的对应文件，还是会随着commit 提交到版本库中
6. 一般删除一个文件，需要先git rm (-f) fileName 撤销跟踪，再删除rm 
    git rm --cached fileName 仅从git仓库中删除
7. git log --pretty=format:"%h %s" --graph 查看分支情况
git lg

8. git merg 分支合并
9. git reset haed // 将暂存区中的内容回退到上一个版本，工作区内容没有变化,对应git add , git reset commitName 后haed 会指向该commmit
10. git reset --hard commitName 可以直接将本地的工作区和commit回退到该commmit, 并丢弃前面的commit

git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative

git自动部署主要关键在于要为www-data用户创建ssh密匙对，并传到远程仓库，然后还要先在本地运行一遍git pull以防第一次登陆要yes，(可能也和要设定账号有关)
```
sudo -Hu www git clone https://git.
sudo -Hu www ssh-keygen -t rsa # 请选择 “no passphrase”，一直回车下去

```
https://m.aoh.cc/149.html

##### git 分支
1. 先要搞清楚你要将哪些内容应用到哪些地方，即将先进的dev分支的内容合并到落后的master上，那么你需要切换到master，然后合并dev


