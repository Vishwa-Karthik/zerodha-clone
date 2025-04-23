package internal

import (
	"log"
	"net/http"
	"time"

	"github.com/Vishwa-Karthik/zerodha/config"
	"github.com/gin-gonic/gin"
)

func Pong(ctx *gin.Context) {
	conn, err := config.Upgrader.Upgrade(ctx.Writer, ctx.Request, nil)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to upgrade connection"})
		log.Fatal(err.Error())
		return
	}

	defer conn.Close()

	for {
		messageType, _, err := conn.ReadMessage()

		if err != nil {
			log.Fatal(err.Error())
		}

		time.Sleep(3 * time.Second)

		if err := conn.WriteMessage(messageType, []byte("pong")); err != nil {
			log.Fatal(err.Error())
			break
		}
	}
}
