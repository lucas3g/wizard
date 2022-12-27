// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:result_dart/result_dart.dart';

import 'package:wizard/app/modules/home/submodules/student/domain/entity/student.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/exceptions/student_exception.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/repositories/student_repository.dart';

abstract class ISaveStudentUseCase {
  Future<Result<bool, IStudentException>> call(Student student);
}

class SaveStudentUseCase implements ISaveStudentUseCase {
  final IStudentRepository repository;

  SaveStudentUseCase({
    required this.repository,
  });

  @override
  Future<Result<bool, IStudentException>> call(Student student) async {
    return await student.validate().fold(
        (success) async => repository.saveStudent(student),
        (failure) => StudentException(message: failure).toFailure());
  }
}
