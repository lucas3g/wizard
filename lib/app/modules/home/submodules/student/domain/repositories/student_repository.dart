import 'package:result_dart/result_dart.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/entity/student.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/exceptions/student_exception.dart';

abstract class IStudentRepository {
  AsyncResult<Student, IStudentException> saveStudent(Student student);
}
