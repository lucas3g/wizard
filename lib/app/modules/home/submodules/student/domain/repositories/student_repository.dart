import 'package:result_dart/result_dart.dart';
import 'package:wizard/app/core_module/vos/id_account_google.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/entity/student.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/exceptions/student_exception.dart';

abstract class IStudentRepository {
  Future<Result<bool, IStudentException>> createStudent(Student student);
  Future<Result<bool, IStudentException>> updateStudent(Student student);
  Future<Result<List<Student>, IStudentException>> getStudentByClass(
      int classID);
  Future<Result<List<Student>, IStudentException>> getStudentByTeacher(
      IdAccountGoogleVO teacherID);
}
