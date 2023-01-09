abstract class IReportException implements Exception {
  final String message;
  final StackTrace? stackTrace;

  const IReportException({
    required this.message,
    this.stackTrace,
  });
}

class ReportException extends IReportException {
  const ReportException({
    required String message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}
