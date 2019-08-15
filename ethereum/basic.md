##### 比特币的挖矿
为了解决共识问题，1、激励旷工记账，才能达到账本的正确性2、旷工间互相竞争，保证记账的准确性。3、每10分钟产生一个区块，每个区块10M左右，实际上就是旷工收集10分钟内的交易，合并成一个区块，记录下来。
需要旷工来保证分布式和记账准确性


##### 以太坊基础

1. 以太坊客户端用于同步、保存区块数据，因为是分布式，所以又成客户端，实际上是服务端，可以部署智能合约等，交易记录等以区块形式保存在文件中

```
1、什么是Ethereum(以太坊)
　　以太坊（Ethereum）并不是一个机构，而是一款能够在区块链上实现智能合约、开源的底层系统，以太坊从诞生到2017年5月，短短3年半时间，全球已有200多个以太坊应用诞生。以太坊是一个平台和一种编程语言，使开发人员能够建立和发布下一代分布式应用。 以太坊可以用来编程，分散，担保和交易任何事物：投票，域名，金融交易所，众筹，公司管理， 合同和大部分的协议，知识产权，还有得益于硬件集成的智能资产。

　　以太坊的白皮书：https://github.com/ethereum/wiki/wiki/White-Paper

1.2、以太坊的几个基本概念：
　　以太坊简单来说就是区块链与智能合约的结合，是基于solidity语言实现的。在以太坊中，智能合约也有一个帐户地址。

EVM
　　以太坊虚拟机（EVM）是以太坊中智能合约的运行环境。它不仅被沙箱封装起来，事实上它被完全隔离，运行在EVM内部的代码不能接触到网络、文件系统或者其它进程。甚至智能合约之间也只有有限的调用。

Accounts
　　以太坊中有两类账户，它们共用同一个地址空间。外部账户，该类账户被公钥-私钥对控制。合约账户，该类账户被存储在账户中的代码控制。 外部账户的地址是由公钥决定的，合约账户的地址是在创建合约时确定的。

　　每个账户都有一个以太币余额（单位是“Wei”），该账户余额可以通过向它发送带有以太币的交易来改变。

Transactions
　　每一笔交易都是一条信息，可以通过交易，将余额从一个帐户发至另一个帐户。

Gas
　　每一笔交易需要支付一定的gas。gas price是由创建者设置的，调用合约的发送账户需要交易费用 = gas price * gas amount。

1.3、以太坊周边的常用工具
Go-Ethereum
Browser-solidity
Mist
TestRPC
2、什么是 Go-Ethereum？
　　Go-Ethereum是由以太坊基金会提供的官方客户端软件。它是用Go编程语言编写的，简称Geth。其中以下几个组件是值得了解的：

Geth 客户端
　　当你开始这个客户程序，它连接到其他客户端（也称为节点）的网络下载同步区块。它将不断地与其他节点进行通信来保持它的副本是最新的。它还具有挖掘区块并将交易添加到块链的能力，验证并执行区块中的交易。它还可以充当服务器，您可以通过RPC来访问暴露的API接口。



Geth 终端
　　这是一个命令行工具，可以让您连接到正在运行的节点，并执行各种操作，如创建和管理帐户，查询区块链，签署并将交易提交给区块链等等。更多介绍 点击这里

3、Go-Ethereum的开源地址在哪里？
　　https://github.com/ethereum/go-ethereum

4、如何安装Go-Ethereum 1.7.2
　　本文中使用的方法是通过Git下载源码，本地编译Go-Ethereum 1.7.2

git clone https://github.com/ethereum/go-ethereum.git
cd  go-ethereum
git checkout v1.7.2
make geth
make all
　　查看安装好的geth版本号

➜ /Users/lion >geth version
Geth
Version: 1.7.2-stable
Git Commit: 1db4ecdc0b9e828ff65777fb466fc7c1d04e0de9
Architecture: amd64
Protocol Versions: [63 62]
Network Id: 1
Go Version: go1.9.1
Operating System: darwin
GOPATH=/Users/lion/my_project/_golang
GOROOT=/usr/local/Cellar/go/1.9.1/libexec
5、开始创建以太坊私有链
5.1、初始化一个创世区块
　　初始化创世区块时，要先创建一个genesis.json文件，内容如下：

　　genesis.json：

{
  "config": {
        "chainId": 10,
        "homesteadBlock": 0,
        "eip155Block": 0,
        "eip158Block": 0
    },
  "coinbase"   : "0x0000000000000000000000000000000000000000",
  "difficulty" : "0x20000",
  "extraData"  : "",
  "gasLimit"   : "0x2fefd8",
  "nonce"      : "0x0000000000000042",
  "mixhash"    : "0x0000000000000000000000000000000000000000000000000000000000000000",
  "parentHash" : "0x0000000000000000000000000000000000000000000000000000000000000000",
  "timestamp"  : "0x00",
  "alloc"      : {},
}
参数名称	参数描述
mixhash	与nonce配合用于挖矿，由上一个区块的一部分生成的hash。注意他和nonce的设置需要满足以太坊的Yellow paper, 4.3.4. Block Header Validity, (44)章节所描述的条件。
nonce	nonce就是一个64位随机数，用于挖矿，注意他和mixhash的设置需要满足以太坊的Yellow paper, 4.3.4. Block Header Validity, (44)章节所描述的条件。
difficulty	设置当前区块的难度，如果难度过大，cpu挖矿就很难，这里设置较小难度
alloc	用来预置账号以及账号的以太币数量，因为私有链挖矿比较容易，所以我们不需要预置有币的账号，需要的时候自己创建即可以。
coinbase	矿工的账号，随便填
timestamp	设置创世块的时间戳
parentHash	上一个区块的hash值，因为是创世块，所以这个值是0
extraData	附加信息，随便填，可以填你的个性信息
gasLimit	该值设置对GAS的消耗总量限制，用来限制区块能包含的交易信息总和，因为我们是私有链，所以填最大。
　　

　　接下来，我们使用geth init ./genesis.json --datadir "./chain"命令，来进行创世区块的初始化，当前区块链网络数据存放的位置会保存在chain目录中：

➜ /Users/lion/my_project/_eth/test >geth init ./genesis.json --datadir "./chain"
WARN [10-22|14:49:09] No etherbase set and no accounts found as default
INFO [10-22|14:49:09] Allocated cache and file handles         database=/Users/lion/my_project/_eth/test/chain/geth/chaindata cache=16 handles=16
INFO [10-22|14:49:09] Writing custom genesis block
INFO [10-22|14:49:09] Successfully wrote genesis state         database=chaindata                                             hash=5e1fc7…d790e0
INFO [10-22|14:49:09] Allocated cache and file handles         database=/Users/lion/my_project/_eth/test/chain/geth/lightchaindata cache=16 handles=16
INFO [10-22|14:49:09] Writing custom genesis block
INFO [10-22|14:49:09] Successfully wrote genesis state         database=lightchaindata                                             hash=5e1fc7…d790e0
　　

5.2、启用私有链
　　使用以下命令，启用私有链：

geth \
  --datadir "./chain" \
  --nodiscover \
  console 2>>eth_output.log
　　
　　启动后的效果如下：

➜ /Users/lion/my_project/_eth/test >geth \
  --datadir "./chain" \
  --nodiscover \
  console 2>>eth_output.log
Welcome to the Geth JavaScript console!

instance: Geth/v1.6.7-stable-ab5646c5/darwin-amd64/go1.9.1
 modules: admin:1.0 debug:1.0 eth:1.0 miner:1.0 net:1.0 personal:1.0 rpc:1.0 txpool:1.0 web3:1.0

>
参数名称	参数描述
datadir	设置当前区块链网络数据存放的位置
console	启动命令行模式，可以在Geth中执行命令
nodiscover	私有链地址，不会被网上看到
　　

　　在当前目录执行tail -f eth_output.log，可以看到输出日志。

➜ /Users/lion/my_project/_eth/test >tail -f eth_output.log
INFO [10-22|14:50:04] Bloom-bin upgrade completed              elapsed=149.285µs
INFO [10-22|14:50:04] Initialising Ethereum protocol           versions="[63 62]" network=1
INFO [10-22|14:50:04] Database conversion successful
INFO [10-22|14:50:04] Loaded most recent local header          number=0 hash=5e1fc7…d790e0 td=131072
INFO [10-22|14:50:04] Loaded most recent local full block      number=0 hash=5e1fc7…d790e0 td=131072
INFO [10-22|14:50:04] Loaded most recent local fast block      number=0 hash=5e1fc7…d790e0 td=131072
INFO [10-22|14:50:04] Starting P2P networking
INFO [10-22|14:50:04] RLPx listener up                         self="enode://bcc414219b7423f56da261857508771c229a5ee370e2d5bee7a9d1a3886ae9c207956a80e03f7ba44ed5f9f7777ac64db9b6939d18f3f44786dc6fc5690035b1@[::]:30303?discport=0"
INFO [10-22|14:50:04] IPC endpoint opened: /Users/lion/my_project/_eth/test/chain/geth.ipc
INFO [10-22|14:50:05] Mapped network port                      proto=tcp extport=30303 intport=30303 interface=NAT-PMP(10.0.0.1)
后面章节中的命令，都是在启动私有链后的Geth javascript console中操作

　　

5.2.1、帐户的添加和查看
　　查看帐户，可以看到当前帐户是空的

> web3.eth.accounts
[]
　　
　　创建帐户的方式有两种，第一种创建帐户时直接初始化密码

> web3.personal.newAccount("123456")
"0xbe323cc4fde114269a9513a27d3e985f82b9e25d"
其中返回的0xbe323cc4fde114269a9513a27d3e985f82b9e25d是帐户，123456是帐户的密码

　　
　　第二种方法是先创建账户，然后输入密码

> web3.personal.newAccount()
Passphrase:
Repeat passphrase:
"0x3b0ec02b4193d14abdc9cc5b264b5e3f39624d70"
　　
　　这时我们再查看帐户，能够看到刚才创建的两个帐户已经存在了

> web3.eth.accounts
["0xbe323cc4fde114269a9513a27d3e985f82b9e25d", "0x3b0ec02b4193d14abdc9cc5b264b5e3f39624d70"]
　　

5.2.2、开始挖矿和停止挖矿
　　挖矿执行以下命令：

> miner.start(1)
　　
　　执行以后，通过刚才查看日志的方法tail -f eth_output.log,能够看到类似下面的日志，说明挖矿已经在进行.

INFO [10-22|15:01:32] Commit new mining work                   number=70 txs=0 uncles=0 elapsed=2.000s
INFO [10-22|15:01:34] Successfully sealed new block            number=70 hash=a0cfd2…f99c06
INFO [10-22|15:01:34] 🔗 block reached canonical chain          number=65 hash=3f6d16…586aba
INFO [10-22|15:01:34] 🔨 mined potential block                  number=70 hash=a0cfd2…f99c06
INFO [10-22|15:01:34] Commit new mining work                   number=71 txs=0 uncles=0 elapsed=163.977µs
INFO [10-22|15:01:34] Successfully sealed new block            number=71 hash=f84b8a…7468e1
INFO [10-22|15:01:34] 🔗 block reached canonical chain          number=66 hash=6ca3b9…e959e8
INFO [10-22|15:01:34] 🔨 mined potential block                  number=71 hash=f84b8a…7468e1
挖矿会默认保存到创建的第一个帐户0xbe323cc4fde114269a9513a27d3e985f82b9e25d中。
block number=66，说明我们已经创建了66个区块
在以太坊官方的网络上，平均每15秒产生一个区块

　　停止挖矿执行以下命令：

> miner.stop()
停止挖矿后，以太币则不会产生，同样智能合约、转帐等操作也不会起作用。

　　

5.2.3、查看帐户余额
　　查看帐户余额的方法如下：

> web3.eth.getBalance("0xbe323cc4fde114269a9513a27d3e985f82b9e25d")
1.245e+21
> web3.eth.getBalance("0x3b0ec02b4193d14abdc9cc5b264b5e3f39624d70")
0
　　
　　每次记一长串的地址很麻烦，我们可以通过设置变量来acc0表示帐户10xbe323cc4fde114269a9513a27d3e985f82b9e25d,acc1表示帐户20x3b0ec02b4193d14abdc9cc5b264b5e3f39624d70.

> acc0 = web3.eth.accounts[0]
"0xbe323cc4fde114269a9513a27d3e985f82b9e25d"
> acc1 = web3.eth.accounts[1]
"0x3b0ec02b4193d14abdc9cc5b264b5e3f39624d70"
> web3.eth.getBalance(acc0)
1.245e+21
> web3.eth.getBalance(acc1)
0

## 使用这个方法可以查看格式化的以太币
> web3.fromWei(web3.eth.getBalance(acc0))
1245
以太币最小的单位是wei（18个0）

　　
　　因为geth javascript console是基于javascript的，所以也可以创建js函数，查看所有帐户余额

> function checkAllBalances() {
     var totalBal = 0;
     for (var acctNum in eth.accounts) {
         var acct = eth.accounts[acctNum];
         var acctBal = web3.fromWei(eth.getBalance(acct), "ether");
         totalBal += parseFloat(acctBal);
         console.log("  eth.accounts[" + acctNum + "]: \t" + acct + " \tbalance: " + acctBal + " ether");
     }
     console.log("  Total balance: " + totalBal + " ether");
 };
> checkAllBalances()
  eth.accounts[0]:  0xbe323cc4fde114269a9513a27d3e985f82b9e25d  balance: 1245 ether
  eth.accounts[1]:  0x3b0ec02b4193d14abdc9cc5b264b5e3f39624d70  balance: 0 ether
  Total balance: 1245 ether
如果命令较多，可以保存到一个脚本里，使用命令载入脚本：loadScript('/path/script/here.js')

　　

5.2.4、转帐操作
　　从帐户0xbe323cc4fde114269a9513a27d3e985f82b9e25d转3个以太币到0x3b0ec02b4193d14abdc9cc5b264b5e3f39624d70,如果不指定单位ether，默认转的是wei。

> web3.eth.sendTransaction({from:acc0,to:acc1,value:web3.toWei(3,"ether")})
Error: authentication needed: password or unlock
    at web3.js:3104:20
    at web3.js:6191:15
    at web3.js:5004:36
    at <anonymous>:1:1
当直接执行此方法时会抛出异常，显示帐号被锁

　　
　　解锁转帐帐户

> web3.personal.unlockAccount(acc0,"123456")
true
　　
　　解锁完成之后，即可执行转账操作。

> web3.eth.sendTransaction({from:acc0,to:acc1,value:web3.toWei(3,"ether")})
"0x472f26a00d244b91fea9ff05d9cd5ff5259d8618301bb14af4499827eb159056"
　　
　　但此时查看时会发现接收账户依旧为原来数值。此时需要执行挖矿命令，才会把转账真正完成。

> checkAllBalances()
  eth.accounts[0]:  0xbe323cc4fde114269a9513a27d3e985f82b9e25d  balance: 1245 ether
  eth.accounts[1]:  0x3b0ec02b4193d14abdc9cc5b264b5e3f39624d70  balance: 0 ether
  Total balance: 1245 ether
undefined
> miner.start()
null
> checkAllBalances()
  eth.accounts[0]:  0xbe323cc4fde114269a9513a27d3e985f82b9e25d  balance: 1257 ether
  eth.accounts[1]:  0x3b0ec02b4193d14abdc9cc5b264b5e3f39624d70  balance: 3 ether
  Total balance: 1260 ether
undefined
> miner.stop()
true
```
