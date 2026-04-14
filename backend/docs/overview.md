# Backend — Overview

## Tech Stack
- Go · gRPC + gRPC-Web · Protobuf
- PostgreSQL (Supabase) · goose migrations · hand-written sqlc-style query layer
- Zap logging · JWT (golang-jwt/jwt v5) · bcrypt-random refresh tokens

## Entry Point
`cmd/main.go` → `transport.Boot()` → starts native gRPC (`:50051`) + gRPC-Web (`:8080`) concurrently

## Layers (top → bottom)

```
proto/therapist.proto
      ↓  make proto
pkg/proto/therapistpb/          Generated Go stubs

pkg/transport/handler/          gRPC handlers (one file per domain)
      ↓  calls
pkg/service/                    Business logic (one file per domain)
      ↓  calls via dbHelper interface
pkg/repo/db/                    DB wrapper (thin, typed)
      ↓  calls
pkg/repo/db/schema/gen/         Raw SQL execution (sqlc-style, hand-written)
      ↓
PostgreSQL (Supabase)
```

## Server Setup (`pkg/transport/`)
| File | Purpose |
|---|---|
| `server.go` | Shared `TherapistHandler` struct, `NewHandler()` |
| `grpc.go` | Native gRPC listener (port 50051) |
| `grpcweb.go` | gRPC-Web wrapper (port 8080, for Flutter Web) |
| `booter.go` | `Boot()` — starts both servers with graceful shutdown |

## Config (`pkg/config/config.go`)
Loaded from env vars. Key fields:
- `GRPCPort`, `GRPCWebPort`
- `JWTSecret`, `AccessTokenTTLMinutes`, `RefreshTokenTTLDays`
- `SupabaseJWTSecret`
- `IsProdEnv` (disables dev bypass when true)
