import 'package:equatable/equatable.dart';
import 'package:zerodha/features/watchlist/presentation/models/stock_model.dart';

abstract class StockState extends Equatable {
  @override
  List<Object?> get props => [];
}

class StockLoading extends StockState {
  @override
  List<Object?> get props => [];
}

class StockSuccess extends StockState {
  final List<StockModel> stocks;

  StockSuccess(this.stocks);
  @override
  List<Object?> get props => [stocks];
}

class StockError extends StockState {
  final String message;

  StockError(this.message);
  @override
  List<Object?> get props => [message];
}


// import 'package:zerodha/features/watchlist/data/models/stock_model.dart';

// abstract class StockState {
//   T when<T>({
//     required T Function() loading,
//     required T Function(String message) error,
//     required T Function(List<StockModel> stocks) success,
//   });
// }

// class StockLoading extends StockState {
//   @override
//   T when<T>({
//     required T Function() loading,
//     required T Function(String message) error,
//     required T Function(List<StockModel> stocks) success,
//   }) {
//     return loading();
//   }
// }

// class StockError extends StockState {
//   final String message;

//   StockError(this.message);

//   @override
//   T when<T>({
//     required T Function() loading,
//     required T Function(String message) error,
//     required T Function(List<StockModel> stocks) success,
//   }) {
//     return error(message);
//   }
// }

// class StockSuccess extends StockState {
//   final List<StockModel> stocks;

//   StockSuccess(this.stocks);

//   @override
//   T when<T>({
//     required T Function() loading,
//     required T Function(String message) error,
//     required T Function(List<StockModel> stocks) success,
//   }) {
//     return success(stocks);
//   }
// }
