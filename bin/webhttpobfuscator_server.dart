import 'package:webhttpobfuscator_server/client/client.dart';
import 'package:webhttpobfuscator_server/server/server.dart';

const port = 8080;
String payloadEncryptor(String payload) {
  // TODO
  return payload;
}

String payloadDecryptor(String payload) {
  // TODO
  return payload;
}

void main(List<String> arguments) {
  final server = Server(port, (payload) => payloadEncryptor, (payload) => payloadDecryptor);
  server.serve((request) async {
    return await Client.performRequest(request);
  });
}
