###### rpc是有利于架构分布式的微服务级别应用的方式
1. 用rpc比http更加高效，快捷、安全
2. rpc间必然存在数据传输，用protocol buffer 比用json更加安全、高效。
3. 所以组合为GRPC + pb
4. pb 是一种结构和数据格式，需要定义好结构，不管是读写都要用到该结构
5. 可以在多语言之间交互
6. session 共享，通过redis保存
7. socket 分布式互通，要合理的选择那台机器，即根据ssession id 与serverid的关系来
