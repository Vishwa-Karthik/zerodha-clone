import 'dart:convert';
import 'package:flutter/material.dart' show VoidCallback;
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:zerodha/features/watchlist/presentation/models/stock_model.dart';

class WebSocketService {
  late final WebSocketChannel _channel;

  void connect({
    required String url,
    required Function(List<StockModel>) onMessage,
    required Function(dynamic error) onError,
    required VoidCallback onDone,
  }) {
    _channel = WebSocketChannel.connect(Uri.parse(url));

    _channel.stream.listen(
      (message) {
        try {
          final jsonList = jsonDecode(message);
          final List<StockModel> stocks =
              (jsonList as List<dynamic>)
                  .map(
                    (jsonItem) =>
                        StockModel.fromJson(jsonItem as Map<String, dynamic>),
                  )
                  .toList();
          onMessage(stocks);
        } catch (e) {
          onError(e);
        }
      },
      onError: onError,
      onDone: onDone,
    );
  }

  void dispose() {
    _channel.sink.add(jsonEncode({"action": "close"}));
    _channel.sink.close();
  }
}
