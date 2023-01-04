// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:result_dart/result_dart.dart';

import 'package:wizard/app/modules/home/submodules/review/domain/entities/review.dart';
import 'package:wizard/app/modules/home/submodules/review/domain/exceptions/review_exception.dart';
import 'package:wizard/app/modules/home/submodules/review/domain/repositories/review_repository.dart';

abstract class ISaveReviewUsecase {
  AsyncResult<bool, IReviewException> call(Review review);
}

class SaveReviewUsecase extends ISaveReviewUsecase {
  final IReviewRepository repository;

  SaveReviewUsecase({
    required this.repository,
  });

  @override
  AsyncResult<bool, IReviewException> call(Review review) {
    return review
        .validate()
        .mapError<IReviewException>((error) => ReviewException(message: error))
        .toAsyncResult()
        .flatMap(repository.saveReview);
  }
}
