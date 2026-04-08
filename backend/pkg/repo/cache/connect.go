package caching

import (
	"context"
	"errors"
	"therapist/pkg/config"
	"therapist/pkg/logger"
	"time"

	"github.com/redis/go-redis/v9"
	"go.uber.org/zap"
)

type cacheItem struct {
	ctx   context.Context
	key   string
	value []byte
	ttl   time.Duration
}

type Redis struct {
	rdb *redis.Client
	ch  chan cacheItem
	log *zap.Logger
}

func NewRedis(ctx context.Context, cfg config.RedisConfig) (*Redis, error) {
	log := logger.Named("cache.redis")

	log.Info("connecting to redis", zap.String("addr", cfg.ConnectionString))

	rdb := redis.NewClient(&redis.Options{
		Addr:         cfg.ConnectionString,
		Username:     cfg.Username,
		Password:     cfg.Password,
		DB:           0,
		Protocol:     3,
		DialTimeout:  10 * time.Second,
		ReadTimeout:  10 * time.Second,
		WriteTimeout: 10 * time.Second,
	})

	if err := rdb.Ping(ctx).Err(); err != nil {
		log.Error("redis ping failed", zap.Error(err))
		return nil, err
	}
	log.Info("redis connected")

	ch := make(chan cacheItem, 100)
	r := &Redis{rdb: rdb, ch: ch, log: log}
	go r.sendToRedis()
	return r, nil
}

func (r *Redis) Client() *redis.Client {
	return r.rdb
}

func (r *Redis) Shutdown(ctx context.Context) error {
	r.log.Info("shutting down redis client")
	close(r.ch)
	return r.rdb.Close()
}

func (r *Redis) Get(ctx context.Context, key string) (value []byte, found bool) {
	r.log.Debug("cache GET", zap.String("key", key))

	value, err := r.rdb.Get(ctx, key).Bytes()
	if err != nil {
		if errors.Is(err, redis.Nil) {
			r.log.Debug("cache miss", zap.String("key", key))
			return
		}
		r.log.Error("cache GET error", zap.String("key", key), zap.Error(err))
		return
	}
	found = true
	r.log.Debug("cache hit", zap.String("key", key))
	return
}

func (r *Redis) SetSync(ctx context.Context, key string, value []byte, ttl time.Duration) error {
	r.log.Debug("cache SET sync", zap.String("key", key), zap.Duration("ttl", ttl))

	if err := r.rdb.Set(ctx, key, value, ttl).Err(); err != nil {
		r.log.Error("cache SET sync failed", zap.String("key", key), zap.Error(err))
		return err
	}
	return nil
}

func (r *Redis) SetAsync(ctx context.Context, key string, value []byte, ttl time.Duration) {
	r.log.Debug("cache SET async enqueued", zap.String("key", key), zap.Duration("ttl", ttl))
	r.ch <- cacheItem{ctx, key, value, ttl}
}

func (r *Redis) sendToRedis() {
	for item := range r.ch {
		if err := r.SetSync(context.Background(), item.key, item.value, item.ttl); err != nil {
			r.log.Error("async cache write failed", zap.String("key", item.key), zap.Error(err))
		}
	}
}
