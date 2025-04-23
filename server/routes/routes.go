package routes

import (
	"github.com/Vishwa-Karthik/zerodha/internal"
	"github.com/gin-gonic/gin"
)

func RegisterRoutes(router *gin.Engine) {

	router.GET("/ping", internal.Pong)
	router.GET("/stocks", internal.StocksStream)
}
