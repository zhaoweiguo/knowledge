安装
####

Server端
========

使用docker快速启动::

    $ docker run -d --name jaeger \
      -e COLLECTOR_ZIPKIN_HTTP_PORT=9411 \
      -p 5775:5775/udp \
      -p 6831:6831/udp \
      -p 6832:6832/udp \
      -p 5778:5778 \
      -p 16686:16686 \
      -p 14268:14268 \
      -p 9411:9411 \
      jaegertracing/all-in-one:1.15

命令行启动::

    $ GOOS=linux
    $ BUILD_INFO_IMPORT_PATH=github.com/jaegertracing/jaeger/pkg/version
    $ BUILD_INFO=-ldflags "-X $(BUILD_INFO_IMPORT_PATH).commitSHA=$(GIT_SHA) -X $(BUILD_INFO_IMPORT_PATH).latestVersion=$(GIT_CLOSEST_TAG) -X $(BUILD_INFO_IMPORT_PATH).date=$(DATE)"
    $ CGO_ENABLED=0 
    $ installsuffix=cgo 
    $ go build -tags ui -o ./cmd/all-in-one/all-in-one-$(GOOS) $(BUILD_INFO) ./cmd/all-in-one/main.go

    $ jaeger-all-in-one --collector.zipkin.http-port=9411

* 浏览器打开Jaeger UI: http://localhost:16686
* http://localhost:16686/dependencies

端口说明::

    Port  | Protocol | Component   |     Function
    5775  | UDP      |  agent      | accept zipkin.thrift over compact thrift protocol 
                     |             |     (deprecated, used by legacy clients only)
    6831  | UDP      |  agent      |   accept jaeger.thrift over compact thrift protocol
    6832  | UDP      |  agent      |   accept jaeger.thrift over binary thrift protocol
    5778  | HTTP     |  agent      |   serve configs
    16686 | HTTP     |  query      |   serve frontend
    14268 | HTTP     |  collector  |   accept jaeger.thrift directly from clients
    14250 | HTTP     |  collector  |   accept model.proto
    9411  | HTTP     |  collector  |   Zipkin compatible endpoint (optional)


Client端(demo)
==============

From Source::

    git clone git@github.com:jaegertracing/jaeger.git jaeger
    cd jaeger
    make install
    go run ./examples/hotrod/main.go all

From docker::

    $ docker run --rm -it \
      --link jaeger \
      -p8080-8083:8080-8083 \
      -e JAEGER_AGENT_HOST="jaeger" \
      jaegertracing/example-hotrod:1.15 \
      all

* 浏览器打开: http://localhost:8080
* http://127.0.0.1:8083/debug/vars









