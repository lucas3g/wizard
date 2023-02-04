import 'package:result_dart/result_dart.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/entity/student.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/exceptions/student_exception.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/repositories/student_repository.dart';

abstract class IGetStudentByClassUseCase {
  AsyncResult<List<Student>, IStudentException> call(int classID);
}

class GetStudentByClassUseCase implements IGetStudentByClassUseCase {
  final IStudentRepository repository;

  GetStudentByClassUseCase({required this.repository});

  @override
  AsyncResult<List<Student>, IStudentException> call(int classID) {
    return repository.getStudentByClass(classID);
  }
}
