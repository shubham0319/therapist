// Package logger wraps go.uber.org/zap and provides a single initialised
// *zap.Logger that the rest of the application retrieves via Get() or Named().
//
// Usage:
//
//	// once, at startup
//	logger.Init(isProd, logLevel)
//
//	// in any package
//	log := logger.Named("service")
//	log.Info("therapist created", zap.String("therapist_id", id))
package logger

import (
	"os"
	"sync"

	"go.uber.org/zap"
	"go.uber.org/zap/zapcore"
)

var (
	global *zap.Logger
	once   sync.Once
)

// Init builds and stores the global logger. Call exactly once at startup.
// isProd=true → JSON encoder, info level.
// isProd=false → console encoder with colour, debug level.
func Init(isProd bool, levelStr string) {
	once.Do(func() {
		level := parseLevel(levelStr)

		var cfg zap.Config
		if isProd {
			cfg = zap.NewProductionConfig()
			cfg.EncoderConfig.TimeKey = "ts"
			cfg.EncoderConfig.EncodeTime = zapcore.ISO8601TimeEncoder
		} else {
			cfg = zap.NewDevelopmentConfig()
			cfg.EncoderConfig.EncodeLevel = zapcore.CapitalColorLevelEncoder
		}
		cfg.Level = zap.NewAtomicLevelAt(level)

		logger, err := cfg.Build(zap.AddCaller(), zap.AddCallerSkip(0))
		if err != nil {
			// fallback: plain stderr logger
			logger = zap.New(zapcore.NewCore(
				zapcore.NewConsoleEncoder(zap.NewDevelopmentEncoderConfig()),
				zapcore.AddSync(os.Stderr),
				zapcore.DebugLevel,
			))
		}
		global = logger
	})
}

// Get returns the global logger, initialising a no-op logger if Init was never
// called (safe for tests that don't set up logging).
func Get() *zap.Logger {
	if global == nil {
		return zap.NewNop()
	}
	return global
}

// Named returns a child logger tagged with the given component name.
// Use one per package: var log = logger.Named("service")
func Named(name string) *zap.Logger {
	return Get().Named(name)
}

// Sync flushes any buffered log entries. Call at shutdown.
func Sync() {
	if global != nil {
		_ = global.Sync()
	}
}

func parseLevel(s string) zapcore.Level {
	switch s {
	case "debug":
		return zapcore.DebugLevel
	case "warn":
		return zapcore.WarnLevel
	case "error":
		return zapcore.ErrorLevel
	default:
		return zapcore.InfoLevel
	}
}
