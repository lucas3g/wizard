import 'package:wizard/app/core_module/vos/id_vo.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/entity/student.dart';

abstract class IStudentDataSource {
  Future<bool> saveStudent(Student student);
  Future<List> getStudentByClass(IdVO classID);
  Future<List> getStudentByTeacher(IdVO teacherID);
}
