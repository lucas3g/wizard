abstract class IPresenceException implements Exception {
  final String message;
  final StackTrace? stackTrace;

  const IPresenceException({
    required this.message,
    this.stackTrace,
  });
}

class PresenceException extends IPresenceException {
  const PresenceException({
    required String message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}
