# Stage 1: Tools (for downloading dependencies)
FROM alpine:3.19 AS tools

# Install essential tools
RUN apk add --no-cache curl tar bash

# Install goose for migrations
RUN curl -fsSL https://raw.githubusercontent.com/pressly/goose/master/install.sh | sh

# Stage 2: Builder
FROM golang:1.23.4 AS builder

WORKDIR /root/


# Copy go.mod and go.sum first (for caching dependencies)
COPY go.mod go.sum ./

# Download Go modules
RUN go mod download

# Copy the entire source code
COPY . .

# Copy tools from the previous stage
COPY --from=tools /usr/local/bin/goose /usr/local/bin/

# Build the Go application
# Stage 2: Builder
# Build the Go application
RUN CGO_ENABLED=0 go build -o hc-service cmd/main.go


# Stage 3: Final container
FROM alpine:3.19

# Install necessary runtime dependencies
RUN apk add --no-cache bash


# # Copy the built Go binary from builder
COPY --from=builder /root/hc-service /root/main
RUN chmod +x /root/main && ls -lah /root/main

RUN mkdir  /root/etc
COPY etc/config.local.env /root/etc/config.local.env


COPY --from=builder /usr/local/bin/goose /usr/local/bin/
COPY script/migration_docker.sh /root/script/migration_docker.sh
RUN chmod +x /root/script/migration_docker.sh

COPY script/seedDB.sh /root/script/seedDB.sh
RUN chmod +x /root/script/seedDB.sh


COPY pkg/repo/db/schema/migrations /root/migrations


# Install necessary runtime dependencies
RUN apk add --no-cache bash postgresql-client  
#  Install PostgreSQL client for pg_isready


# Expose necessary ports
EXPOSE 50051
# Entrypoint script to handle migrations before starting the app

# Run the migration script before starting the app
ENTRYPOINT ["/root/script/migration_docker.sh"]