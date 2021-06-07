protoc-gen-go
=============

默认没有golang的插件，`protoc-gen-go <https://github.com/golang/protobuf/tree/master/protoc-gen-go>`_ 是protobuf 编译插件 系列中的 Go 版本。但1.4版后的维护放在`这儿 <https://pkg.go.dev/google.golang.org/protobuf>`_ 对应的github地址是`这儿<https://github.com/protocolbuffers/protobuf-go>`_



安装::

    // 1.4版本之前
    go install github.com/golang/protobuf/protoc-gen-go

    // 1.4版本之后
    go install google.golang.org/protobuf/cmd/protoc-gen-go


使用::

    protoc --go_out=output_directory input_directory/file.proto


* protoc-gen-go1.4之前以及issue驻地: https://github.com/golang/protobuf
* protoc-gen-go1.4之后驻地: https://pkg.go.dev/google.golang.org/protobuf
* protoc-gen-go1.4之后驻地github镜像: https://github.com/protocolbuffers/protobuf-go






