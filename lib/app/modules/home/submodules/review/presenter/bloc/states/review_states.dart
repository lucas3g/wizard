// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class ReviewStates {}

class InitialReview extends ReviewStates {}

class LoadingReview extends ReviewStates {}

class SuccessSaveReview extends ReviewStates {}

class ErrorSaveReview extends ReviewStates {
  final String message;

  ErrorSaveReview({
    required this.message,
  });
}
