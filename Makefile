.PHONY: proto build

# Generate Go code from proto files.
# Requires: protoc, protoc-gen-go, protoc-gen-go-grpc
# Install plugins once: go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
#                       go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
proto:
	protoc \
		--go_out=backend \
		--go_opt=paths=source_relative \
		--go_opt=Mproto/therapist.proto=therapist/pkg/proto/therapistpb \
		--go-grpc_out=backend \
		--go-grpc_opt=paths=source_relative \
		--go-grpc_opt=Mproto/therapist.proto=therapist/pkg/proto/therapistpb \
		proto/therapist.proto
	mv backend/proto/*.pb.go backend/pkg/proto/therapistpb/

build:
	cd backend && go build ./...
