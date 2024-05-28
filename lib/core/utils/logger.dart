library logger;

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

final Logger logger = Logger(
  printer: PrettyPrinter(
    colors: true,
  ),
);

final log = EFLogger();

class EFLogger {
  void d(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (!kDebugMode) return;
    logger.d(message);
  }

  void e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (!kDebugMode) return;
    logger.e(message);
  }

  void i(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (!kDebugMode) return;
    logger.i(
      message,
    );
  }

  void w(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (!kDebugMode) return;
    logger.w(message);
  }

  void v(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (!kDebugMode) return;
    logger.t(message);
  }

  void wtf(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (!kDebugMode) return;
    logger.f(message);
  }
}
