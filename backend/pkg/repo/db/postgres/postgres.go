package postgres

import (
	"context"
	"therapist/pkg/logger"
	"time"

	"github.com/jackc/pgx/v5"
	"github.com/jackc/pgx/v5/pgxpool"
	"go.uber.org/zap"
)

const connTimeout = 10 * time.Second

type Config struct {
	ConnectionString string `required:"true" split_words:"true"`
}

type DB struct {
	conn *pgxpool.Pool
	log  *zap.Logger
}

func New(ctx context.Context, cfg Config) (*DB, error) {
	log := logger.Named("db.postgres")

	ctx, cancel := context.WithTimeout(ctx, connTimeout)
	defer cancel()

	pool, err := pgxpool.New(ctx, cfg.ConnectionString)
	if err != nil {
		log.Error("failed to create connection pool", zap.Error(err))
		return nil, err
	}

	if err = pool.Ping(ctx); err != nil {
		log.Error("postgres ping failed", zap.Error(err))
		pool.Close()
		return nil, err
	}

	stat := pool.Stat()
	log.Info("postgres pool ready",
		zap.Int32("total_conns", stat.TotalConns()),
		zap.Int32("idle_conns", stat.IdleConns()),
	)

	return &DB{conn: pool, log: log}, nil
}

func (d *DB) Conn() *pgxpool.Pool {
	return d.conn
}

func (d *DB) Ping(ctx context.Context) error {
	if err := d.conn.Ping(ctx); err != nil {
		d.log.Error("postgres ping failed", zap.Error(err))
		return err
	}
	return nil
}

func (d *DB) Tx(ctx context.Context) (pgx.Tx, error) {
	tx, err := d.conn.Begin(ctx)
	if err != nil {
		d.log.Error("failed to begin transaction", zap.Error(err))
	}
	return tx, err
}

func (d *DB) Close() {
	if d.conn != nil {
		d.log.Info("closing postgres connection pool")
		d.conn.Close()
	}
}
