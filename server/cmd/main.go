package main

import (
	"log"
	"os"

	"github.com/Vishwa-Karthik/zerodha/config"
	"github.com/Vishwa-Karthik/zerodha/internal"
	"github.com/Vishwa-Karthik/zerodha/routes"
	"github.com/gin-gonic/gin"
)

func init() {
	config.EnvLoader()

}

func main() {

	// Initialize Gin router
	r := gin.Default()

	config.SetupCORS(r)

	routes.RegisterRoutes(r)

	go internal.StartStockBroadcaster()

	port := os.Getenv("PORT")
	if port != "" {
		port = "8080"
	}

	log.Fatal(r.Run("0.0.0.0:" + port))
}
