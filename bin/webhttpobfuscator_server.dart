

import 'package:webhttpobfuscator_server/client/client.dart';
import 'package:webhttpobfuscator_server/server/server.dart';

void main(List<String> arguments) {
  final server = Server(8080, (payload) => payload, (payload) => payload);
  server.serve((request) async {
    return await Client.performRequest(request);
  });
}
