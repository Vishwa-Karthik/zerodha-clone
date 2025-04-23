import 'package:equatable/equatable.dart';

class StockModel extends Equatable {
  final String? ticker;
  final double? price;
  final double? change;
  final double? changePct;
  final double? open;
  final double? high;
  final double? prevClose;
  final String? lastUpdated;

  const StockModel({
    this.ticker,
    this.price,
    this.change,
    this.changePct,
    this.open,
    this.high,
    this.prevClose,
    this.lastUpdated,
  });

  @override
  List<Object?> get props {
    return [
      ticker,
      price,
      change,
      changePct,
      open,
      high,
      prevClose,
      lastUpdated,
    ];
  }

  StockModel copyWith({
    String? ticker,
    double? price,
    double? change,
    double? changePct,
    double? open,
    double? high,
    double? prevClose,
    String? lastUpdated,
  }) {
    return StockModel(
      ticker: ticker ?? this.ticker,
      price: price ?? this.price,
      change: change ?? this.change,
      changePct: changePct ?? this.changePct,
      open: open ?? this.open,
      high: high ?? this.high,
      prevClose: prevClose ?? this.prevClose,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'ticker': ticker,
      'price': price,
      'change': change,
      'change_pct': changePct,
      'open': open,
      'high': high,
      'prev_close': prevClose,
      'last_updated': lastUpdated,
    };
  }

  factory StockModel.fromJson(Map<String, dynamic> map) {
    return StockModel(
      ticker: map['ticker'] as String?,
      price: (map['price'] as num?)?.toDouble(),
      change: (map['change'] as num?)?.toDouble(),
      changePct: (map['change_pct'] as num?)?.toDouble(),
      open: (map['open'] as num?)?.toDouble(),
      high: (map['high'] as num?)?.toDouble(),
      prevClose: (map['prev_close'] as num?)?.toDouble(),
      lastUpdated: map['last_updated'] as String?,
    );
  }
}
