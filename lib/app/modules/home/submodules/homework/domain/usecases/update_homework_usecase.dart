import 'package:result_dart/result_dart.dart';

import 'package:wizard/app/modules/home/submodules/homework/domain/entities/homework.dart';
import 'package:wizard/app/modules/home/submodules/homework/domain/exceptions/homework_exception.dart';
import 'package:wizard/app/modules/home/submodules/homework/domain/repositories/homework_repository.dart';

abstract class IUpdateHomeworkUsecase {
  AsyncResult<bool, IHomeWorkException> call(Homework homework);
}

class UpdateHomeworkUsecase extends IUpdateHomeworkUsecase {
  final IHomeworkRepository repository;

  UpdateHomeworkUsecase({
    required this.repository,
  });

  @override
  AsyncResult<bool, IHomeWorkException> call(Homework homework) {
    return homework
        .validate()
        .mapError<IHomeWorkException>(
            (error) => HomeWorkException(message: error))
        .toAsyncResult()
        .flatMap(repository.updateHomework);
  }
}
