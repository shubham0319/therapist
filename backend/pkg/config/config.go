package config

import (
	"fmt"
	"os"
	"path/filepath"
	"runtime"
	"github.com/joho/godotenv"
	"github.com/kelseyhightower/envconfig"
)

const (
	envPrefix = "therapist"
)

type Postgres struct {
	ConnectionString string `required:"true" split_words:"true"`
}
type RedisConfig struct {
	ConnectionString string `required:"true" split_words:"true"`
	Username         string `split_words:"true"`
	Password         string `split_words:"true"`
}
type Redis struct {
	RedisConfig RedisConfig
}
type WebServer struct {
	GrpcPort    int `required:"true" split_words:"true"`
	GrpcWebPort int `required:"true" split_words:"true"` // gRPC-web for browser clients
}



type App struct {
	ServiceName       string `required:"true" split_words:"true"`
	LogLevel          string `required:"true" split_words:"true"`
	IsProdEnv         bool   `required:"true" split_words:"true"`
	Postgres          Postgres
	WebServer         WebServer
	Redis             Redis
	SupabaseJWTSecret      string `required:"true" split_words:"true"`
	JWTSecret              string `required:"true" split_words:"true"`
	AccessTokenTTLMinutes  int    `default:"15"    split_words:"true"`
	RefreshTokenTTLDays    int    `default:"30"    split_words:"true"`
}

func FromEnv() (*App, error) {
	fromFileToEnv()
	cfg := &App{}
	if err := envconfig.Process(envPrefix, cfg); err != nil {
		return nil, err
	}
	return cfg, nil
}

func fromFileToEnv() {
	cfgFileName := os.Getenv("ENV_FILE")
	if cfgFileName != "" {
		if err := godotenv.Load(cfgFileName); err != nil {
			fmt.Println("error: failure reading ENV_FILE file, ", err)
		} else {
			return
		}
	}

	_, b, _, _ := runtime.Caller(0)
	cfgFileName = filepath.Join(filepath.Dir(b), "../../etc/config.local.env")

	if err := godotenv.Load(cfgFileName); err != nil {
		fmt.Println("error: failure reading config file:, ", err)
	}
}
