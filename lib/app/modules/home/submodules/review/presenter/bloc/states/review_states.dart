// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:wizard/app/modules/home/submodules/review/domain/entities/review.dart';

abstract class ReviewStates {}

class InitialReview extends ReviewStates {}

class LoadingReview extends ReviewStates {}

class SuccessSaveReview extends ReviewStates {}

class SuccessUpdateReview extends ReviewStates {}

class SuccessGetReviewsByClass extends ReviewStates {
  final List<Review> reviews;

  SuccessGetReviewsByClass({
    required this.reviews,
  });
}

class SuccessGetReviewsByClassAndDate extends ReviewStates {
  final List<Review> reviews;

  SuccessGetReviewsByClassAndDate({
    required this.reviews,
  });
}

class ErrorReview extends ReviewStates {
  final String message;

  ErrorReview({
    required this.message,
  });
}
