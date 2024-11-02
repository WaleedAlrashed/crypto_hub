import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class PriceService {
  final WebSocketChannel channel;
  PriceService(String symbol)
      : channel = IOWebSocketChannel.connect(
            'wss://stream.binance.com:9443/ws/$symbol@trade');

  Stream get priceStream => channel.stream;
}
