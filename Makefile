# This Makefile is meant to be used by people that do not usually work
# with Go source code. If you know what GOPATH is then you probably
# don't need to bother with make.

.PHONY: getfx android ios getfx-cross swarm evm all test clean
.PHONY: getfx-linux getfx-linux-386 getfx-linux-amd64 getfx-linux-mips64 getfx-linux-mips64le
.PHONY: getfx-linux-arm getfx-linux-arm-5 getfx-linux-arm-6 getfx-linux-arm-7 getfx-linux-arm64
.PHONY: getfx-darwin getfx-darwin-386 getfx-darwin-amd64
.PHONY: getfx-windows getfx-windows-386 getfx-windows-amd64

GOBIN = $(shell pwd)/build/bin
GO ?= latest

getfx:
	build/env.sh go run build/ci.go install ./cmd/getfx
	@echo "Done building."
	@echo "Run \"$(GOBIN)/getfx\" to launch getfx."

swarm:
	build/env.sh go run build/ci.go install ./cmd/swarm
	@echo "Done building."
	@echo "Run \"$(GOBIN)/swarm\" to launch swarm."

all:
	build/env.sh go run build/ci.go install

android:
	build/env.sh go run build/ci.go aar --local
	@echo "Done building."
	@echo "Import \"$(GOBIN)/getfx.aar\" to use the library."

ios:
	build/env.sh go run build/ci.go xcode --local
	@echo "Done building."
	@echo "Import \"$(GOBIN)/getfx.framework\" to use the library."

test: all
	build/env.sh go run build/ci.go test

lint: ## Run linters.
	build/env.sh go run build/ci.go lint

clean:
	./build/clean_go_build_cache.sh
	rm -fr build/_workspace/pkg/ $(GOBIN)/*

# The devtools target installs tools required for 'go generate'.
# You need to put $GOBIN (or $GOPATH/bin) in your PATH to use 'go generate'.

devtools:
	env GOBIN= go get -u golang.org/x/tools/cmd/stringer
	env GOBIN= go get -u github.com/kevinburke/go-bindata/go-bindata
	env GOBIN= go get -u github.com/fjl/gencodec
	env GOBIN= go get -u github.com/golang/protobuf/protoc-gen-go
	env GOBIN= go install ./cmd/abigen
	@type "npm" 2> /dev/null || echo 'Please install node.js and npm'
	@type "solc" 2> /dev/null || echo 'Please install solc'
	@type "protoc" 2> /dev/null || echo 'Please install protoc'

swarm-devtools:
	env GOBIN= go install ./cmd/swarm/mimegen

# Cross Compilation Targets (xgo)

getfx-cross: getfx-linux getfx-darwin getfx-windows getfx-android getfx-ios
	@echo "Full cross compilation done:"
	@ls -ld $(GOBIN)/getfx-*

getfx-linux: getfx-linux-386 getfx-linux-amd64 getfx-linux-arm getfx-linux-mips64 getfx-linux-mips64le
	@echo "Linux cross compilation done:"
	@ls -ld $(GOBIN)/getfx-linux-*

getfx-linux-386:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/386 -v ./cmd/getfx
	@echo "Linux 386 cross compilation done:"
	@ls -ld $(GOBIN)/getfx-linux-* | grep 386

getfx-linux-amd64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/amd64 -v ./cmd/getfx
	@echo "Linux amd64 cross compilation done:"
	@ls -ld $(GOBIN)/getfx-linux-* | grep amd64

getfx-linux-arm: getfx-linux-arm-5 getfx-linux-arm-6 getfx-linux-arm-7 getfx-linux-arm64
	@echo "Linux ARM cross compilation done:"
	@ls -ld $(GOBIN)/getfx-linux-* | grep arm

getfx-linux-arm-5:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/arm-5 -v ./cmd/getfx
	@echo "Linux ARMv5 cross compilation done:"
	@ls -ld $(GOBIN)/getfx-linux-* | grep arm-5

getfx-linux-arm-6:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/arm-6 -v ./cmd/getfx
	@echo "Linux ARMv6 cross compilation done:"
	@ls -ld $(GOBIN)/getfx-linux-* | grep arm-6

getfx-linux-arm-7:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/arm-7 -v ./cmd/getfx
	@echo "Linux ARMv7 cross compilation done:"
	@ls -ld $(GOBIN)/getfx-linux-* | grep arm-7

getfx-linux-arm64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/arm64 -v ./cmd/getfx
	@echo "Linux ARM64 cross compilation done:"
	@ls -ld $(GOBIN)/getfx-linux-* | grep arm64

getfx-linux-mips:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mips --ldflags '-extldflags "-static"' -v ./cmd/getfx
	@echo "Linux MIPS cross compilation done:"
	@ls -ld $(GOBIN)/getfx-linux-* | grep mips

getfx-linux-mipsle:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mipsle --ldflags '-extldflags "-static"' -v ./cmd/getfx
	@echo "Linux MIPSle cross compilation done:"
	@ls -ld $(GOBIN)/getfx-linux-* | grep mipsle

getfx-linux-mips64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mips64 --ldflags '-extldflags "-static"' -v ./cmd/getfx
	@echo "Linux MIPS64 cross compilation done:"
	@ls -ld $(GOBIN)/getfx-linux-* | grep mips64

getfx-linux-mips64le:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mips64le --ldflags '-extldflags "-static"' -v ./cmd/getfx
	@echo "Linux MIPS64le cross compilation done:"
	@ls -ld $(GOBIN)/getfx-linux-* | grep mips64le

getfx-darwin: getfx-darwin-386 getfx-darwin-amd64
	@echo "Darwin cross compilation done:"
	@ls -ld $(GOBIN)/getfx-darwin-*

getfx-darwin-386:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=darwin/386 -v ./cmd/getfx
	@echo "Darwin 386 cross compilation done:"
	@ls -ld $(GOBIN)/getfx-darwin-* | grep 386

getfx-darwin-amd64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=darwin/amd64 -v ./cmd/getfx
	@echo "Darwin amd64 cross compilation done:"
	@ls -ld $(GOBIN)/getfx-darwin-* | grep amd64

getfx-windows: getfx-windows-386 getfx-windows-amd64
	@echo "Windows cross compilation done:"
	@ls -ld $(GOBIN)/getfx-windows-*

getfx-windows-386:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=windows/386 -v ./cmd/getfx
	@echo "Windows 386 cross compilation done:"
	@ls -ld $(GOBIN)/getfx-windows-* | grep 386

getfx-windows-amd64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=windows/amd64 -v ./cmd/getfx
	@echo "Windows amd64 cross compilation done:"
	@ls -ld $(GOBIN)/getfx-windows-* | grep amd64
