// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:result_dart/result_dart.dart';

import 'package:wizard/app/modules/home/submodules/homework/domain/entities/homework.dart';
import 'package:wizard/app/modules/home/submodules/homework/domain/exceptions/homework_exception.dart';
import 'package:wizard/app/modules/home/submodules/homework/domain/repositories/homework_repository.dart';

abstract class IGetHomeworksByClassUsecase {
  AsyncResult<List<Homework>, IHomeWorkException> call(String classID);
}

class GetHomeworksByClassUsecase extends IGetHomeworksByClassUsecase {
  final IHomeworkRepository repository;

  GetHomeworksByClassUsecase({
    required this.repository,
  });

  @override
  AsyncResult<List<Homework>, IHomeWorkException> call(String classID) {
    return repository.getHomeworksByClass(classID);
  }
}
