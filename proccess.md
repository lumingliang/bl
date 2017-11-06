title: 学习unix 类系统的进程
---
### 基本概念
1. 程序在进程中运行，每运行一个程序，一段脚本，都产生一个新的进程，进程在物理上可以看做是内存的一段空间
2. 每一个用户都有一个大的内存空间，对于这个用户的程序就在这段空间运行
3. 如果不借助于系统调用，用户仍然可以调用到cpu，可以计算，字符串操作
4. 但如果想要实现更复杂的，如声音，磁盘，读写文件，那么就必须通过系统调用，因为系统通过调用c语言内核，管理者这些资源
5. 用户程序间接的通过调用c内核来实现磁盘，读写等操作，这些操作都是非常神奇的，因为它就像人的大脑有了双手，有了眼睛一样
### 参考手册
1. man man 是系统的参考手册
2. 该手册一共可以分为4节
	2.1. 一般命令
	2.2. 系统调用
	2.3. c库函数
	2.4. 特殊文件
3. 如$ man 2 getpid 就是查找有关第二节的getpid的内容

### 进程都有一个pid，在ruby中可以通过puts $$ 或 puts process.pid 得到ruby的进程号

### 进程都有一个父进程,如启动一个终端，那么所有在终端里面运行的进程都是它的子进程，而且一个脚本也可以作为父进程启动多个子进程
```
puts Process.ppid

```
### 每个进程下的调用都称作文件，每个进程开启的东西都用一个文件描述符(file descriptor number)来表示它, 对于普通的文件，这里称作文件，对于(设备，管道，套接字)这些文件的时候，称作资源
```
passwd = File.open('/etc/passwd') # 获取一个资源，同时得到一个 file descriptor number
puts passwd.fileno # 输出这个资源的f d n
passwd.close # 关闭资源，同时 f d n 将失去
puts passwd.fileno # 此时再输出，将会异常
```
#### 每个进程开的时候，都会分配了三个标准资源,他们是STDIN(标准输入),STDOUT,STDERR(标准错误) 
```
puts STDIN.fileno 
	=> 0
puts STDOUT.fileno 
	=> 1
```
#### 文件描述符是使用套接字(TCP/IP 下的socket接口)、管道等进行网络编程的核心，也就是文件操作系统的核心
#### ruby中的IO 类不少方法对应着同名的系统调用，如 open(2) close(2) 等


### 进程皆有环境，即环境变量 
1. 子进程继承所有父进程的环境变量
```
$ export NEWENV='new env'
irb # 启动irb进程
> puts ENV['NEWENV']
	=> new env
# 或者这样
> ENV['new'] = 'new env by ruby'
> system 'echo $new'
 => 'new env by ruby'
```
2. 环境变量就是键值对 key => value (数组) 不是真正的hash
```
puts ENV.has_key?('PATH') => true
ENV.is_a(Hash) =>false
```

### 进程皆有参数
#### ARGV 是一个特殊数组，保存着命令行输入，作为传递到进程的参数, 其他语言可能实现方式不一样，但都有 argv
```
$ cat argv.rb
p ARGV # p 段落输出ARGV 这个参数，是一个数组 
$ ruby argv.rb foo bar -va
['foo', 'bar', '-va']
 
p ARGV
p ARGV[0] #获取命令行第一个参数
ARGV.include?('c') && p ARGV[ARGV.index('c') + 1] # 获取某个参数值的索引
```
### 退出进程,、所有进程在退出时都会产生一个退出码，表示不同信息，其中0表示顺利结束，其他都是错误码
```
at_exit { puts 'last' } # Kenel#at_exit 方法将在退出时候调用
exit	

at_exit { puts 'last' } # Kenel#at_exit 方法将在退出时候调用
abort 'something went long' # Kenel#abort方法，退出并且输出错误

raise 'jel' # 抛出一个异常，将退出码设置为1，任然会执行at_exit方法
```
