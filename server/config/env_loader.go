package config

import (
	"log"

	"github.com/joho/godotenv"
)

func EnvLoader() {
	err := godotenv.Load()
	if err != nil {
		log.Fatalf("Error loading .env file due to %v", err)
		return
	}
}
