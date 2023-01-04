import 'package:result_dart/result_dart.dart';
import 'package:wizard/app/modules/home/submodules/review/domain/entities/review.dart';
import 'package:wizard/app/modules/home/submodules/review/domain/exceptions/review_exception.dart';

abstract class IReviewDatasource {
  AsyncResult<bool, IReviewException> saveReview(Review review);
}
