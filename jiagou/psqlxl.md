##### 分布式postgres


###### 安装
https://blog.csdn.net/pg_hgdb/article/details/78911440
```

git clone git://git.postgresql.org/git/postgres-xl.git
cd postgres-xl
./configure
make -j4
sudo make install
cd contrib
make -j4
sudo make install

// 依赖
yum install wget readline readline-staticreadline-devel openjade zlib zlib-devel docbook-style-dsssl bzip2 gcc* zlib-static openssl openssl-devel pam-devel libxml2-devel libxslt-devel python-develtcl-devel flex bison perl-ExtUtils-Embed openldap-devel cmake -y

mkdir /home/postgres/pgxl/ -p
chown postgres:postgres /home/postgres/pgxl/ -R

关闭SELINUX，起到关键作用，不然postgres用户无法互相ssh登录

[root@pgxl1 ~]# sed -i"s/SELINUX=enforcing/SELINUX=disabled/g" /etc/selinux/config

[root@pgxl1 ~]# setenforce 0

[root@pgxl1 ~]# cat /etc/selinux/config

设置主机名

/etc/sysconfig/network
hostname h1

NETWORKING=yes
HOSTNAME=yourname //在这修改hostname
NISDOMAIN=eng-cn.platform.com

检测UID是否被占用

cat /etc/passwd | grep 600

创建用户

groupadd -g 600 postgres; useradd -u 600 -g postgres postgres; echo postgres | passwd -f --stdin postgres
su - postgres

原来就有postgres目录情况
chown -R postgres:postgres /home/postgres

mkdir ~/.ssh

chmod 700 ~/.ssh


然后使gtm节点能登录其他节点
ssh-keygen -t rsa

cat ~/.ssh/id_rsa.pub >>~/.ssh/authorized_keys

chmod 600 ~/.ssh/authorized_keys

##### 用户目录的权限、以及.ssh下目录的权限影响ssh登录


2、传送配置文件
[postgres@pgxl1 pgxc_ctl]$ scp pgxc_ctl.conf h2:~/pgxc_ctl/

3、初始化
mkdir /home/postgres/pgxl/gtm -p           （仅在gtm所在节点创建即可）

mkdir /home/postgres/pgxl/nodes/coord -p

mkdir /home/postgres/pgxl/nodes/dn_master -p

chown postgres:postgres /home/postgres/pgxl -R

远程执行命令
ssh h2 'initdb'
需要在$HOME/.bashrc中配置好



初始化
pgxc_ctl -c pgxc_ctl.conf init all
pgxc_ctl -c /home/postgres/pgxc_ctl/pgxc_ctl.conf init all

启动
pgxc_ctl -c /home/postgres/pgxc_ctl/pgxc_ctl.conf start all
关闭
pgxc_ctl -c /home/postgres/pgxc_ctl/pgxc_ctl.conf stop all

### 遇到问题
1. 防火墙、selinux、目录所有权、.bashrc配置以便ssh执行命令、nodes下面的目录要干净以便初始化正确运行pgxc_ctl init



```
#!/bin/bash

#!/usr/bin/env bash



#user and path

pgxcInstallDir=$HOME/pgxl

pgxcOwner=postgres

pgxcUser=$pgxcOwner



tmpDir=/tmp                                     # temporary dir used in XC servers

localTmpDir=$tmpDir



#gtm

gtmName=gtm

gtmMasterServer=pgxl1

gtmMasterPort=6866

gtmMasterDir=$HOME/pgxl/gtm



#---- Configuration ---

gtmExtraConfig=none                     # Will be added gtm.conffor both Master and Slave (done at initilization only)

gtmMasterSpecificExtraConfig=none       # Will be added to Master's gtm.conf(done at initialization only)


coordMasterServers=(h1 h2 h3)

coordMasterDirs=($coordMasterDir $coordMasterDir $coordMasterDir)

coordMaxWALsernder=0

coordMaxWALSenders=($coordMaxWALsernder $coordMaxWALsernder $coordMaxWALsernder)

coordSlave=n

coordSpecificExtraConfig=(none none none)

coordSpecificExtraPgHba=(none none none)


#datanode

datanodeNames=(datanode1 datanode2 datanode3)

datanodePorts=(20008 20008 20008)

datanodePoolerPorts=(20012 20012 20012)

datanodePgHbaEntries=(0.0.0.0/0)

#datanodeMasterServers=(pgxl1 pgxl2 pgxl3)
datanodeMasterServers=(h1 h2 h3)

datanodeMasterDir=$HOME/pgxl/nodes/dn_master

datanodeMasterDirs=($datanodeMasterDir $datanodeMasterDir $datanodeMasterDir)

datanodeMaxWalSender=0

datanodeMaxWALSenders=($datanodeMaxWalSender $datanodeMaxWalSender $datanodeMaxWalSender)

datanodeSlave=n


primaryDatanode=datanode1
```

```
rm -rf ~/pgxl/gtm/*
rm -rf ~/pgxl/nodes/coord/*
rm -rf ~/pgxl/nodes//dn_master/*
ssh h2 'rm -rf ~/pgxl/nodes//dn_master/*'
ssh h3 'rm -rf ~/pgxl/nodes//dn_master/*'
ssh h2 'rm -rf ~/pgxl/nodes/coord/*'
ssh h3 'rm -rf ~/pgxl/nodes/coord/*'

 scp .ssh/config h2:~/.ssh/
 scp .ssh/config h3:~/.ssh/

 mkdir back
  mv /home/postgres/* back
   userdel postgres
   rm -rf /home/postgres
    groupadd -g 600 postgres; useradd -u 600 -g postgres postgres; echo postgres | passwd -f --stdin postgres
    mv back/* /home/postgres/
    chmod -R 777 /home/postgres/pgxl/
    rm -rf /home/postgres/.ssh
    mkdir /home/postgres/.ssh
    chmod -R 600 .ssh

```

 less /var/log/secure 查看登录日志
