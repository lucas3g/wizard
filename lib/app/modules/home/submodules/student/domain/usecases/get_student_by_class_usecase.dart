import 'package:result_dart/result_dart.dart';
import 'package:wizard/app/core_module/vos/id_vo.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/entity/student.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/exceptions/student_exception.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/repositories/student_repository.dart';

abstract class IGetStudentByClassUseCase {
  AsyncResult<List<Student>, IStudentException> call(IdVO classID);
}

class GetStudentByClassUseCase implements IGetStudentByClassUseCase {
  final IStudentRepository repository;

  GetStudentByClassUseCase({required this.repository});

  @override
  AsyncResult<List<Student>, IStudentException> call(IdVO classID) {
    return classID
        .validate()
        .mapError<IStudentException>(
            (error) => StudentException(message: error))
        .toAsyncResult()
        .flatMap(repository.getStudentByClass);
  }
}
