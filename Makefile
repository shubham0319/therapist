# ─────────────────────────────────────────────────────────────────────────────
# Therapist — root Makefile
#
# Usage:
#   make dev          → start backend + mobile together (tmux)
#   make dev-backend  → backend only
#   make dev-mobile   → flutter only (pick device interactively)
#   make build        → compile backend binary
#   make proto        → regenerate Go code from proto/therapist.proto
#   make sqlc         → regenerate sqlc query code
#   make lint         → run linters (backend + flutter)
#   make test         → run all tests
#   make stop         → kill background processes started by make dev
# ─────────────────────────────────────────────────────────────────────────────

SHELL := /bin/bash
.PHONY: dev dev-backend dev-mobile redis redis-stop build proto sqlc lint \
        lint-backend lint-mobile test test-backend test-mobile stop clean help \
        migrate docker-build docker-run docker-stop

# ── Paths ─────────────────────────────────────────────────────────────────────
BACKEND_DIR  := backend
MOBILE_DIR   := mobile
FLUTTER      := $(HOME)/flutter/bin/flutter
GO           := /usr/local/go/bin/go
PROTO_DIR    := proto
PROTO_OUT    := $(BACKEND_DIR)/pkg/proto/therapistpb
PROTO_FILES  := $(PROTO_DIR)/therapist.proto \
                $(PROTO_DIR)/user.proto \
                $(PROTO_DIR)/blog.proto \
                $(PROTO_DIR)/discovery.proto
ENV_FILE     := $(BACKEND_DIR)/etc/config.local.env
DOCKER_IMAGE := therapist-backend
DOCKER_TAG   := latest

# ── Colors ────────────────────────────────────────────────────────────────────
GREEN  := \033[0;32m
YELLOW := \033[0;33m
CYAN   := \033[0;36m
RESET  := \033[0m

# ─────────────────────────────────────────────────────────────────────────────
# dev: run backend + mobile in split panes (requires tmux)
# Falls back to running them in two background processes if tmux is absent.
# ─────────────────────────────────────────────────────────────────────────────
dev:
	@if command -v tmux &>/dev/null; then \
		echo -e "$(CYAN)Starting dev session in tmux...$(RESET)"; \
		tmux new-session -d -s therapist -x 220 -y 50 2>/dev/null || true; \
		tmux rename-window -t therapist:0 'backend'; \
		tmux send-keys -t therapist:0 'make dev-backend' Enter; \
		tmux new-window  -t therapist -n 'mobile'; \
		tmux send-keys -t therapist:mobile 'make dev-mobile' Enter; \
		tmux select-window -t therapist:backend; \
		tmux attach-session -t therapist; \
	else \
		echo -e "$(YELLOW)tmux not found — running backend in background, mobile in foreground$(RESET)"; \
		make dev-backend & \
		sleep 3; \
		make dev-mobile; \
	fi

# ─────────────────────────────────────────────────────────────────────────────
# Redis (local, via Docker — Postgres lives on Supabase)
# ─────────────────────────────────────────────────────────────────────────────
redis:
	@echo -e "$(GREEN)▶ Ensuring Redis is running...$(RESET)"
	@if redis-cli ping 2>/dev/null | grep -q PONG; then \
		echo -e "$(GREEN)✔ Redis already running on localhost:6379$(RESET)"; \
	else \
		docker compose -f $(BACKEND_DIR)/docker/docker-compose.yml up -d redis && \
		echo -e "$(GREEN)✔ Redis started on localhost:6379$(RESET)"; \
	fi

redis-stop:
	@docker compose -f $(BACKEND_DIR)/docker/docker-compose.yml down
	@echo -e "$(GREEN)✔ Redis stopped$(RESET)"

# ─────────────────────────────────────────────────────────────────────────────
# Backend
# ─────────────────────────────────────────────────────────────────────────────
dev-backend: redis
	@echo -e "$(GREEN)▶ Starting backend (gRPC)...$(RESET)"
	@cd $(BACKEND_DIR) && \
		ENV_FILE=./etc/config.local.env \
		$(GO) run ./cmd/main.go

build:
	@echo -e "$(GREEN)▶ Building backend binary...$(RESET)"
	@cd $(BACKEND_DIR) && $(GO) build -o bin/therapist ./cmd/main.go
	@echo -e "$(GREEN)✔ Binary at backend/bin/therapist$(RESET)"

# ─────────────────────────────────────────────────────────────────────────────
# Migrations (runs goose directly against Supabase — no Docker needed)
# ─────────────────────────────────────────────────────────────────────────────
migrate:
	@echo -e "$(CYAN)▶ Running database migrations...$(RESET)"
	@set -a; source $(ENV_FILE); set +a; \
		PATH="$$PATH:$$HOME/go/bin" goose \
			-dir $(BACKEND_DIR)/pkg/repo/db/schema/migrations \
			postgres "$$THERAPIST_POSTGRES_CONNECTION_STRING" up
	@echo -e "$(GREEN)✔ Migrations complete$(RESET)"

migrate-status:
	@set -a; source $(ENV_FILE); set +a; \
		PATH="$$PATH:$$HOME/go/bin" goose \
			-dir $(BACKEND_DIR)/pkg/repo/db/schema/migrations \
			postgres "$$THERAPIST_POSTGRES_CONNECTION_STRING" status

migrate-down:
	@echo -e "$(YELLOW)▶ Rolling back last migration...$(RESET)"
	@set -a; source $(ENV_FILE); set +a; \
		PATH="$$PATH:$$HOME/go/bin" goose \
			-dir $(BACKEND_DIR)/pkg/repo/db/schema/migrations \
			postgres "$$THERAPIST_POSTGRES_CONNECTION_STRING" down
	@echo -e "$(GREEN)✔ Rollback complete$(RESET)"

# ─────────────────────────────────────────────────────────────────────────────
# Docker  (migration runs automatically at container startup via ENTRYPOINT)
# ─────────────────────────────────────────────────────────────────────────────
docker-build:
	@echo -e "$(CYAN)▶ Building Docker image $(DOCKER_IMAGE):$(DOCKER_TAG)...$(RESET)"
	@docker build \
		-f $(BACKEND_DIR)/docker/Dockerfile \
		-t $(DOCKER_IMAGE):$(DOCKER_TAG) \
		$(BACKEND_DIR)
	@echo -e "$(GREEN)✔ Image built: $(DOCKER_IMAGE):$(DOCKER_TAG)$(RESET)"

docker-run:
	@echo -e "$(GREEN)▶ Starting backend container (migrations run automatically)...$(RESET)"
	@docker run --rm \
		--name therapist_backend \
		--env-file $(ENV_FILE) \
		-p 50051:50051 \
		$(DOCKER_IMAGE):$(DOCKER_TAG)

docker-stop:
	@docker stop therapist_backend 2>/dev/null && \
		echo -e "$(GREEN)✔ Container stopped$(RESET)" || \
		echo -e "$(YELLOW)No running container named therapist_backend$(RESET)"

# ─────────────────────────────────────────────────────────────────────────────
# Mobile (Flutter)
# ─────────────────────────────────────────────────────────────────────────────
dev-mobile:
	@echo -e "$(GREEN)▶ Starting Flutter app (development flavor)...$(RESET)"
	@cd $(MOBILE_DIR) && \
		$(FLUTTER) run -d chrome \
			--dart-define=FLAVOR=development \
			--web-port=3001

# Run on a specific device (usage: make mobile-device DEVICE=emulator-5554)
mobile-device:
	@cd $(MOBILE_DIR) && \
		$(FLUTTER) run -d $(DEVICE) --dart-define=FLAVOR=development

# ─────────────────────────────────────────────────────────────────────────────
# Code generation
# ─────────────────────────────────────────────────────────────────────────────

# Regenerate Go + Dart protobuf / gRPC stubs from proto/*.proto
# Requires: protoc, protoc-gen-go, protoc-gen-go-grpc, protoc-gen-dart
# Install once:
#   go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
#   go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
proto: proto-go proto-dart

proto-go:
	@echo -e "$(CYAN)▶ Generating Go protobuf stubs...$(RESET)"
	@PATH="$$PATH:$$HOME/go/bin" protoc \
		-I . \
		--go_out=$(BACKEND_DIR) \
		--go_opt=paths=source_relative \
		--go_opt=Mproto/therapist.proto=therapist/pkg/proto/therapistpb \
		--go_opt=Mproto/user.proto=therapist/pkg/proto/therapistpb \
		--go_opt=Mproto/blog.proto=therapist/pkg/proto/therapistpb \
		--go_opt=Mproto/discovery.proto=therapist/pkg/proto/therapistpb \
		--go-grpc_out=$(BACKEND_DIR) \
		--go-grpc_opt=paths=source_relative \
		--go-grpc_opt=Mproto/therapist.proto=therapist/pkg/proto/therapistpb \
		--go-grpc_opt=Mproto/user.proto=therapist/pkg/proto/therapistpb \
		--go-grpc_opt=Mproto/blog.proto=therapist/pkg/proto/therapistpb \
		--go-grpc_opt=Mproto/discovery.proto=therapist/pkg/proto/therapistpb \
		$(PROTO_FILES)
	@mv $(BACKEND_DIR)/proto/*.pb.go $(PROTO_OUT)/
	@echo -e "$(GREEN)✔ Go stubs → $(PROTO_OUT)$(RESET)"

proto-dart:
	@echo -e "$(CYAN)▶ Generating Dart protobuf stubs...$(RESET)"
	@PATH="$$PATH:$$HOME/.pub-cache/bin" protoc \
		-I . \
		--dart_out=grpc:$(MOBILE_DIR)/lib/core \
		$(PROTO_FILES)
	@echo -e "$(GREEN)✔ Dart stubs → $(MOBILE_DIR)/lib/core/proto$(RESET)"

# Regenerate sqlc query code from SQL files
sqlc:
	@echo -e "$(CYAN)▶ Running sqlc generate...$(RESET)"
	@cd $(BACKEND_DIR) && sqlc generate
	@echo -e "$(GREEN)✔ sqlc done$(RESET)"

# ─────────────────────────────────────────────────────────────────────────────
# Linting
# ─────────────────────────────────────────────────────────────────────────────
lint: lint-backend lint-mobile

lint-backend:
	@echo -e "$(CYAN)▶ Linting backend...$(RESET)"
	@cd $(BACKEND_DIR) && $(GO) vet ./...
	@if command -v staticcheck &>/dev/null; then \
		cd $(BACKEND_DIR) && staticcheck ./...; \
	else \
		echo -e "$(YELLOW)  staticcheck not found — skipping (go install honnef.co/go/tools/cmd/staticcheck@latest)$(RESET)"; \
	fi

lint-mobile:
	@echo -e "$(CYAN)▶ Linting Flutter...$(RESET)"
	@cd $(MOBILE_DIR) && $(FLUTTER) analyze

# ─────────────────────────────────────────────────────────────────────────────
# Tests
# ─────────────────────────────────────────────────────────────────────────────
test: test-backend test-mobile

test-backend:
	@echo -e "$(CYAN)▶ Running backend tests...$(RESET)"
	@cd $(BACKEND_DIR) && $(GO) test ./... -v -race -timeout 60s

test-mobile:
	@echo -e "$(CYAN)▶ Running Flutter tests...$(RESET)"
	@cd $(MOBILE_DIR) && $(FLUTTER) test

# ─────────────────────────────────────────────────────────────────────────────
# Housekeeping
# ─────────────────────────────────────────────────────────────────────────────

# Kill the tmux session + stop Redis
stop:
	@tmux kill-session -t therapist 2>/dev/null && \
		echo -e "$(GREEN)✔ therapist tmux session stopped$(RESET)" || \
		echo -e "$(YELLOW)No tmux session named 'therapist' found$(RESET)"
	@make redis-stop

clean:
	@rm -f $(BACKEND_DIR)/bin/therapist
	@cd $(MOBILE_DIR) && $(FLUTTER) clean
	@echo -e "$(GREEN)✔ cleaned$(RESET)"

# ─────────────────────────────────────────────────────────────────────────────
# Help
# ─────────────────────────────────────────────────────────────────────────────
help:
	@echo ""
	@echo -e "$(CYAN)Therapist Makefile$(RESET)"
	@echo ""
	@echo "  make dev              Start Redis + backend + mobile in tmux split"
	@echo "  make dev-backend      Start Redis + backend gRPC server"
	@echo "  make dev-mobile       Flutter app only"
	@echo "  make redis            Start Redis container (Docker required)"
	@echo "  make redis-stop       Stop Redis container"
	@echo "  make migrate          Run goose migrations against Supabase"
	@echo "  make migrate-status   Show current migration status"
	@echo "  make migrate-down     Roll back the last migration"
	@echo "  make docker-build     Build the backend Docker image"
	@echo "  make docker-run       Run the backend container (migrations auto-run)"
	@echo "  make docker-stop      Stop the backend container"
	@echo "  make build            Compile backend binary → backend/bin/therapist"
	@echo "  make proto            Regenerate Go gRPC stubs from proto/"
	@echo "  make sqlc             Regenerate sqlc query code"
	@echo "  make lint             Run go vet + flutter analyze"
	@echo "  make test             Run all tests"
	@echo "  make stop             Kill the tmux dev session"
	@echo "  make clean            Remove build artifacts"
	@echo ""
