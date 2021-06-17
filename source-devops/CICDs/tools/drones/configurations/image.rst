image相关
###############

Pulling Images::

    steps:
    - name: build
      pull: if-not-exists
      image: golang

    // 其他
    pull: always
    pull: never

Pulling Private Images::

    // 定义
    {
        "auths": {
            "docker.io": {
                "auth": "4452D71687B6BC2C9389C3..."
            }
        }
    }

    // 使用
    steps:
    - name: build
      image: registry.internal.company.com/golang:1.12
      commands:
      - go build
      - go test

    image_pull_secrets:
    - dockerconfig





