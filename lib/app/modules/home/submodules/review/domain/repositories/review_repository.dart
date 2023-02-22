import 'package:result_dart/result_dart.dart';
import 'package:wizard/app/core_module/types/dates_entity.dart';
import 'package:wizard/app/modules/home/submodules/review/domain/entities/review.dart';
import 'package:wizard/app/modules/home/submodules/review/domain/exceptions/review_exception.dart';

abstract class IReviewRepository {
  Future<Result<bool, IReviewException>> saveReview(Review review);
  Future<Result<bool, IReviewException>> updateReview(Review review);
  Future<Result<List<Review>, IReviewException>> getReviewsByClass(int classID);
  Future<Result<List<Review>, IReviewException>> getReviewsByClassAndDate(
      int classID, DatesEntity dates);
}
