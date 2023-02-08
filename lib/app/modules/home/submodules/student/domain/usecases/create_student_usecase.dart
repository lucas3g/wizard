import 'package:result_dart/result_dart.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/entity/student.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/exceptions/student_exception.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/repositories/student_repository.dart';

abstract class ICreateStudentUseCase {
  AsyncResult<bool, IStudentException> call(Student student);
}

class CreateStudentUseCase implements ICreateStudentUseCase {
  final IStudentRepository repository;

  CreateStudentUseCase({required this.repository});

  @override
  AsyncResult<bool, IStudentException> call(Student student) {
    return student
        .validate()
        .mapError<IStudentException>(
            (error) => StudentException(message: error))
        .toAsyncResult()
        .flatMap(repository.createStudent);
  }
}
