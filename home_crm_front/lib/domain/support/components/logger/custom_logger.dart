import 'package:logger/logger.dart';

class CustomLogger {
  static var logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      // не печатать стек вызовов
      errorMethodCount: 5,
      // но печатать его при ошибках
      lineLength: 80,
      // ширина рамки
      colors: true,
      // цветные логи
      printEmojis: true,
      // использовать эмодзи
      noBoxingByDefault: true,
      // dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,      // время события
    ),
  );

  static CustomBufferLogger buffer() {
    return CustomBufferLogger();
  }
}

class CustomBufferLogger {
  final logBuffer = <String>[];

  void add(String message) {
    if (logBuffer.isEmpty) {
      logBuffer.add('🔄 $message');
    } else {
      logBuffer.add('  ├─ $message');
    }
  }

  void print(
    Level level, {
    String? message,
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (message != null) this.add(message);
    CustomLogger.logger.log(
      level,
      logBuffer.join('\n'),
      time: time,
      error: error,
      stackTrace: stackTrace,
    );
  }
}
