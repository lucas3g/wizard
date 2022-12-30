// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:result_dart/result_dart.dart';

import 'package:wizard/app/modules/home/submodules/class/domain/entities/class.dart';
import 'package:wizard/app/modules/home/submodules/class/domain/exceptions/class_exception.dart';
import 'package:wizard/app/modules/home/submodules/class/domain/repositories/class_repository.dart';
import 'package:wizard/app/modules/home/submodules/class/domain/vos/class_id_teacher.dart';

abstract class IGetClassesByTeacherUseCase {
  AsyncResult<List<Class>, IClassException> call(ClassIDTeacher idTeacher);
}

class GetClassesByTeacherUseCase implements IGetClassesByTeacherUseCase {
  final IClassRepository repository;

  GetClassesByTeacherUseCase({required this.repository});

  @override
  AsyncResult<List<Class>, IClassException> call(ClassIDTeacher idTeacher) {
    return idTeacher
        .validate()
        .mapError<IClassException>((error) => ClassException(message: error))
        .toAsyncResult()
        .flatMap((success) => repository.getClassesByTeacher(idTeacher));
  }
}
