package gapi

import (
	"context"
	"therapist/pkg/config"
	"therapist/pkg/logger"
	caching "therapist/pkg/repo/cache"
	"therapist/pkg/repo/db"
	"therapist/pkg/service"

	"go.uber.org/zap"
)

type server struct {
	grpc Booter
	log  *zap.Logger
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

	svc := service.New(dbInstance, cache, appCfg)
	log.Info("service layer ready")

	return &server{
		grpc: NewGRPCServer(appCfg.WebServer, svc),
		log:  log,
	}, nil
}

func (s *server) Initialize(ctx context.Context) error {
	s.log.Info("initialising gRPC server")
	return s.grpc.Initialize(ctx)
}

func (s *server) Run(ctx context.Context) error {
	s.log.Info("starting gRPC server")
	return s.grpc.Run(ctx)
}

func (s *server) Shutdown(ctx context.Context) error {
	s.log.Info("shutting down server")
	return s.grpc.Shutdown(ctx)
}
