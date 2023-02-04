import 'package:wizard/app/core_module/vos/id_account_google.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/entity/student.dart';

abstract class IStudentDataSource {
  Future<bool> saveStudent(Student student);
  Future<List> getStudentByClass(int classID);
  Future<List> getStudentByTeacher(IdAccountGoogleVO teacherID);
}
