package caching

import (
	"context"
	"therapist/pkg/config"
)

type Cache struct {
	redis *Redis
}

func New(ctx context.Context, redisConfig config.RedisConfig) (*Cache, error) {
	redis, err := NewRedis(ctx, redisConfig)
	if err != nil {
		return nil, err
	}
	return &Cache{redis: redis}, nil
}
