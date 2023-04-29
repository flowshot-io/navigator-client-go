# Navigator gRPC API for Go

Generated Go files from Navigator [api](https://github.com/flowshot-io/navigator-api) repository.

## Usage

To install the package in your project, run the following command:

```bash
go get -u github.com/flowshot-io/navigator-client-go
```

## Rebuild

Run `make` once to install all plugins and tools (`protoc` and `go` must be installed manually).

Run `make update-proto` to update submodule and recompile proto files.