#### 本文将详细描述网络、互联基本知识的理解

##### 关键词 ip NAT port iptables route gateway eth0 
1. 正常的ip都是唯一的，ipv4 = 8bit.8bit.8bit.8bit 加上掩码可以得到网络号，利用掩码不仅可以得到网络号，还可以得到ip网段范围，简写方法是8bit.0.0.0/8 说明前面8位是有效，后面的是匹配范围
2. 应用程序间的通信即两个进程间的通信，即ip+port = sorcket，对于一个进程不同窗口情况，是有一个区别于port的source port 在单个程序进程内分流
3. ip之间之所以能相互通信，是因为地址唯一，（公网地址），路由就是实现让不同ip间通信的东西，他通过判断路由表中的匹配，决定该封包要发往哪里，在linux中，也有一个自己的route 表，保存了默认网关等，决定了数据封包如何在路由间一跳传到下一跳。直到找到目标地址为止
4. ipv4的地址不够用危机，于是出现了NAT，该技术使处于局域网中的电脑可以上网，nat原理是在封包到达处于公网的nat服务后，将局域网中的ip(等重新封装一层?)替换成这个公网的ip，于是可以上网，当数据发送回来时，再替换成源ip，于是可以了
5. iptables是linux防火墙的过滤规则，决定了封包的input forward output的命运，packer filter机制通过判断封包的各种属性来应用到定义的iptables 中，决定是否accpet 或 reject 封包，属性可以是source ip destination ip interface (interface 是一种代表物理硬件的约定，如lo 代表localhost ppp+ 代表ppptd 拨号，eth0 代表网卡)，[iptables官网](http://www.netfilter.org/documentation/HOWTO/cn/packet-filtering-HOWTO-6.html)
6. gateway 是一种处理下一跳设备的简称，如，在路由器中的主机，该路由器就是这些主机的网关，因为它帮助把封包传下去，（因为路由器路由规则决定好了）
7. GRE 路由协议封装，实现两个不同局域网间的主机通信，[参考](http://h2ofly.blog.51cto.com/6834926/1544860)

8. 虚拟机中nat模式是利用nat方式来实现上网，虚拟机建立了一个nat服务
9. 桥接模式的功能可以实现虚拟机就像真正的主机一样拥有同样网段的ip，主机模式是只有虚拟机间可以互相访问，就像电缆;


##### 网络设备
路由：ip地址、哪个设备
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
192.168.25.0    0.0.0.0         255.255.255.0   U     1      0        0 eth0
0.0.0.0         192.168.25.2    0.0.0.0         UG    0      0        0 eth0
flags U表示使用路由，G表示网关H表示主机

lo
lo 虚拟设备，自身的回环网设备。
eth0是一块物理网卡。eth0.1 eth0.2都是从此设备上虚拟出来的。虚拟出来实际上要经过真正的网卡
eth0.1 是vlan1分出的lan口。
eth0.2 是vlan分出的wan口。

##### 路由联网底层
路由器、电脑联网底层，都是在整个网段中发送一个包，各个网段的设备决定是否接受，即广播
路由的选择非常重要，如先匹配ip，再匹配网关，然后决定从哪个端口、或者网卡发送出去
http://www.cnblogs.com/dongzhiquan/archive/2012/12/26/2834904.html
