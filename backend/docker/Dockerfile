# ── Stage 1: install goose ────────────────────────────────────────────────────
FROM alpine:3.19 AS tools
RUN apk add --no-cache curl bash
RUN curl -fsSL https://raw.githubusercontent.com/pressly/goose/master/install.sh | sh

# ── Stage 2: build Go binary ──────────────────────────────────────────────────
FROM golang:1.23.4 AS builder
WORKDIR /build

COPY go.mod go.sum ./
RUN go mod download

COPY . .
COPY --from=tools /usr/local/bin/goose /usr/local/bin/goose

RUN CGO_ENABLED=0 go build -o therapist ./cmd/main.go

# ── Stage 3: minimal runtime image ────────────────────────────────────────────
FROM alpine:3.19
RUN apk add --no-cache bash

# Binary
COPY --from=builder /build/therapist /root/main
RUN chmod +x /root/main

# goose (for migrations at startup)
COPY --from=builder /usr/local/bin/goose /usr/local/bin/goose

# Config (env vars override these at runtime)
RUN mkdir -p /root/etc
COPY etc/config.local.env /root/etc/config.local.env

# Migration SQL files
COPY pkg/repo/db/schema/migrations /root/migrations

# Entrypoint script
COPY script/migration_docker.sh /root/script/migration_docker.sh
RUN chmod +x /root/script/migration_docker.sh

EXPOSE 50051

ENTRYPOINT ["/root/script/migration_docker.sh"]
