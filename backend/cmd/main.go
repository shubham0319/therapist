package main

import (
	"context"
	"log"
	"therapist/pkg/config"
	"therapist/pkg/logger"
	gapi "therapist/pkg/transport"
)

func main() {
	ctx, cancel := context.WithCancel(context.Background())
	defer cancel()

	appCfg, err := config.FromEnv()
	if err != nil {
		log.Fatal(err)
	}

	// Initialise the global zap logger as early as possible.
	logger.Init(appCfg.IsProdEnv, appCfg.LogLevel)
	defer logger.Sync()

	appLog := logger.Named("main")
	appLog.Info("starting therapist backend", )

	server, err := gapi.NewServer(ctx, appCfg)
	if err != nil {
		appLog.Fatal("failed to create server", )
	}
	defer server.Shutdown(ctx)

	if err := server.Initialize(ctx); err != nil {
		appLog.Fatal("failed to initialise server", )
	}

	if err := server.Run(ctx); err != nil {
		appLog.Fatal("server exited with error", )
	}
}
