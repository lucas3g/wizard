// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:result_dart/result_dart.dart';
import 'package:wizard/app/core_module/types/dates_entity.dart';

import 'package:wizard/app/modules/home/submodules/review/domain/entities/review.dart';
import 'package:wizard/app/modules/home/submodules/review/domain/exceptions/review_exception.dart';
import 'package:wizard/app/modules/home/submodules/review/domain/repositories/review_repository.dart';
import 'package:wizard/app/modules/home/submodules/review/infra/adapters/review_adapter.dart';
import 'package:wizard/app/modules/home/submodules/review/infra/datasources/review_datasource.dart';

class ReviewRepository implements IReviewRepository {
  final IReviewDatasource datasource;

  ReviewRepository({
    required this.datasource,
  });

  @override
  Future<Result<bool, IReviewException>> saveReview(Review review) async {
    try {
      final result = await datasource.saveReview(review);

      return result.toSuccess();
    } on IReviewException catch (e) {
      return ReviewException(message: e.message).toFailure();
    } catch (e) {
      return ReviewException(message: e.toString()).toFailure();
    }
  }

  @override
  Future<Result<List<Review>, IReviewException>> getReviewsByClass(
      int classID) async {
    try {
      final result = await datasource.getReviewsByClass(classID);

      final List<Review> list = [];

      for (var review in result) {
        list.add(ReviewAdapter.fromMap(review));
      }

      return list.toSuccess();
    } on IReviewException catch (e) {
      return ReviewException(message: e.message).toFailure();
    } catch (e) {
      return ReviewException(message: e.toString()).toFailure();
    }
  }

  @override
  Future<Result<List<Review>, IReviewException>> getReviewsByClassAndDate(
      int classID, DatesEntity dates) async {
    try {
      final result = await datasource.getReviewsByClassAndDate(classID, dates);

      final List<Review> list = [];

      for (var review in result) {
        list.add(ReviewAdapter.fromMapSearch(review));
      }

      return list.toSuccess();
    } on IReviewException catch (e) {
      return ReviewException(message: e.message).toFailure();
    } catch (e) {
      return ReviewException(message: e.toString()).toFailure();
    }
  }

  @override
  Future<Result<bool, IReviewException>> updateReview(Review review) async {
    try {
      final result = await datasource.updateReview(review);

      return result.toSuccess();
    } on IReviewException catch (e) {
      return ReviewException(message: e.message).toFailure();
    } catch (e) {
      return ReviewException(message: e.toString()).toFailure();
    }
  }
}
