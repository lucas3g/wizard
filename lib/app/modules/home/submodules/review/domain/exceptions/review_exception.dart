abstract class IReviewException implements Exception {
  final String message;
  final StackTrace? stackTrace;

  const IReviewException({
    required this.message,
    this.stackTrace,
  });
}

class ReviewException extends IReviewException {
  const ReviewException({
    required String message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}
