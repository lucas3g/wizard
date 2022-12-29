import 'package:result_dart/result_dart.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/entity/student.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/exceptions/student_exception.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/repositories/student_repository.dart';

abstract class ISaveStudentUseCase {
  AsyncResult<Student, IStudentException> call(Student student);
}

class SaveStudentUseCase implements ISaveStudentUseCase {
  final IStudentRepository repository;

  SaveStudentUseCase({required this.repository});

  @override
  AsyncResult<Student, IStudentException> call(Student student) {
    return student
        .validate()
        .mapError<IStudentException>(
            (error) => StudentException(message: error))
        .toAsyncResult()
        .flatMap(repository.saveStudent);
  }
}
