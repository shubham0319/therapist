package db

import (
	"context"
	"therapist/pkg/config"
	"therapist/pkg/logger"
	"therapist/pkg/repo/db/postgres"
	schema "therapist/pkg/repo/db/schema/gen"

	"go.uber.org/zap"
)

type DB struct {
	query *schema.Queries
	conn  *postgres.DB
	log   *zap.Logger
}

func New(ctx context.Context, cfg config.Postgres) (*DB, error) {
	log := logger.Named("db")

	log.Info("connecting to postgres")
	conn, err := postgres.New(ctx, postgres.Config{
		ConnectionString: cfg.ConnectionString,
	})
	if err != nil {
		log.Error("failed to connect to postgres", zap.Error(err))
		return nil, err
	}
	log.Info("postgres connected")

	return &DB{
		query: schema.New(conn.Conn()),
		conn:  conn,
		log:   log,
	}, nil
}
