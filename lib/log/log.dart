import 'package:intl/intl.dart';

class Log {
  static DateFormat _dateFormatter = DateFormat("HH:mm:ss");

  static void info(String message) {
    final now = DateTime.now();
    final time = _dateFormatter.format(now);
    print("[$time][INFO]: $message");
  }

  static void warning(String message) {
    final now = DateTime.now();
    final time = _dateFormatter.format(now);
    print("[$time][WARN]: $message");
  }

  static void debug(String message) {
    const bool prod = bool.fromEnvironment('dart.vm.product');
    if(prod) {
      return;
    }
    final now = DateTime.now();
    final time = _dateFormatter.format(now);
    print("[$time][DEBUG]: $message");
  }


}