import 'package:wizard/app/core_module/types/dates_entity.dart';
import 'package:wizard/app/modules/home/submodules/review/domain/entities/review.dart';

abstract class IReviewDatasource {
  Future<bool> saveReview(Review review);
  Future<bool> updateReview(Review review);
  Future<List> getReviewsByClass(int classID);
  Future<List> getReviewsByClassAndDate(int classID, DatesEntity dates);
}
