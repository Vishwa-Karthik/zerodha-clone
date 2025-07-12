import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fuzzy_bolt/fuzzy_bolt.dart';
import 'package:zerodha/core/connection/web_socket_service.dart';
import 'package:zerodha/core/constants/app_constant.dart';
import 'package:zerodha/core/utils/static_stocks.dart';
import 'package:zerodha/features/watchlist/presentation/models/stock_model.dart';

final stockStateProvider =
    StateNotifierProvider<StocksNotifier, AsyncValue<List<StockModel>>>(
      (ref) => StocksNotifier(),
    );

class StocksNotifier extends StateNotifier<AsyncValue<List<StockModel>>> {
  StocksNotifier() : super(const AsyncLoading()) {
    if (kIsWeb) {
      mockConnectWebSocket();
    } else {
      _connectWebSocket();
    }
  }

  final WebSocketService _webSocketService = WebSocketService();
  List<StockModel> _allStocks = [];
  List<StockModel> _filteredStocks = [];
  bool _isFiltering = false;
  String _currentQuery = '';

  void mockConnectWebSocket() async {
    try {
      state = const AsyncLoading();
      // Simulate a delay to mimic real-time data fetching
      await Future.delayed(const Duration(seconds: 2));

      await for (final stocks in StaticStocks.mockStockStream()) {
        _allStocks = stocks;
      

      if (_isFiltering) {
        final result = await FuzzyBolt().search(
          dataset:
              stocks.map((e) => e.ticker ?? '').cast<String>().toList(),
          query: _currentQuery,
        );
        _filteredStocks =
            stocks
                .where((stock) => result.contains(stock.ticker?.toLowerCase()))
                .toList();
        state = AsyncValue.data(_filteredStocks);
      } else {
        state = AsyncValue.data(stocks);
      }
    }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  void _connectWebSocket() {
    state = const AsyncLoading();
    try {
      _webSocketService.connect(
        url: AppConstant.kEmulatorLocalHost,
        onMessage: (stocks) async {
          _allStocks = stocks;

          if (_isFiltering) {
            // Apply the current query to the new data
            final result = await FuzzyBolt().search(
              dataset:
                  _allStocks.map((e) => e.ticker ?? '').cast<String>().toList(),
              query: _currentQuery,
            );
            _filteredStocks =
                _allStocks
                    .where(
                      (stock) => result.contains(stock.ticker?.toLowerCase()),
                    )
                    .toList();
            state = AsyncValue.data(_filteredStocks);
          } else {
            state = AsyncValue.data(_allStocks);
          }
        },
        onError: (error) {
          state = AsyncValue.error(error, StackTrace.current);
        },
        onDone: () {
          state = AsyncValue.error(
            'Web Socket Connection Closed',
            StackTrace.current,
          );
        },
      );
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> filterStocks(String query) async {
    _currentQuery = query;
    if (query.isEmpty) {
      _isFiltering = false;
      state = AsyncValue.data(_allStocks);
    } else {
      _isFiltering = true;
      final result = await FuzzyBolt().search(
        dataset: _allStocks.map((e) => e.ticker ?? '').cast<String>().toList(),
        query: query,
      );
      _filteredStocks =
          _allStocks
              .where((stock) => result.contains(stock.ticker?.toLowerCase()))
              .toList();

      state = AsyncValue.data(_filteredStocks);
    }
  }

  void retryConnection() => _connectWebSocket();

  @override
  void dispose() {
    _webSocketService.dispose();
    super.dispose();
  }
}
