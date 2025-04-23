package models

type StockModel struct {
	Ticker      string  `json:"ticker"`
	Price       float64 `json:"price"`
	Change      float64 `json:"change"`
	ChangePct   float64 `json:"change_pct"`
	Open        float64 `json:"open"`
	High        float64 `json:"high"`
	Low         float64 `json:"low"`
	PrevClose   float64 `json:"prev_close"`
	LastUpdated string  `json:"last_updated"`
}
