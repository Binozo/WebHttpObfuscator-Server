import 'package:webhttpobfuscator_server/client/client.dart';
import 'package:webhttpobfuscator_server/server/server.dart';

const port = 9268;
String payloadEncryptor(String payload) {
  // TODO
  return payload;
}

String payloadDecryptor(String payload) {
  // TODO
  return payload;
}

void main(List<String> arguments) {
  final server = Server(port, (payload) => payloadEncryptor(payload), (payload) => payloadDecryptor(payload));
  server.serve((request) async {
    return await Client.performRequest(request);
  });
}
