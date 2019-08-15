##### docker 新一代虚拟化技术的使用
1. docker ce 的安装
```
sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine

sudo yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2

sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce
yum list docker-ce --showduplicates | sort -r

sudo yum install docker-ce-<VERSION STRING>
 sudo systemctl start docker
 sudo docker run hello-world
docker --version

```

docker 分为镜像，镜像运行在容器里面，容器各自独立，service管理多个容器，一个镜像复制到多个容器中使用，一个镜像有一个功能，就是一个service，然后多个service 组成一个大应用，多个容器运行在不同主机中得到一个swarm，一个stack管理整个swarm
2. 安装docker compose,用于创建集群，组装多个容器、服务间的合体 docker-compose.yml
```
curl -L https://github.com/docker/compose/releases/download/1.21.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
```

3. 创建镜像，利用dockerfile
```
// 当前目录build一个镜像
docker build -t friendlyhello .
docker image ls /查看创建的镜像
docker run -d -p 4000:80 friendlyhello

docker login
docker tag friendlyhello john/get-started:part2 //先打一个标签
docker push username/repository:tag 开始推送到云
docker run -p 4000:80 username/repository:tag 

```
```
docker swarm init
docker stack deploy -c docker-compose.yml getstartedlab
docker service ls
docker stack rm getstartedlab
docker swarm leave --force



```



