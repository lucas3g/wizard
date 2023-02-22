import 'package:result_dart/result_dart.dart';
import 'package:wizard/app/core_module/types/dates_entity.dart';
import 'package:wizard/app/modules/home/submodules/review/domain/entities/review.dart';
import 'package:wizard/app/modules/home/submodules/review/domain/exceptions/review_exception.dart';
import 'package:wizard/app/modules/home/submodules/review/domain/repositories/review_repository.dart';

abstract class IGetReviewByClassAndDateUseCase {
  AsyncResult<List<Review>, IReviewException> call(
      int classID, DatesEntity dates);
}

class GetReviewByClassAndDateUseCase
    implements IGetReviewByClassAndDateUseCase {
  final IReviewRepository repository;

  GetReviewByClassAndDateUseCase({required this.repository});

  @override
  AsyncResult<List<Review>, IReviewException> call(
      int classID, DatesEntity dates) {
    return repository.getReviewsByClassAndDate(classID, dates);
  }
}
