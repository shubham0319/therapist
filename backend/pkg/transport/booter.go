package gapi

import "context"

type Booter interface {
	Initialize(ctx context.Context) error
	Run(ctx context.Context) error
	RunWeb(ctx context.Context, port int) error
	Shutdown(ctx context.Context) error
}
