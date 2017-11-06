##### 安装hive
1. 注意配置好haddoop home hive home等
2. 注意修改配置
3. 先创建好hive 在hadoop中的文件目录
4. 先运行meta_data生成
schematool -dbType derby -initSchema
nohup hiveserver2 &> hive.log &

http://developer.51cto.com/art/201609/516716.htm

