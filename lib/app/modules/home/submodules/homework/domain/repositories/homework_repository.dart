import 'package:result_dart/result_dart.dart';
import 'package:wizard/app/core_module/types/dates_entity.dart';
import 'package:wizard/app/modules/home/submodules/homework/domain/entities/homework.dart';
import 'package:wizard/app/modules/home/submodules/homework/domain/exceptions/homework_exception.dart';

abstract class IHomeworkRepository {
  Future<Result<bool, IHomeWorkException>> saveHomework(Homework homework);
  Future<Result<bool, IHomeWorkException>> updateHomework(Homework homework);
  Future<Result<List<Homework>, IHomeWorkException>> getHomeworksByClass(
      int classID);
  Future<Result<List<Homework>, IHomeWorkException>> getHomeworksByClassAndDate(
      int classID, DatesEntity dates);
}
