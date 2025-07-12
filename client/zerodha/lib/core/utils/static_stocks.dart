import 'dart:async';
import 'dart:math';
import 'package:zerodha/features/watchlist/presentation/models/stock_model.dart';

class StaticStocks {
  static List<StockModel> staticStockModel = [
    StockModel(
      ticker: "RELIANCE",
      price: 2500,
      change: 0,
      changePct: 0,
      open: 2490,
      high: 2510,
      prevClose: 2495,
      lastUpdated: "",
    ),
    StockModel(
      ticker: "TCS",
      price: 3500,
      change: 0,
      changePct: 0,
      open: 3490,
      high: 3510,
      prevClose: 3495,
      lastUpdated: "",
    ),
    StockModel(
      ticker: "INFY",
      price: 1600,
      change: 0,
      changePct: 0,
      open: 1590,
      high: 1610,
      prevClose: 1595,
      lastUpdated: "",
    ),
    StockModel(
      ticker: "HDFC",
      price: 2800,
      change: 0,
      changePct: 0,
      open: 2790,
      high: 2810,
      prevClose: 2795,
      lastUpdated: "",
    ),
    StockModel(
      ticker: "ICICI",
      price: 950,
      change: 0,
      changePct: 0,
      open: 940,
      high: 960,
      prevClose: 945,
      lastUpdated: "",
    ),
    StockModel(
      ticker: "SBIN",
      price: 600,
      change: 0,
      changePct: 0,
      open: 590,
      high: 610,
      prevClose: 595,
      lastUpdated: "",
    ),
    StockModel(
      ticker: "AXIS",
      price: 1100,
      change: 0,
      changePct: 0,
      open: 1090,
      high: 1110,
      prevClose: 1095,
      lastUpdated: "",
    ),
    StockModel(
      ticker: "KOTAK",
      price: 1800,
      change: 0,
      changePct: 0,
      open: 1790,
      high: 1810,
      prevClose: 1795,
      lastUpdated: "",
    ),
    StockModel(
      ticker: "ITC",
      price: 450,
      change: 0,
      changePct: 0,
      open: 440,
      high: 460,
      prevClose: 445,
      lastUpdated: "",
    ),
    StockModel(
      ticker: "LT",
      price: 2800,
      change: 0,
      changePct: 0,
      open: 2790,
      high: 2810,
      prevClose: 2795,
      lastUpdated: "",
    ),
  ];

  static Stream<List<StockModel>> mockStockStream() async* {
    final random = Random();
    List<StockModel> stocks = List.from(staticStockModel);

    while (true) {
      stocks =
          stocks.map((stock) {
            // Randomly change price by -2 to +2
            double change = (random.nextInt(5) - 2).toDouble();
            double newPrice = (stock.price ?? 0) + change;
            double changePct = ((change / (stock.price ?? 1)) * 100);

            return stock.copyWith(
              price: newPrice,
              change: change,
              changePct: changePct,
              lastUpdated: DateTime.now().toIso8601String(),
            );
          }).toList();

      yield stocks;
      await Future.delayed(const Duration(seconds: 1));
    }
  }
}
