// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:result_dart/result_dart.dart';

import 'package:wizard/app/modules/home/submodules/review/domain/entities/review.dart';
import 'package:wizard/app/modules/home/submodules/review/domain/exceptions/review_exception.dart';
import 'package:wizard/app/modules/home/submodules/review/domain/repositories/review_repository.dart';
import 'package:wizard/app/modules/home/submodules/review/infra/datasources/review_datasource.dart';

class ReviewRepository implements IReviewRepository {
  final IReviewDatasource datasource;

  ReviewRepository({
    required this.datasource,
  });

  @override
  AsyncResult<bool, IReviewException> saveReview(Review review) {
    return datasource
        .saveReview(review)
        .mapError<IReviewException>(
            (error) => ReviewException(message: error.message))
        .flatMap((success) => Success(success));
  }
}
