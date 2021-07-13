# **Golang知识图谱**


## **语言基础**

### **类型**

- 基本类型
  - 布尔类型
  - 数值类型
  - 字符串类型
- 复合类型
  - 数组类型
  - 切片类型
  - Map 类型
  - Channel 类型
- 其他
  - 指针类型
  - 函数类型
  - 结构体类型
  - 接口类型

### **控制语句**

- 条件语句
  - if
  - switch
  - select
- 循环语句
  - for
  - for ... range
  - continue
  - break

### **进阶**

- 函数
  - 其他
    - init
    - defer
    - 可变参数
    - 接口定义&方法实现
  - 内置函数
    - new
    - make
    - append
    - copy
    - len
    - cap
    - delete
    - recover
    - panic
  - 匿名函数

- 结构体&接口
  - 结构体初始化
  - 接口实现
  - 方法继承
  - 方法重写
  - 接口嵌入&组合

- 数组&切片
  - 数组
    - 数组声明
    - 数组初始化
    - 多维数组
  - 切片
    - 切片创建
    - 长度&容量
    - 多维切片
  - 数组与切片
    - 相互转换

- GoRoutine&Channel
  - GoRoutine
    - GOMAXPROCS
    - 启动&终止
    - 进程间通信
  - Channel
    - 声明
    - 类型
      - 缓冲
      - 无缓冲
      - 只写
      - 只读
    - select


## **Go 标准库**

### **fmt**
### **log**



### **strings**
### **bytes**



### **io**
### **bufio**


### **os**


### **errors**




### **flag**


### **testing**


### **net**
- tcp
- udp
### **net/http**




### **container**



### **encoding**

### **sort**


### **strconv**


### **time**

### **text/template**



### **regexp**







## **Golang 周边**

### **Go命令**

- 常用命令
  - go version
  - go get
  - go build
  - go run
  - go doc
  - go mod
  - go test



### **开发环境**

- IDE
  - IDEA
  - Goland
  - VSCode
  - Vim
  - Emacs

- 环境变量
  - GOROOT
  - GOPATH
  - GOPROXY
  - GO111MODULE
  - GOPRIVATE
  - GOSUMDB

## **Go 高级**

### **Go 原理**

- Goroutine调度原来
  - GPM 模型
  - 抢占式调度
- Channel 调度原理
- Go 内存管理
  - 内存模型
  - 垃圾回收机制
  - 连续栈原理
- Go 设计哲学
  - 简单
  - 组合
  - 并发
- 并发设计
  - Go 并发模型
  - sync
  - atomic
- 反射&unsafe
  - 反射
  - unsafe

### **版本简介**



## **开源项目**

### **云原生**

- 容器化
  - 容器
    - docker
    - containerd
  - 容器编排
    - Kubernetes
  - 镜像仓库
    - harbor
  - 服务网络
    - istio
  - k8s 工具
    - k9s
    - lazykube
- 微服务
  - 微服务框架
    - go-zero
    - go-kit
    - go-micro
  - 服务发现
    - etcd
    - consul
- 网关/代理
  - Traefik
  - BFE
  - Vulcand
  - Candy
- DevOps
  - Git 库
    - gitea
    - gogs
    - go-git
  - CI/CD
    - drone
    - argo-cd
    - gitlab-runner
  - 可观测性
    - Prometheus
    - Jaeger
    - OpenTracing
    - OpenTelemetry
  - 监控&报警
    - alertmanager
    - grafana
- 混沌工程
  - chaosblade
  - chaos-mesh
  - chaosmonkey

### **Web**

- web 框架
  - Gin
  - Beego
  - echo
- 建站
  - gohugo
- 爬虫
  - colly
  - ferret
  - pholcus
  - crawlab
- 后台管理
  - gin-vue-admin
  - go-admin
  - gin-admin
  - ferry

### **存储**

- 分布式关系 DB
  - TiDB
  - CockroachDB
- 时序 DB
  - InfluxDB
  - Prometheus
- kv数据库
  - bolt
  - LevelDB-go
- 图数据库
  - Dgraph
  - cayley
  - degdb


### **区块链**

- 公有链
  - Ethereum
  - Filecoin
- 联盟链
  - Fabric
- 其他
  - IPFS
  - libp2p

驱动
sql
  - sqlx
  - gorm
  - xorm
- mongo-go-driver
- redis
  - redigo
  - codis

go-ini
xmlquery
go-yaml
viper
xlsx

- cli
  - conbra
  - cli
  - pterm
  - bit

- cui
  - gocui
- gui
  - walk
  - andlabs/ui
  - fyne

代码生成
mock
wire
gen
httpmock



### **其他**

- 物联网
- 人工智能
  - golearn
