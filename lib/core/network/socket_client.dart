import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../constants/api_endpoints.dart';
import '../constants/app_constant.dart';
import '../storage/local_storage.dart';
import '../utils/logger.dart';

class SocketClient {
  static WebSocketChannel? _channel;
  static StreamController<dynamic>? _controller;

  static Timer? _reconnectTimer;
  static bool _manuallyClosed = false;

  /// 🔌 Connect socket
  static Future<void> connect() async {
    try {
      final token = await LocalStorage.getTokenSync();
      if (token == null) {
        AppLogger.warning("Socket connect skipped: token missing", tag: "SOCKET");
        return;
      }

      final url = ApiEndpoints.socketConnect(token);
      AppLogger.info("Connecting WebSocket → $url", tag: "SOCKET");

      _manuallyClosed = false;
      _channel = WebSocketChannel.connect(Uri.parse(url));

      _controller ??= StreamController.broadcast();

      _channel!.stream.listen(
            (data) {
          AppLogger.debug("WS message → $data", tag: "SOCKET");
          _controller?.add(jsonDecode(data));
        },
        onDone: () {
          AppLogger.warning("WebSocket disconnected", tag: "SOCKET");
          if (!_manuallyClosed) _scheduleReconnect();
        },
        onError: (error) {
          AppLogger.error(
            "WebSocket error",
            error: error,
            tag: "SOCKET",
          );
          if (!_manuallyClosed) _scheduleReconnect();
        },
      );
    } catch (e, s) {
      AppLogger.error(
        "WebSocket connection failed",
        error: e,
        stackTrace: s,
        tag: "SOCKET",
      );
      _scheduleReconnect();
    }
  }

  /// 📤 Send message

  static void send(Map<String, dynamic> payload) {
    if (_channel == null) {
      AppLogger.error("Socket not connected", tag: "SOCKET");
      return;
    }

    final data = jsonEncode(payload);
    _channel!.sink.add(data);

    AppLogger.info("WS sent → $data", tag: "SOCKET");
  }

  /// 📥 Listen messages (use in ViewModel)
  static Stream<dynamic> get stream {
    _controller ??= StreamController.broadcast();
    return _controller!.stream;
  }

  /// 🔁 Auto reconnect
  static void _scheduleReconnect() {
    if (_reconnectTimer != null && _reconnectTimer!.isActive) return;

    AppLogger.info(
      "Reconnecting WebSocket in ${AppConstants.socketReconnectDelaySeconds}s",
      tag: "SOCKET",
    );

    _reconnectTimer = Timer(
      const Duration(seconds: AppConstants.socketReconnectDelaySeconds),
          () {
        connect();
      },
    );
  }

  /// ❌ Disconnect manually (logout / app close)
  static void disconnect() {
    AppLogger.info("WebSocket manually disconnected", tag: "SOCKET");
    _manuallyClosed = true;
    _reconnectTimer?.cancel();
    _channel?.sink.close();
    _channel = null;
  }
}