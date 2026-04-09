package gapi

import (
	"context"
	"fmt"
	"net/http"
	"time"

	"github.com/improbable-eng/grpc-web/go/grpcweb"
	"go.uber.org/zap"
)

// RunWeb wraps the native gRPC server with gRPC-web and serves it over HTTP.
// This allows Flutter web (browser) to call gRPC methods via the gRPC-web protocol.
// Native gRPC clients (mobile/desktop) continue using Run() on port 50051.
func (g *Grpc) RunWeb(ctx context.Context, port int) error {
	wrapped := grpcweb.WrapServer(
		g.GrpcServer,
		// Allow all origins — tighten to specific domains in production
		grpcweb.WithOriginFunc(func(origin string) bool { return true }),
		grpcweb.WithWebsockets(true),
		grpcweb.WithWebsocketOriginFunc(func(r *http.Request) bool { return true }),
		// Expose the gRPC-web trailers to the browser
		grpcweb.WithCorsForRegisteredEndpointsOnly(false),
	)

	handler := http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		// Set CORS headers on every response so the browser accepts them
		w.Header().Set("Access-Control-Allow-Origin", "*")
		w.Header().Set("Access-Control-Allow-Methods", "POST, GET, OPTIONS")
		w.Header().Set("Access-Control-Allow-Headers",
			"Accept, Content-Type, Content-Length, Accept-Encoding, "+
				"X-CSRF-Token, Authorization, X-User-Agent, X-Grpc-Web, Grpc-Timeout")
		w.Header().Set("Access-Control-Expose-Headers",
			"Grpc-Status, Grpc-Message, Grpc-Status-Details-Bin")

		// Answer pre-flight immediately
		if r.Method == http.MethodOptions {
			w.WriteHeader(http.StatusNoContent)
			return
		}

		if wrapped.IsGrpcWebRequest(r) ||
			wrapped.IsAcceptableGrpcCorsRequest(r) ||
			wrapped.IsGrpcWebSocketRequest(r) {
			wrapped.ServeHTTP(w, r)
			return
		}

		http.NotFound(w, r)
	})

	srv := &http.Server{
		Addr:              fmt.Sprintf(":%d", port),
		Handler:           handler,
		ReadHeaderTimeout: 10 * time.Second,
	}

	g.log.Info("gRPC-web server listening", zap.Int("port", port))

	go func() {
		<-ctx.Done()
		shutCtx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
		defer cancel()
		_ = srv.Shutdown(shutCtx)
	}()

	if err := srv.ListenAndServe(); err != nil && err != http.ErrServerClosed {
		return err
	}
	return nil
}