import 'package:encrypt/encrypt.dart';
import 'package:intl/intl.dart';

import 'package:webhttpobfuscator_server/client/client.dart';
import 'package:webhttpobfuscator_server/server/server.dart';

const port = 9268;
final format = DateFormat("dd.MM.yyyy.MM.dd.MM.yyyy.dd.MM.d");
Future<String> payloadEncryptor(String payload) async {
  final now = DateTime.now();
  final key = Key.fromUtf8(format.format(now));
  final encrypter = Encrypter(AES(key));
  final encrypted = encrypter.encrypt(payload, iv: IV.fromLength(16));
  return encrypted.base64;
}

Future<String> payloadDecryptor(String payload) async {
  final now = DateTime.now();
  print("Key: ${format.format(now)}");
  final key = Key.fromUtf8(format.format(now));
  final encrypter = Encrypter(AES(key));
  final decrypted = encrypter.decrypt64(payload, iv: IV.fromLength(16));
  return decrypted;
}

void main(List<String> arguments) {
  final server = Server(port, (payload) => payloadEncryptor(payload),
      (payload) => payloadDecryptor(payload));
  server.serve((request) async {
    return await Client.performRequest(request);
  });
}
