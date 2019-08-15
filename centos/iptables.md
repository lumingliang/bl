###### iptables 基础知识
linux内核处理数据包时有几个关键钩子，分别PREROUTING, input, forward, output, postruting
 如果数据ip是到本机的就用input / 不然是forward

 iptables 中有4个表raw(跟踪), filter, mangle(修改包),nat(地址改变)，表的作用是提供某些功能

 ```
 允许防火墙转发所有不是icmp 的包，但是这个转发首先条件是ip地址不是自身
 iptables -A FORWARD -p ! icmp -j ACCEPT

 丢弃从外网接口（eth1）进入防火墙本机的源地址为私网地址的数据包
iptables -A INPUT -i eth1 -s 192.168.0.0/16 -j DROP 
iptables -A INPUT -i eth1 -s 172.16.0.0/12 -j DROP 
iptables -A INPUT -i eth1 -s 10.0.0.0/8 -j DROP
 ```
http://www.cnblogs.com/metoy/p/4320813.html

配置防ddos
http://angus717.blog.51cto.com/1593644/1185517/

// 列出所有当前访问的ip地址，先awk 取出一段，在减掉:间隔处再去重排序
netstat -ntu | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -nr

ubuntu 下用ufw  来管理防火墙
腾讯云上默认使用安全组配置
