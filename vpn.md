title: vpn的设定也基本用法
1. vi  /etc/ppp/chap-secrets
[一键安装包](https://teddysun.com/448.html)

2. 重启

service pptpd restart
service pppd-dns restart


#### openvpn 的学习与配置

##### 预备知识
1. This HOWTO assumes that readers possess a prior understanding of basic networking concepts such as IP addresses, DNS names, netmasks, subnets, IP routing, routers, network interfaces, LANs, gateways, and firewall rules.

2. 与，全真才是真，

3, ipv4 地址分为32位，每一位都是0或者1.，ip = 网络号位+ 主机位.
子掩码是为了区分ip的网络号和主机号，
A 类ip : 8为网络号，(256种网络号，每个网络号下有2的24次方个主机号，也就 是A类网络可以容纳很多主机) ,

B 类 ，C 类， D类，

通过子网掩码可以划分子网，如A类ip，子网掩码是前8个1，后24个0 ，可以把子网掩码写成前9个1，后23个0 ，这样由任一网络号划分下来，都得到了两个新的网络号，利用子网掩码就可以区分。
[参考](http://zhidao.baidu.com/question/474301179.html)

也可以用aws的新模式来安装vpn，切记要在ubuntu安装

shadowsock 安装方式：用python 安装

安装后配置server-ip:'0.0.0.0'

vpn 的工作原理是，利用vpn服务器作为跳板，连接该vpn服务器能得到的网络服务，实际上就相当于利用该vpn服务器上网

ipsec internet protocol secure 网络协议安全，用来加密传输的，一般用于vpn中
