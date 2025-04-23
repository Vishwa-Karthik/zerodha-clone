package utils

import (
	"math/rand"
	"time"

	"github.com/Vishwa-Karthik/zerodha/models"
)

// List of selected NIFTY 50 tickers
var tickers = []string{
	"RELIANCE", "TCS", "INFY", "HDFCBANK", "ICICIBANK", "HINDUNILVR", "KOTAKBANK",
	"LT", "SBIN", "AXISBANK", "BAJFINANCE", "ITC", "HCLTECH", "WIPRO", "BHARTIARTL",
	"MARUTI", "SUNPHARMA", "TITAN", "ULTRACEMCO", "GRASIM",
}

// ApplySmallDelta updates stocks with small price changes
func ApplySmallDelta(stocks []models.StockModel) []models.StockModel {
	for i := range stocks {
		delta := (rand.Float64() - 0.5) * 4 // -2 to +2
		stocks[i].Price += delta
		stocks[i].Change = delta
		stocks[i].ChangePct = (delta / stocks[i].Price) * 100
		stocks[i].LastUpdated = time.Now().Format(time.RFC3339)
	}
	return stocks
}

// ApplyLargeSpike adds a larger change (±10% random)
func ApplyLargeSpike(stocks []models.StockModel) []models.StockModel {
	for i := range stocks {
		multiplier := 1 + ((rand.Float64() - 0.5) * 0.2) // ±10%
		oldPrice := stocks[i].Price
		stocks[i].Price *= multiplier
		stocks[i].Change = stocks[i].Price - oldPrice
		stocks[i].ChangePct = ((stocks[i].Price - oldPrice) / oldPrice) * 100
		stocks[i].LastUpdated = time.Now().Format(time.RFC3339)
	}
	return stocks
}

// GenerateStockData creates a random stock entry for a given ticker
func GenerateStockData(ticker string) models.StockModel {
	basePrice := rand.Float64()*1000 + 500 // Base price between 500-1500
	change := (rand.Float64() - 0.5) * 10  // Small fluctuation (-5 to +5)
	open := basePrice + (rand.Float64()-0.5)*20
	high := open + rand.Float64()*10
	low := open - rand.Float64()*10
	prevClose := basePrice + (rand.Float64()-0.5)*10

	return models.StockModel{
		Ticker:      ticker,
		Price:       basePrice + change,
		Change:      change,
		ChangePct:   (change / basePrice) * 100,
		Open:        open,
		High:        high,
		Low:         low,
		PrevClose:   prevClose,
		LastUpdated: time.Now().Format(time.RFC3339),
	}
}

// GenerateRandomStocks generates stock data for all predefined tickers
func GenerateRandomStocks() []models.StockModel {
	var stocks []models.StockModel
	for _, ticker := range tickers {
		stocks = append(stocks, GenerateStockData(ticker))
	}
	return stocks
}
