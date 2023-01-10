import 'package:result_dart/result_dart.dart';
import 'package:wizard/app/core_module/vos/id_vo.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/entity/student.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/exceptions/student_exception.dart';

abstract class IStudentRepository {
  Future<Result<bool, IStudentException>> saveStudent(Student student);
  Future<Result<List<Student>, IStudentException>> getStudentByClass(
      IdVO classID);
  Future<Result<List<Student>, IStudentException>> getStudentByTeacher(
      IdVO teacherID);
}
