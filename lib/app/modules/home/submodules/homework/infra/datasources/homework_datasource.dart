import 'package:wizard/app/core_module/types/dates_entity.dart';
import 'package:wizard/app/modules/home/submodules/homework/domain/entities/homework.dart';

abstract class IHomeworkDatasource {
  Future<bool> saveHomework(Homework homework);
  Future<bool> updateHomework(Homework homework);
  Future<List> getHomeworksByClass(int classID);
  Future<List> getHomeworksByClassAndDate(int classID, DatesEntity dates);
}
