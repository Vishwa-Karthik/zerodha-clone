import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fuzzy_bolt/fuzzy_bolt.dart';
import 'package:zerodha/features/watchlist/presentation/models/stock_model.dart';
import 'package:zerodha/core/connection/web_socket_service.dart';

final stockStateProvider =
    StateNotifierProvider<StocksNotifier, AsyncValue<List<StockModel>>>(
      (ref) => StocksNotifier(),
    );

class StocksNotifier extends StateNotifier<AsyncValue<List<StockModel>>> {
  StocksNotifier() : super(const AsyncLoading()) {
    _connectWebSocket();
  }

  final WebSocketService _webSocketService = WebSocketService();
  List<StockModel> _allStocks = [];
  bool _isFiltering = false;

  void _connectWebSocket() {
    state = const AsyncLoading();
    try {
      _webSocketService.connect(
        url:
            kIsWeb ? "ws://localhost:8080/stocks" : 'ws://10.0.2.2:8080/stocks',
        onMessage: (stocks) {
          _allStocks = stocks;

          if (!_isFiltering) {
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
    if (query.isEmpty) {
      _isFiltering = false;
      state = AsyncValue.data(_allStocks);
    } else {
      _isFiltering = true;
      final result = await FuzzyBolt().search(
        dataset: _allStocks.map((e) => e.ticker ?? '').cast<String>().toList(),
        query: query,
      );
      final filteredStocks =
          _allStocks
              .where((stock) => result.contains(stock.ticker?.toLowerCase()))
              .toList();

      state = AsyncValue.data(filteredStocks);
    }
  }

  void retryConnection() {
    _connectWebSocket();
  }

  @override
  void dispose() {
    _webSocketService.dispose();
    super.dispose();
  }
}
