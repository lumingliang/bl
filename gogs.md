##### gogs 是一个git远程仓库
1. 主要看配置，安装好后，直接改配置文件，将数据库定位、和仓库位置定位
2. 要定期备份仓库和数据库
3.  su - git -c '/var/www/gogs/gogs admin create-user --name lumin --password lumin --email 156448398@qq.com '

4. 管理逻辑是，每个用户有自己的密匙，创建仓库后，可以指定密匙，同时也可以添加协作者，这样协作者可以用自身的密匙来实现clone等操作
5. 
