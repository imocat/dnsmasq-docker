# dnsmasq 镜像

确保已安装 [docker](https://github.com/docker/docker) 和 [docker-compose](https://github.com/docker/compose/releases) 后

### 执行构建

```bash
docker-compose build 
```

### 环境变量说明
容器启动时，会自动查找 `ADDRESS_数字` 开头的环境变量，并挂载到 /etc/dnsmasq.d/default.conf 文件中。  
使用环境变量方式，快速设置 dnsmasq 配置

```
ADDRESS_1=/1.orange.com/192.168.1.1
ADDRESS_2=/2.orange.com/192.168.1.2
ADDRESS_3=/2.orange.com/192.168.1.3
```

`*注意，数字不能重复*`
