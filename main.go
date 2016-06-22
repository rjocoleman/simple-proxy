package main

import (
	"log"
	"net/http"

	"github.com/caarlos0/env"
	"github.com/elazarl/goproxy"
	"github.com/elazarl/goproxy/ext/auth"
)

// Config ...
type Config struct {
	Address  string `env:"ADDRESS" envDefault:"0.0.0.0:8080"`
	Verbose  bool   `env:"VERBOSE" envDefault:"false"`
	Realm    string `env:"REALM" envDefault:"Authorized"`
	Username string `env:"USERNAME"`
	Password string `env:"PASSWORD"`
}

func main() {
	cfg := Config{}
	env.Parse(&cfg)

	proxy := goproxy.NewProxyHttpServer()
	log.Println("Starting Proxy Server on:", cfg.Address)

	if cfg.Username != "" && cfg.Password != "" {
		log.Printf("Authentication required - User: %v, Pass: %v\n", cfg.Username, cfg.Password)
		auth.ProxyBasic(proxy, cfg.Realm, func(user, password string) bool {
			return user == cfg.Username && password == cfg.Password
		})
	}

	proxy.Verbose = cfg.Verbose
	if cfg.Verbose {
		log.Println("Verbose logging enabled")
	}

	log.Fatal(http.ListenAndServe(cfg.Address, proxy))
}
