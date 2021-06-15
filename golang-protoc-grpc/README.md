# golang-protoc-grpc

## Versions

* golang: 1.15.0
* protoc: 3.13.0
* grpc
    * google.golang.org/grpc
    * google.golang.org/protobuf/protoc-gen-go
    * github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway
	* github.com/grpc-ecosystem/grpc-gateway/protoc-gen-swagger
* etc
	* github.com/cespare/reflex
	* github.com/golang/mock/gomock
	* github.com/golang/mock/mockgen
	* github.com/onsi/ginkgo/ginkgo

## Build

``` bash
docker build -t goaxert/golang-protoc-grpc:1.0 .
```