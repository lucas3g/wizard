abstract class IClassException implements Exception {
  final String message;
  final StackTrace? stackTrace;

  const IClassException({
    required this.message,
    this.stackTrace,
  });
}

class ClassException extends IClassException {
  const ClassException({
    required String message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}
