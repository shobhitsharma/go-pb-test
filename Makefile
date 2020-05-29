# Helper variables and Make settings
.PHONY: help clean build proto-link proto-vendor run
.DEFAULT_GOAL := help
.ONESHELL :
.SHELLFLAGS := -ec
LDFLAGS := -ldflags "-w -X github.com/shobhitsharma/go-pb-test/config.Version=${VERSION} -X github.com/shobhitsharma/go-pb-test/config.Build=${HASH}"
SHELL := /bin/bash

help:                                  ## Print list of tasks
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_%-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' Makefile

build: clean build-server build-client ## Build go project

build-server:                	   	   ## Build go server project
	cd server && CGO_ENABLED=0 GOARCH=amd64 go build -a -tags netgo ${LDFLAGS} -o build/main

build-client:                	  	   ## Build go client project
	cd client && CGO_ENABLED=0 GOARCH=amd64 go build -a -tags netgo ${LDFLAGS} -o build/main

clean:
	rm -rf server/build
	rm -rf client/build

protoc:                            	   ## Generate go protobuf files using symlinked modules
	@protoc --proto_path=proto --go_out=plugins=grpc:proto --go_opt=paths=source_relative proto/service.proto

run:                                   ## Runs the demo server
	./build/main
