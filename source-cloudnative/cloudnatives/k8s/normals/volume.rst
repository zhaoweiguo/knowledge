卷-磁盘挂载
################

卷类型::

    emptyDir
    gitRepo
    hostPath
    nfs
    configMap, secret, downwardAPI
    persistentVolumeClaim
    gccPersistentDisk(Google磁盘)

emptyDir实例::

    volumes:
    - name: emptyDir-name0
      emptyDir: {}

    volumes:
    - name: emptyDir-name1
      emptyDir:
        medium: Memory   # 指定数据存储在内存


gitRepo实例::

    # 1. git更新后不能同步更新需要删除pod重建
    # 2. 没有权限控制功能
    # 可以使用sidebar container,如: Git sync sidecar容器,git-sync
    volumes:
    - name: gitRepo-name
      gitRepo:
        repository: "https://github.com/tenxcloud/golang-sample.git"
        revision: "master"
        directory: .

hostPath实例::

    # 访问工作节点文件系统上的文件
    volumes:
      - name: hostPath-name
        hostPath:
          path: /tmp/mysql  # 节点路径

nfs实例::

    volumes:
      - name: nfs-name1
        nfs:
          server: 1.2.3.4
          path: /some/path


gccPersistentDisk实例::


    volumes:
      - name: gccPersistentDisk-name1
        gccPersistentDisk实例:
          pdName: pdName1
          fsType: ext4
















