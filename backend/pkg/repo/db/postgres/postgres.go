package postgres

import (
	"context"
	"fmt"
	"therapist/pkg/logger"
	"time"

	"github.com/jackc/pgx/v5"
	"github.com/jackc/pgx/v5/pgtype"
	"github.com/jackc/pgx/v5/pgxpool"
	"go.uber.org/zap"
)

const connTimeout = 10 * time.Second

// customEnums are the PostgreSQL enum types we need to register so that pgx
// knows their OIDs and can scan them (including array variants like session_type_enum[]).
var customEnums = []string{
	"gender_enum",
	"session_type_enum",
	"verification_status_enum",
}

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

	poolCfg, err := pgxpool.ParseConfig(cfg.ConnectionString)
	if err != nil {
		log.Error("failed to parse connection string", zap.Error(err))
		return nil, err
	}

	// AfterConnect runs on every new connection in the pool.
	// We load each enum's OID from pg_type and register it (+ its array type)
	// so that pgx can scan columns of those types.
	poolCfg.AfterConnect = func(ctx context.Context, c *pgx.Conn) error {
		for _, enum := range customEnums {
			if err := registerEnum(ctx, c, enum); err != nil {
				return fmt.Errorf("register enum %q: %w", enum, err)
			}
		}
		return nil
	}

	pool, err := pgxpool.NewWithConfig(ctx, poolCfg)
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

// registerEnum looks up the OID of a custom enum from pg_type and registers
// both the scalar type and its array type in the connection's type map.
func registerEnum(ctx context.Context, c *pgx.Conn, typeName string) error {
	var oid uint32
	err := c.QueryRow(ctx,
		"SELECT oid FROM pg_type WHERE typname = $1", typeName,
	).Scan(&oid)
	if err != nil {
		return fmt.Errorf("lookup OID: %w", err)
	}

	// Register the scalar enum type with text codec
	scalarType := &pgtype.Type{
		Name:  typeName,
		OID:   oid,
		Codec: pgtype.TextCodec{},
	}
	c.TypeMap().RegisterType(scalarType)

	// Look up and register the array type (pg convention: "_typename")
	var arrayOID uint32
	err = c.QueryRow(ctx,
		"SELECT oid FROM pg_type WHERE typname = $1", "_"+typeName,
	).Scan(&arrayOID)
	if err != nil {
		// Array type not found — not fatal
		return nil
	}

	c.TypeMap().RegisterType(&pgtype.Type{
		Name:  "_" + typeName,
		OID:   arrayOID,
		Codec: &pgtype.ArrayCodec{ElementType: scalarType},
	})

	return nil
}

func (d *DB) Conn() *pgxpool.Pool { return d.conn }

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
