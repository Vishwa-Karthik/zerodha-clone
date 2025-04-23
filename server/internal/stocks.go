package internal

import (
	"encoding/json"
	"log/slog"
	"sync"
	"time"

	"github.com/Vishwa-Karthik/zerodha/config"
	"github.com/Vishwa-Karthik/zerodha/models"
	"github.com/Vishwa-Karthik/zerodha/utils"
	"github.com/gin-gonic/gin"
	"github.com/gorilla/websocket"
)

var (
	clients   = make(map[*websocket.Conn]bool)
	clientsMu sync.Mutex
)

// WebSocket endpoint
func StocksStream(c *gin.Context) {
	conn, err := config.Upgrader.Upgrade(c.Writer, c.Request, nil)
	if err != nil {
		slog.Error("WebSocket upgrade failed", slog.String("error", err.Error()))
		return
	}

	clientsMu.Lock()
	clients[conn] = true
	clientsMu.Unlock()

	slog.Info("New WebSocket client connected")

	// Don't block here, just listen
	go handleConnection(conn)
}

// Clean disconnect
func handleConnection(conn *websocket.Conn) {
	defer func() {
		clientsMu.Lock()
		delete(clients, conn)
		clientsMu.Unlock()
		conn.Close()
		slog.Warn("WebSocket client disconnected")
	}()

	// Idle reader just to detect disconnects
	for {
		if _, _, err := conn.NextReader(); err != nil {
			break
		}
	}
}

// Broadcasts data every second
func StartStockBroadcaster() {
	ticker := time.NewTicker(1 * time.Second)
	largeChangeTicker := time.NewTicker(1 * time.Minute)
	defer ticker.Stop()

	stocks := utils.GenerateRandomStocks()

	for {
		select {
		case <-ticker.C:
			stocks = utils.ApplySmallDelta(stocks)
			broadcast(stocks)

		case <-largeChangeTicker.C:
			stocks = utils.ApplyLargeSpike(stocks)
			broadcast(stocks)
		}
	}
}

func broadcast(stocks []models.StockModel) {
	data, err := json.Marshal(stocks)
	if err != nil {
		slog.Error("Failed to encode stock data", slog.String("error", err.Error()))
		return
	}

	clientsMu.Lock()
	for conn := range clients {
		if err := conn.WriteMessage(websocket.TextMessage, data); err != nil {
			slog.Warn("Failed to send to client", slog.String("error", err.Error()))
			conn.Close()
			delete(clients, conn)
		}
	}
	clientsMu.Unlock()
}
