// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:result_dart/result_dart.dart';
import 'package:wizard/app/core_module/vos/id_account_google.dart';

import 'package:wizard/app/modules/home/submodules/student/domain/entity/student.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/exceptions/student_exception.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/repositories/student_repository.dart';
import 'package:wizard/app/modules/home/submodules/student/infra/adapters/student_adapter.dart';
import 'package:wizard/app/modules/home/submodules/student/infra/datasources/student_datasource.dart';

class StudentRepository implements IStudentRepository {
  final IStudentDataSource dataSource;

  StudentRepository({required this.dataSource});

  @override
  Future<Result<bool, IStudentException>> createStudent(Student student) async {
    try {
      final result = await dataSource.createStudent(student);

      return result.toSuccess();
    } on IStudentException catch (e) {
      return StudentException(message: e.message).toFailure();
    } catch (e) {
      return StudentException(message: e.toString()).toFailure();
    }
  }

  @override
  Future<Result<List<Student>, IStudentException>> getStudentByClass(
      int classID) async {
    try {
      final result = await dataSource.getStudentByClass(classID);

      late List<Student> students = [];

      for (var student in result) {
        students.add(StudentAdapter.fromMap(student));
      }

      return students.toSuccess();
    } on IStudentException catch (e) {
      return StudentException(message: e.message).toFailure();
    } catch (e) {
      return StudentException(message: e.toString()).toFailure();
    }
  }

  @override
  Future<Result<List<Student>, IStudentException>> getStudentByTeacher(
      IdAccountGoogleVO teacherID) async {
    try {
      final result = await dataSource.getStudentByTeacher(teacherID);

      late List<Student> students = [];

      for (var student in result) {
        students.add(StudentAdapter.fromMap(student));
      }

      return students.toSuccess();
    } on IStudentException catch (e) {
      return StudentException(message: e.message).toFailure();
    } catch (e) {
      return StudentException(message: e.toString()).toFailure();
    }
  }

  @override
  Future<Result<bool, IStudentException>> updateStudent(Student student) async {
    try {
      final result = await dataSource.updateStudent(student);

      return result.toSuccess();
    } on IStudentException catch (e) {
      return StudentException(message: e.message).toFailure();
    } catch (e) {
      return StudentException(message: e.toString()).toFailure();
    }
  }
}
