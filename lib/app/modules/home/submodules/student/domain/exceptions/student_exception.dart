abstract class IStudentException implements Exception {
  final String message;
  final StackTrace? stackTrace;

  const IStudentException({
    required this.message,
    this.stackTrace,
  });
}

class StudentException extends IStudentException {
  const StudentException({
    required String message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}
