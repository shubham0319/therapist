# Therapist

A platform for verified therapists — Go gRPC backend + Flutter mobile app.

---

## Architecture

```
therapist/
├── proto/                        # Single source of truth: therapist.proto
├── backend/
│   ├── cmd/main.go               # Entry point
│   └── pkg/
│       ├── config/               # Env-based config (config.local.env)
│       ├── auth/                 # JWT / session tokens
│       ├── service/              # Business logic (therapist, blog, tokens…)
│       ├── transport/handler/    # gRPC handlers (maps proto RPCs → service)
│       ├── repo/db/              # DB layer
│       │   ├── schema/migrations # Goose SQL migrations
│       │   ├── schema/gen/       # sqlc-generated models + query code
│       │   └── schema/query/     # Raw .sql files for sqlc
│       ├── storage/              # Supabase Storage uploads
│       └── proto/therapistpb/    # Generated Go gRPC stubs
└── mobile/
    └── lib/
        ├── core/
        │   ├── di/               # GetIt service locator
        │   ├── network/          # GrpcClient (channel management)
        │   ├── proto/            # Generated Dart gRPC stubs
        │   ├── router/           # GoRouter (app_router.dart)
        │   ├── session/          # Session storage helpers
        │   └── error/            # Failure / Result types
        ├── features/
        │   ├── auth/             # Login, AuthBloc (app-level)
        │   ├── onboarding/       # Therapist onboarding form
        │   ├── home/             # Home page
        │   ├── blog/             # Blog list / detail / create-edit (BLoC)
        │   ├── status/           # Pending / rejected status pages
        │   └── profile/          # Therapist profile
        └── shared/widgets/       # ScaffoldWithNav (bottom nav shell)
```

### Transport

| Platform | Protocol       | Port  |
|----------|----------------|-------|
| Mobile   | gRPC (native)  | 50051 |
| Web      | gRPC-Web       | 8080  |

### Database

- **Hosted**: Supabase PostgreSQL
- **Migrations**: [goose](https://github.com/pressly/goose) — files in `backend/pkg/repo/db/schema/migrations/`
- **Query layer**: Hand-written sqlc-style code in `backend/pkg/repo/db/schema/gen/`

### Auth flow

1. Phone/email OTP → JWT issued
2. JWT carries `therapist_id` and `status` (`needs_onboarding | pending | verified | rejected`)
3. Flutter `AuthBloc` (app-level) holds current state; pages read it synchronously via `context.read<AuthBloc>().state`

---

## Prerequisites

| Tool | Version | Install |
|------|---------|---------|
| Go | 1.22+ | https://go.dev/dl |
| Flutter | 3.x | https://docs.flutter.dev/get-started/install |
| protoc | latest | `apt install protobuf-compiler` |
| protoc-gen-go | latest | `go install google.golang.org/protobuf/cmd/protoc-gen-go@latest` |
| protoc-gen-go-grpc | latest | `go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest` |
| protoc-gen-dart | latest | `dart pub global activate protoc_plugin` |
| goose | latest | `go install github.com/pressly/goose/v3/cmd/goose@latest` |
| Docker | any | Required for Redis only |

---

## Quick start

```bash
# 1. Copy and fill in credentials
cp backend/etc/config.example.env backend/etc/config.local.env

# 2. Run migrations
make migrate

# 3. Start everything (requires tmux)
make dev
```

`make dev` opens two tmux panes: backend (gRPC server) and Flutter (Chrome dev).

---

## Common commands

```bash
make dev              # Redis + backend + mobile in tmux
make dev-backend      # Backend only
make dev-mobile       # Flutter only (Chrome)
make build            # Compile backend binary → backend/bin/therapist
make migrate          # Run pending goose migrations
make migrate-status   # Show migration state
make migrate-down     # Roll back last migration
make proto            # Regenerate Go + Dart stubs from proto/therapist.proto
make lint             # go vet + flutter analyze
make test             # Backend + Flutter tests
make stop             # Kill tmux session + Redis
make clean            # Remove build artefacts
```

---

## Environment variables

The backend reads from `backend/etc/config.local.env` (never committed).

| Variable | Description |
|----------|-------------|
| `THERAPIST_POSTGRES_CONNECTION_STRING` | Full Supabase Postgres URL |
| `THERAPIST_SUPABASE_URL` | Supabase project URL |
| `THERAPIST_SUPABASE_SERVICE_KEY` | Supabase service role key |
| `THERAPIST_JWT_SECRET` | JWT signing secret |
| `THERAPIST_GRPC_PORT` | gRPC listen port (default 50051) |
| `THERAPIST_GRPC_WEB_PORT` | gRPC-Web port (default 8080) |
| `THERAPIST_REDIS_ADDR` | Redis address (default localhost:6379) |

---

## Code generation

### Protobuf (Go + Dart)

Edit `proto/therapist.proto` then:

```bash
make proto
```

This runs `protoc` twice — once for Go stubs (`backend/pkg/proto/therapistpb/`) and once for Dart stubs (`mobile/lib/core/proto/`).

### Database queries

SQL queries live in `backend/pkg/repo/db/schema/query/*.sql`.  
Generated code is hand-maintained in `backend/pkg/repo/db/schema/gen/` following sqlc conventions (column order must match `Scan` calls).

---

## Blog feature

- Only **verified** therapists can create blogs.
- Draft → Publish two-step flow.
- Text up to **50,000 characters**, 1 cover image + max **2 inline images** (2 MB each, JPEG/PNG/WebP).
- Like and view counts per blog.
- Paginated list (20 per page, infinite scroll in app).

---

## Migration naming convention

```
YYYYMMDDHHMMSS_description.sql
```

Each file must use [goose](https://github.com/pressly/goose) annotations:

```sql
-- +goose Up
-- +goose StatementBegin
CREATE TABLE ...;
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE ...;
-- +goose StatementEnd
```

---

## Adding a new RPC

1. Add message + RPC to `proto/therapist.proto`
2. `make proto` — regenerates Go and Dart stubs
3. Add method to `therapistService` interface in `backend/pkg/transport/handler/facade.go`
4. Add method to `dbHelper` interface in `backend/pkg/service/facade.go` (if new DB calls needed)
5. Implement business logic in `backend/pkg/service/`
6. Implement gRPC handler in `backend/pkg/transport/handler/`
7. Add to `BlogRepository` (or relevant repository) in `mobile/lib/features/.../data/`
8. Wire into the BLoC event/state in `mobile/lib/features/.../bloc/`
