import 'package:flutter/foundation.dart';

// ignore_for_file: constant_identifier_names

enum LogLevel { ERROR, WARN, INFO, DEBUG, SUCCESS }

class LogContext {
  final String module;
  final String? method;
  final String? userId;
  final String? requestId;
  final int? duration;
  final dynamic metadata;

  LogContext({
    required this.module,
    this.method,
    this.userId,
    this.requestId,
    this.duration,
    this.metadata,
  });

  LogContext copyWith({
    String? module,
    String? method,
    String? userId,
    String? requestId,
    int? duration,
    dynamic metadata,
  }) {
    return LogContext(
      module: module ?? this.module,
      method: method ?? this.method,
      userId: userId ?? this.userId,
      requestId: requestId ?? this.requestId,
      duration: duration ?? this.duration,
      metadata: metadata ?? this.metadata,
    );
  }
}

class JDRepoConsole {
  static const String _prefix = 'jodija - repo';

  static bool _isDevelopment() {
    return kDebugMode;
  }

  static bool _isProduction() {
    return kReleaseMode;
  }

  static String _formatTimestamp() {
    final now = DateTime.now();
    final year = now.year.toString().substring(now.year.toString().length - 2);
    final month = now.month.toString().padLeft(2, '0');
    final day = now.day.toString().padLeft(2, '0');
    final hours12 = now.hour % 12 == 0 ? 12 : now.hour % 12;
    final hours = hours12.toString().padLeft(2, '0');
    final minutes = now.minute.toString().padLeft(2, '0');
    final seconds = now.second.toString().padLeft(2, '0');
    final ampm = now.hour >= 12 ? 'PM' : 'AM';

    return '$year-$month-$day:$hours:$minutes:$seconds:$ampm';
  }

  // ANSI Color codes
  static const String _reset = '\x1B[0m';
  static const String _red = '\x1B[31m';
  static const String _green = '\x1B[32m';
  static const String _yellow = '\x1B[33m';
  static const String _blue = '\x1B[34m';
  static const String _cyan = '\x1B[36m';
  static const String _gray = '\x1B[90m';
  static const String _white = '\x1B[37m';

  static String _formatDuration(int? duration) {
    return duration != null ? '$_cyan($duration ms)$_reset' : '';
  }

  static String _formatContext(LogContext context) {
    List<String> parts = [];
    if (context.module.isNotEmpty) {
      parts.add('$_cyan[${context.module}]$_reset');
    }
    if (context.method != null) {
      parts.add('$_blue${context.method}$_reset');
    }
    if (context.userId != null) {
      parts.add('${_white}User: ${context.userId}$_reset');
    }
    return parts.join(' ');
  }

  static bool _shouldLog(LogLevel level) {
    if (_isDevelopment()) return true;
    if (_isProduction()) {
      return level == LogLevel.ERROR || level == LogLevel.WARN;
    }
    return true;
  }

  static void _logToConsole(LogLevel level, dynamic message,
      {LogContext? context}) {
    if (!_shouldLog(level)) return;

    final timestamp = _formatTimestamp();
    final contextStr = context != null ? _formatContext(context) : '';
    final durationStr =
        context?.duration != null ? _formatDuration(context!.duration) : '';

    String levelIcon = '';
    String coloredMessage = message.toString();

    switch (level) {
      case LogLevel.ERROR:
        levelIcon = '❌';
        coloredMessage = '$_red$coloredMessage$_reset';
        break;
      case LogLevel.WARN:
        levelIcon = '⚠️';
        coloredMessage = '$_yellow$coloredMessage$_reset';
        break;
      case LogLevel.INFO:
        levelIcon = 'ℹ️';
        coloredMessage = '$_blue$coloredMessage$_reset';
        break;
      case LogLevel.DEBUG:
        levelIcon = '🔧';
        coloredMessage = '$_gray$coloredMessage$_reset';
        break;
      case LogLevel.SUCCESS:
        levelIcon = '✅';
        coloredMessage = '$_green$coloredMessage$_reset';
        break;
    }

    final fullMessage =
        '$_gray[$_prefix]$_reset $levelIcon $timestamp $contextStr $coloredMessage $durationStr'
            .trim();

    debugPrint(fullMessage);

    if (_isDevelopment() && context?.metadata != null) {
      debugPrint('$_gray    Metadata: ${context!.metadata}$_reset');
    }
  }

  // Public static methods
  static void error(dynamic message, {LogContext? context}) =>
      _logToConsole(LogLevel.ERROR, message, context: context);
  static void warn(dynamic message, {LogContext? context}) =>
      _logToConsole(LogLevel.WARN, message, context: context);
  static void info(dynamic message, {LogContext? context}) =>
      _logToConsole(LogLevel.INFO, message, context: context);
  static void debug(dynamic message, {LogContext? context}) =>
      _logToConsole(LogLevel.DEBUG, message, context: context);
  static void success(dynamic message, {LogContext? context}) =>
      _logToConsole(LogLevel.SUCCESS, message, context: context);

  // Convenience methods
  static void request(String method, String endpoint, {LogContext? context}) {
    info('📝 $method $endpoint request received',
        context: (context ?? LogContext(module: 'API')).copyWith(
          method: '$method $endpoint',
        ));
  }

  static void response(int statusCode, String message, {LogContext? context}) {
    final level = statusCode >= 400
        ? LogLevel.ERROR
        : statusCode >= 300
            ? LogLevel.WARN
            : LogLevel.SUCCESS;
    _logToConsole(level, '$statusCode - $message',
        context: context ?? LogContext(module: 'API'));
  }

  static void operation(String operation, String status,
      {LogContext? context}) {
    final icons = {'started': '🚀', 'completed': '✅', 'failed': '❌'};
    final level = status == 'failed'
        ? LogLevel.ERROR
        : status == 'completed'
            ? LogLevel.SUCCESS
            : LogLevel.INFO;
    _logToConsole(level, '${icons[status] ?? ''} $operation $status',
        context: context ?? LogContext(module: 'System'));
  }

  static void performance(String operation, int duration,
      {LogContext? context}) {
    final level = duration > 5000 ? LogLevel.WARN : LogLevel.DEBUG;
    _logToConsole(level, '⏱️ $operation completed',
        context: (context ?? LogContext(module: 'Performance')).copyWith(
          duration: duration,
        ));
  }

  static void initialization(String module) {
    success('Initialized successfully', context: LogContext(module: module));
  }

  static void productInfo(String productName, String action,
      {LogContext? context}) {
    final message = '📦 Product: $productName - $action';
    if (_isProduction()) {
      debugPrint('${_formatTimestamp()} $message');
    } else {
      info(message, context: context ?? LogContext(module: 'Product'));
    }
  }

  static void userActivity(String userId, String activity,
      {LogContext? context}) {
    info('👤 User activity: $activity',
        context: (context ?? LogContext(module: 'User')).copyWith(
          userId: userId,
        ));
  }

  static void validation(String field, String errorMsg, {LogContext? context}) {
    warn('Validation failed for $field: $errorMsg',
        context: context ?? LogContext(module: 'Validation'));
  }

  static void database(String operation, String collection,
      {LogContext? context}) {
    debug('🗄️ Database $operation on $collection',
        context: context ?? LogContext(module: 'Database'));
  }

  static void warning(String method,
      {String? alternative, LogContext? context}) {
    final altMessage = alternative != null ? ' Use $alternative instead.' : '';
    warn('⚠️ Deprecated method: $method.$altMessage',
        context: context ?? LogContext(module: 'Deprecation'));
  }
}

void jdRepoConsole(dynamic message, {LogContext? context, LogLevel level = LogLevel.DEBUG}) {
  JDRepoConsole.debug(message, context: context);
}

void jdRepoConsol(dynamic message, {LogContext? context, LogLevel level = LogLevel.DEBUG}) {
  JDRepoConsole.debug(message, context: context);
}
