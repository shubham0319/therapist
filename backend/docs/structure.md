# Backend — File Structure

```
backend/
├── cmd/main.go                         # Entry: load config → Boot()
│
├── pkg/
│   ├── auth/jwt.go                     # VerifySupabaseToken, ParseAccessToken
│   ├── config/config.go                # Config struct, LoadFromEnv()
│   ├── logger/logger.go                # Zap logger singleton, Named()
│   ├── storage/storage.go              # File upload stub (S3-ready)
│   │
│   ├── repo/
│   │   ├── cache/                      # Redis stub (cache.go, connect.go)
│   │   └── db/
│   │       ├── new.go                  # DB struct {query, conn, log}, New()
│   │       ├── therapist.go            # CreateTherapist, CompleteOnboarding…
│   │       ├── therapist_address.go    # UpsertTherapistAddress, GetTherapistAddress
│   │       ├── sessions.go             # CreateSession, GetSession, DeleteSession
│   │       ├── blogs.go                # All blog CRUD + likes
│   │       ├── users.go                # UpsertUser, GetUser, CompleteUserOnboarding
│   │       ├── user_sessions.go        # CreateUserSession, GetUserSession…
│   │       ├── discovery.go            # SearchTherapists, CountSearch, GetRecommended
│   │       │
│   │       └── schema/
│   │           ├── migrations/         # goose SQL files (Up/Down)
│   │           └── gen/                # Hand-written sqlc-style layer
│   │               ├── db.go           # Queries struct, New(db)
│   │               ├── models.go       # All DB structs (Therapist, User, Blog…)
│   │               ├── therapist.sql.go
│   │               ├── therapist_address.sql.go
│   │               ├── therapist_sessions.sql.go
│   │               ├── blogs.sql.go
│   │               ├── users.sql.go
│   │               ├── user_sessions.sql.go
│   │               └── discovery.sql.go
│   │
│   ├── service/
│   │   ├── svc.go                      # Service struct, New()
│   │   ├── facade.go                   # dbHelper interface (all DB methods service needs)
│   │   ├── error.go                    # Sentinel errors (ErrBadInput, ErrDBQuery…)
│   │   ├── tokens.go                   # TokenPair, IssueTokens (therapist)
│   │   ├── therapist.go                # Auth, onboarding, approve/reject, refresh, logout
│   │   ├── user.go                     # UserResult, user auth, onboarding, refresh, logout
│   │   ├── blog.go                     # BlogResult, full blog CRUD + likes
│   │   └── discovery.go                # TherapistCard, SearchTherapists, GetRecommended
│   │
│   └── transport/
│       ├── server.go                   # TherapistHandler struct, NewHandler()
│       ├── grpc.go                     # serveGRPC()
│       ├── grpcweb.go                  # serveGRPCWeb()
│       ├── booter.go                   # Boot() — starts both, graceful shutdown
│       └── handler/
│           ├── facade.go               # therapistService interface
│           ├── error.go                # grpcError() maps service errors → gRPC codes
│           ├── therapist.go            # AuthCallback, GetStatus, CompleteOnboarding…
│           ├── user.go                 # UserAuthCallback, CompleteUserOnboarding…
│           ├── blog.go                 # CreateBlog, PublishBlog, ListBlogs…
│           └── discovery.go            # SearchTherapists, GetRecommendedTherapists
│
└── docs/                               # ← you are here
```
