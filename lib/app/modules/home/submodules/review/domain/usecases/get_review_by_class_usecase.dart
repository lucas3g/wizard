// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:result_dart/result_dart.dart';

import 'package:wizard/app/modules/home/submodules/review/domain/entities/review.dart';
import 'package:wizard/app/modules/home/submodules/review/domain/exceptions/review_exception.dart';
import 'package:wizard/app/modules/home/submodules/review/domain/repositories/review_repository.dart';

abstract class IGetReviewsByClassUsecase {
  AsyncResult<List<Review>, IReviewException> call(String classID);
}

class GetReviewsByClassUsecase extends IGetReviewsByClassUsecase {
  final IReviewRepository repository;

  GetReviewsByClassUsecase({
    required this.repository,
  });

  @override
  AsyncResult<List<Review>, IReviewException> call(String classID) {
    return repository.getReviewsByClass(classID);
  }
}
