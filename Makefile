$(VERBOSE).SILENT:
############################# Main targets #############################
# Install everything, update submodule, and compile proto files.
install: grpc-install update-proto

# Compile proto files.
proto: grpc

# Update submodule and compile proto files.
update-proto: update-proto-submodule proto update-dependencies gomodtidy
########################################################################

##### Variables ######
ifndef GOPATH
GOPATH := $(shell go env GOPATH)
endif

GOBIN := $(if $(shell go env GOBIN),$(shell go env GOBIN),$(GOPATH)/bin)
PATH := $(GOBIN):$(PATH)

COLOR := "\e[1;36m%s\e[0m\n"

PINNED_DEPENDENCIES := \

PROTO_ROOT := proto/api
PROTO_FILES = $(shell find $(PROTO_ROOT) -name "*.proto")
PROTO_DIRS = $(sort $(dir $(PROTO_FILES)))
PROTO_OUT := .
PROTO_IMPORTS = -I=$(PROTO_ROOT)

$(PROTO_OUT):
	mkdir $(PROTO_OUT)

##### git submodule for proto files #####
update-proto-submodule:
	printf $(COLOR) "Update proto-submodule..."
	git submodule update --init --force --remote $(PROTO_ROOT)

##### Compile proto files for go #####
grpc: go-grpc fix-path

go-grpc: clean $(PROTO_OUT)
	printf $(COLOR) "Compiling for go-gRPC..."
	$(foreach PROTO_DIR,$(PROTO_DIRS),protoc $(PROTO_IMPORTS) --go_out=plugins=grpc,paths=source_relative:$(PROTO_OUT) $(PROTO_DIR)*.proto;)

fix-path:
	mv -f $(PROTO_OUT)/navigator/api/* $(PROTO_OUT) && rm -rf $(PROTO_OUT)/navigator

##### Plugins & tools #####
grpc-install: go-protobuf-install
	printf $(COLOR) "Install/update gRPC plugins..."
	go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest

go-protobuf-install:
	go install github.com/golang/protobuf/protoc-gen-go@latest

##### go.mod #####
update-dependencies:
	printf $(COLOR) "Update go dependencies..."
	go get -u -t $(PINNED_DEPENDENCIES) ./...

gomodtidy:
	printf $(COLOR) "go mod tidy..."
	go mod tidy

##### Clean #####
clean:
	printf $(COLOR) "Deleting generated go files..."
	# Delete all directories with *.pb.go and *.mock.go files from $(PROTO_OUT)
	find $(PROTO_OUT) \( -name "*.pb.go" -o -name "*.mock.go" \) | xargs -I{} dirname {} | sort -u | xargs rm -rf