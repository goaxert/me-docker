FROM golang:1.15.0-buster

ENV PROTOBUF_VERSION 3.13.0

RUN apt-get update && apt-get install -y --no-install-recommends \
	wget \
	unzip \
  	&& rm -rf /var/lib/apt/lists/*

# Install proto compiler
RUN mkdir -p /usr/share/protobuf && \
	cd /usr/share/protobuf && \
	wget --no-check-certificate --quiet "https://github.com/google/protobuf/releases/download/v${PROTOBUF_VERSION}/protoc-${PROTOBUF_VERSION}-linux-x86_64.zip" && \
	unzip protoc-${PROTOBUF_VERSION}-linux-x86_64.zip && \
	rm protoc-${PROTOBUF_VERSION}-linux-x86_64.zip

# Install packages
RUN go get \
	google.golang.org/grpc \
	github.com/golang/protobuf/protoc-gen-go \
	github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway \
	github.com/grpc-ecosystem/grpc-gateway/protoc-gen-swagger \
	github.com/cespare/reflex \
	github.com/golang/mock/gomock \
	github.com/golang/mock/mockgen \
	github.com/onsi/ginkgo/ginkgo

ENV PATH="/usr/share/protobuf/bin:/go/bin:${PATH}"
