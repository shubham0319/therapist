package service

import (
	"therapist/pkg/config"
	"therapist/pkg/logger"

	"go.uber.org/zap"
)

type Service struct {
	db    dbHelper
	cache cacheHelper
	cfg   *config.App
	log   *zap.Logger
}

func New(db dbHelper, cache cacheHelper, cfg *config.App) *Service {
	return &Service{
		db:    db,
		cache: cache,
		cfg:   cfg,
		log:   logger.Named("service"),
	}
}
