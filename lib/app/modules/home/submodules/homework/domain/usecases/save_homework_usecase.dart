// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:result_dart/result_dart.dart';

import 'package:wizard/app/modules/home/submodules/homework/domain/entities/homework.dart';
import 'package:wizard/app/modules/home/submodules/homework/domain/exceptions/homework_exception.dart';
import 'package:wizard/app/modules/home/submodules/homework/domain/repositories/homework_repository.dart';

abstract class ISaveHomeworkUsecase {
  AsyncResult<bool, IHomeWorkException> call(Homework homework);
}

class SaveHomeworkUsecase extends ISaveHomeworkUsecase {
  final IHomeworkRepository repository;

  SaveHomeworkUsecase({
    required this.repository,
  });

  @override
  AsyncResult<bool, IHomeWorkException> call(Homework homework) {
    return homework
        .validate()
        .mapError<IHomeWorkException>(
            (error) => HomeWorkException(message: error))
        .toAsyncResult()
        .flatMap(repository.saveHomework);
  }
}
