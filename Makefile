.PHONY: all build linux release

all: build

build:
	go build

linux: *.go
	GOOS=linux GOARCH=amd64 go build

release: linux
	docker build -t rjocoleman/simple-proxy .
	docker push rjocoleman/simple-proxy
