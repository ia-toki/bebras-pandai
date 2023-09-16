import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

/// App logger, you can comment out specific log level in purpose.
class AppLogger {
  /// Log a message at level [Level.verbose].
  static void v(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (kDebugMode) Logger().v(message, error, stackTrace);
  }

  /// Log a message at level [Level.debug].
  static void d(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (kDebugMode) Logger().d(message, error, stackTrace);
  }

  /// Log a message at level [Level.info].
  static void i(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (kDebugMode) Logger().i(message, error, stackTrace);
  }

  /// Log a message at level [Level.warning].
  static void w(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (kDebugMode) Logger().w(message, error, stackTrace);
  }

  /// Log a message at level [Level.error].
  static void e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (kDebugMode) Logger().e(message, error, stackTrace);
  }

  /// Log a message at level [Level.wtf].
  static void wtf(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (kDebugMode) Logger().wtf(message, error, stackTrace);
  }
}
