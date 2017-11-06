title: 学习网络的传递，数据包的路由，等一些列知识
----
##### 预备知识
1. This HOWTO assumes that readers possess a prior understanding of basic networking concepts such as IP addresses, DNS names, netmasks, subnets, IP routing, routers, network interfaces, LANs, gateways, and firewall rules.

2. 与，全真才是真，

3, ipv4 地址分为32位，每一位都是0或者1.，ip = 网络号位+ 主机位.
子掩码是为了区分ip的网络号和主机号，
A 类ip : 8为网络号，(256种网络号，每个网络号下有2的24次方个主机号，也就 是A类网络可以容纳很多主机) ,

B 类 ，C 类， D类，

通过子网掩码可以划分子网，如A类ip，子网掩码是前8个1，后24个0 ，可以把子网掩码写成前9个1，后23个0 ，这样由任一网络号划分下来，都得到了两个新的网络号，利用子网掩码就可以区分。
[参考](http://zhidao.baidu.com/question/474301179.html)

4. route: 目的地址，(可以有多个)
5. routing: 决定数据包到达每一个吓一跳的最好路径和转发接口，由一组三法来实现，这组算法就是路由协议(有静态[人工路由表], 和动态)
6. router : 路由器，可以储存route，并有操作系统来实现路由 协议
7. 路由通告: 指路由器通过通告将自己的网段告诉其他路由设备，是目的地址的发起者或源
8. 路由转发: 路由器根据目的地址将报文发给发起者或源(下一个路由器) 
9. 参考[华为基础教程](http://wenku.baidu.com/link?url=ccHCG38DsT77wtgvVIR5IVfLCAgcXU-RK3Gs4EYy-ifxaO22saHT9VL5AwotmQp4Drf67n9427X5Pm7pJHuZVmxlIzjFwYdbyu6OC9qEp4u) 
10.  


##### https 协议理解
http协议其实就是一个信息传送的过程，客户端(浏览器)向服务器发送一个请求url，服务器就根据url返回它要的信息

https 协议与它有些不一样，就是在于https多了个加密的过程： 

浏览器发送 https请求到服务器443端口，服务器中保留着数字证书,数字证书其实就是一对公私钥匙，这时服务器向浏览器发一个公钥匙，这个公钥匙可以想象为一个锁头，浏览器可以用它锁住一个随机值，但是这个随机值只有服务器的唯一私钥匙才能解开，服务器拿到加密后的随机值皆可以对其解密，接着用这个解密后的随机值对称加密返回去的数据，

对称加密是指将数据通过私钥匙混在一起(这里私钥匙就是随机数),只有知道私钥匙才可以解开

[参考](http://www.jb51.net/network/68135.html)
http://www.jb51.net/network/68135.html
