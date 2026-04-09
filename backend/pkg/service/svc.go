package service

import (
	"therapist/pkg/config"
	"therapist/pkg/logger"

	"go.uber.org/zap"
)

type Service struct {
	db      dbHelper
	cache   cacheHelper
	storage storageHelper
	cfg     *config.App
	log     *zap.Logger
}

func New(db dbHelper, cache cacheHelper, storage storageHelper, cfg *config.App) *Service {
	return &Service{
		db:      db,
		cache:   cache,
		storage: storage,
		cfg:     cfg,
		log:     logger.Named("service"),
	}
}
