// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:result_dart/result_dart.dart';
import 'package:wizard/app/core_module/vos/id_vo.dart';

import 'package:wizard/app/modules/home/submodules/student/domain/entity/student.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/exceptions/student_exception.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/repositories/student_repository.dart';
import 'package:wizard/app/modules/home/submodules/student/infra/datasources/student_datasource.dart';

class StudentRepository implements IStudentRepository {
  final IStudentDataSource dataSource;

  StudentRepository({required this.dataSource});

  @override
  AsyncResult<bool, IStudentException> saveStudent(Student student) {
    return dataSource
        .saveStudent(student)
        .mapError<IStudentException>(
            (error) => StudentException(message: error.message))
        .flatMap((success) => Success(success));
  }

  @override
  AsyncResult<List<Student>, IStudentException> getStudentByClass(
      IdVO classID) {
    return dataSource
        .getStudentByClass(classID)
        .mapError<IStudentException>(
            (error) => StudentException(message: error.message))
        .flatMap((success) => Success(success));
  }
}
