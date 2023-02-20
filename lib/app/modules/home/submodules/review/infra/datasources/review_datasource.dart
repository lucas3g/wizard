import 'package:wizard/app/modules/home/submodules/review/domain/entities/review.dart';

abstract class IReviewDatasource {
  Future<bool> saveReview(Review review);
  Future<List> getReviewsByClass(int classID);
  Future<List> getReviewsByClassAndDate(int classID, String date);
}
