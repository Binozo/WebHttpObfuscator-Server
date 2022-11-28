class MalformedRequestException implements Exception {
  String possibleCause;
  MalformedRequestException(this.possibleCause);
}