import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_web_socket/shelf_web_socket.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:webhttpobfuscator_server/extensions/response_extension.dart';
import 'package:webhttpobfuscator_server/log/log.dart';

class Server {
  final Function(String) _payloadEncryptor;
  final Function(String) _payloadDecryptor;
  final int _port;
  HttpServer? _websocketServer;

  Server(this._port, this._payloadEncryptor, this._payloadDecryptor);

  void serve(Function(String) handleRequestCallback) async {
    var handler = webSocketHandler((WebSocketChannel webSocket) {
      final stream = webSocket.stream.listen((message) async {
        // Read encrypted json payload
        final String encryptedPayload = message;
        Log.debug("Received payload");

        // Trying to decrypt it...
        String decrypted = "";

        try {
          Log.debug("Trying to decrypt payload...");
          decrypted = _payloadDecryptor(encryptedPayload);
        } catch (e) {
          Log.warning("Couldn't decrypt payload. May be malformed. Disconnecting...");
          webSocket.sink.close();
          return;
        }

        Log.debug("Processing request...");
        // Process the request and send the payload back to the client
        final rawResult = await handleRequestCallback(decrypted);
        if(rawResult is String) {
          // An error occurred
          // close connection
          webSocket.sink.add(_payloadEncryptor(rawResult));
          webSocket.sink.close();
          Log.debug("An error occurred while proceeding request: $rawResult");
          return;
        }
        final Response result = rawResult;

        // Convert Response Object to Json
        final converted = jsonEncode(result.convertToJson());

        // Encrypt it again
        final String encrypted = _payloadEncryptor(converted);

        // Send it back and close connection
        webSocket.sink.add(encrypted);
        webSocket.sink.close();
        Log.debug("Successfully processed request. Stream closed.");
      });
    });

    _websocketServer = await shelf_io.serve(handler, InternetAddress.anyIPv4, _port);
    Log.info("Serving Websocket on Port $_port");
    Log.info("Connect your client to ws://${_websocketServer!.address.host}:$_port");
  }

  void shutdown() async {
    await _websocketServer?.close();
  }
}