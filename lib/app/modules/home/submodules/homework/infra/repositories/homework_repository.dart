// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:result_dart/result_dart.dart';

import 'package:wizard/app/modules/home/submodules/homework/domain/entities/homework.dart';
import 'package:wizard/app/modules/home/submodules/homework/domain/exceptions/homework_exception.dart';
import 'package:wizard/app/modules/home/submodules/homework/domain/repositories/homework_repository.dart';
import 'package:wizard/app/modules/home/submodules/homework/infra/datasources/homework_datasource.dart';

class HomeworkRepository implements IHomeworkRepository {
  final IHomeworkDatasource datasource;

  HomeworkRepository({
    required this.datasource,
  });

  @override
  AsyncResult<bool, IHomeWorkException> saveHomework(Homework homework) {
    return datasource
        .saveHomework(homework)
        .mapError<IHomeWorkException>(
            (error) => HomeWorkException(message: error.message))
        .flatMap((success) => Success(success));
  }

  @override
  AsyncResult<List<Homework>, IHomeWorkException> getHomeworksByClass(
      String classID) {
    return datasource
        .getHomeworksByClass(classID)
        .mapError<IHomeWorkException>(
            (error) => HomeWorkException(message: error.message))
        .flatMap((success) => Success(success));
  }
}
