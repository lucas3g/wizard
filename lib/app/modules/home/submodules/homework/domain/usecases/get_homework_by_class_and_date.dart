// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:result_dart/result_dart.dart';
import 'package:wizard/app/core_module/types/dates_entity.dart';
import 'package:wizard/app/modules/home/submodules/homework/domain/entities/homework.dart';
import 'package:wizard/app/modules/home/submodules/homework/domain/exceptions/homework_exception.dart';
import 'package:wizard/app/modules/home/submodules/homework/domain/repositories/homework_repository.dart';

abstract class IGetHomeworkByClassAndDateUseCase {
  AsyncResult<List<Homework>, IHomeWorkException> call(
      int classID, DatesEntity dates);
}

class GetHomeworkByClassAndDateUseCase
    implements IGetHomeworkByClassAndDateUseCase {
  final IHomeworkRepository repository;

  GetHomeworkByClassAndDateUseCase({required this.repository});

  @override
  AsyncResult<List<Homework>, IHomeWorkException> call(
      int classID, DatesEntity dates) {
    return repository.getHomeworksByClassAndDate(classID, dates);
  }
}
