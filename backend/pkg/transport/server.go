package gapi

import (
	"context"
	"therapist/pkg/config"
	"therapist/pkg/logger"
	caching "therapist/pkg/repo/cache"
	"therapist/pkg/repo/db"
	"therapist/pkg/service"
	"therapist/pkg/storage"

	"go.uber.org/zap"
)

type server struct {
	grpc        Booter
	grpcWebPort int
	log         *zap.Logger
}

func NewServer(ctx context.Context, appCfg *config.App) (*server, error) {
	log := logger.Named("server")

	log.Info("initialising server", zap.String("service", appCfg.ServiceName))

	dbInstance, err := db.New(ctx, appCfg.Postgres)
	if err != nil {
		log.Error("database init failed", zap.Error(err))
		return nil, err
	}

	cache, err := caching.New(ctx, appCfg.Redis.RedisConfig)
	if err != nil {
		log.Error("cache init failed", zap.Error(err))
		return nil, err
	}

	store := storage.New(logger.Named("storage"))
	svc := service.New(dbInstance, cache, store, appCfg)
	log.Info("service layer ready")

	return &server{
		grpc:        NewGRPCServer(appCfg.WebServer, svc),
		grpcWebPort: appCfg.WebServer.GrpcWebPort,
		log:         log,
	}, nil
}

func (s *server) Initialize(ctx context.Context) error {
	s.log.Info("initialising gRPC server")
	return s.grpc.Initialize(ctx)
}

func (s *server) Run(ctx context.Context) error {
	s.log.Info("starting gRPC + gRPC-web servers")

	errCh := make(chan error, 2)

	// Native gRPC (port 50051) — for mobile/desktop/server clients
	go func() {
		if err := s.grpc.Run(ctx); err != nil {
			errCh <- err
		}
	}()

	// gRPC-web (port 8080) — for Flutter web / browser clients
	go func() {
		if err := s.grpc.RunWeb(ctx, s.grpcWebPort); err != nil {
			errCh <- err
		}
	}()

	select {
	case err := <-errCh:
		return err
	case <-ctx.Done():
		return nil
	}
}

func (s *server) Shutdown(ctx context.Context) error {
	s.log.Info("shutting down server")
	return s.grpc.Shutdown(ctx)
}
