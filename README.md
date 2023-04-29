# Navigator gRPC API for Go

[![Github tag](https://badgen.net/github/tag/flowshot-io/navigator-client-go)](https://github.com/flowshot-io/navigator-client-go/tags)
[![Go Doc](https://img.shields.io/badge/go-documentation-blue.svg?style=flat-square)](https://pkg.go.dev/github.com/flowshot-io/navigator-client-go)
[![Go Report Card](https://goreportcard.com/badge/github.com/flowshot-io/navigator-client-go)](https://goreportcard.com/report/github.com/flowshot-io/navigator-client-go)
[![GitHub](https://img.shields.io/github/license/flowshot-io/navigator-client-go)](https://github.com/flowshot-io/navigator-client-go/blob/master/LICENSE)

Generated Go files from Navigator [api](https://github.com/flowshot-io/navigator-api) repository.

## Usage

To install the package in your project, run the following command:

```bash
go get -u github.com/flowshot-io/navigator-client-go
```

## Rebuild

Run `make` once to install all plugins and tools (`protoc` and `go` must be installed manually).

Run `make update-proto` to update submodule and recompile proto files.