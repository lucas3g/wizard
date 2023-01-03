abstract class IHomeWorkException implements Exception {
  final String message;
  final StackTrace? stackTrace;

  const IHomeWorkException({
    required this.message,
    this.stackTrace,
  });
}

class HomeWorkException extends IHomeWorkException {
  const HomeWorkException({
    required String message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}
