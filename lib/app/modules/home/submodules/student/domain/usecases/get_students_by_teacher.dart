import 'package:result_dart/result_dart.dart';
import 'package:wizard/app/core_module/vos/id_account_google.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/entity/student.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/exceptions/student_exception.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/repositories/student_repository.dart';

abstract class IGetStudentsByTeacherUseCase {
  AsyncResult<List<Student>, IStudentException> call(
      IdAccountGoogleVO teacherID);
}

class GetStudentsByTeacherUseCase implements IGetStudentsByTeacherUseCase {
  final IStudentRepository repository;

  GetStudentsByTeacherUseCase({required this.repository});

  @override
  AsyncResult<List<Student>, IStudentException> call(
      IdAccountGoogleVO teacherID) {
    return teacherID
        .validate()
        .mapError<IStudentException>(
            (error) => StudentException(message: error))
        .toAsyncResult()
        .flatMap(repository.getStudentByTeacher);
  }
}
