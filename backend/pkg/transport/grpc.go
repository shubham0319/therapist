package gapi

import (
	"context"
	"fmt"
	"net"
	"therapist/pkg/config"
	"therapist/pkg/logger"
	"therapist/pkg/proto/therapistpb"
	"therapist/pkg/service"
	"therapist/pkg/transport/handler"

	"go.opentelemetry.io/contrib/instrumentation/google.golang.org/grpc/otelgrpc"
	"go.uber.org/zap"
	"google.golang.org/grpc"
	"google.golang.org/grpc/reflection"
)

type Grpc struct {
	GrpcServer *grpc.Server
	WebConfig  config.WebServer
	service    *service.Service
	log        *zap.Logger
}

func NewGRPCServer(webConfig config.WebServer, s *service.Service) *Grpc {
	return &Grpc{
		GrpcServer: grpc.NewServer(
			grpc.StatsHandler(otelgrpc.NewServerHandler()),
		),
		WebConfig: webConfig,
		service:   s,
		log:       logger.Named("grpc"),
	}
}

func (g *Grpc) Initialize(ctx context.Context) error {
	g.log.Info("registering gRPC services")

	therapistpb.RegisterTherapistServiceServer(g.GrpcServer, handler.NewTherapistHandler(g.service))
	g.log.Debug("TherapistService registered")

	reflection.Register(g.GrpcServer)
	g.log.Debug("gRPC reflection enabled")

	return nil
}

func (g *Grpc) Run(ctx context.Context) error {
	port := fmt.Sprintf(":%d", g.WebConfig.GrpcPort)

	lis, err := net.Listen("tcp", port)
	if err != nil {
		g.log.Error("failed to bind gRPC port", zap.String("port", port), zap.Error(err))
		return err
	}

	g.log.Info("gRPC server listening", zap.String("port", port))
	return g.GrpcServer.Serve(lis)
}

func (g *Grpc) Shutdown(ctx context.Context) error {
	g.log.Info("gracefully stopping gRPC server")
	g.GrpcServer.GracefulStop()
	g.log.Info("gRPC server stopped")
	return nil
}
