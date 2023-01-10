import 'package:wizard/app/modules/home/submodules/homework/domain/entities/homework.dart';

abstract class IHomeworkDatasource {
  Future<bool> saveHomework(Homework homework);
  Future<List<Homework>> getHomeworksByClass(String classID);
}
