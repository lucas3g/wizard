// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:result_dart/result_dart.dart';

import 'package:wizard/app/modules/home/submodules/class/domain/entities/class.dart';
import 'package:wizard/app/modules/home/submodules/class/domain/exceptions/class_exception.dart';
import 'package:wizard/app/modules/home/submodules/class/domain/repositories/class_repository.dart';
import 'package:wizard/app/modules/home/submodules/class/domain/vos/class_id_teacher.dart';
import 'package:wizard/app/modules/home/submodules/class/infra/datasources/class_datasource.dart';

class ClassRepository implements IClassRepository {
  final IClassDataSource dataSource;

  ClassRepository({required this.dataSource});

  @override
  AsyncResult<bool, IClassException> saveClass(Class pClass) {
    return dataSource
        .saveClass(pClass)
        .mapError<IClassException>(
            (error) => ClassException(message: error.toString()))
        .flatMap((success) => Success(success));
  }

  @override
  AsyncResult<List<Class>, IClassException> getClassesByTeacher(
      ClassIDTeacher idTeacher) {
    return dataSource
        .getClassesByTeacher(idTeacher)
        .mapError<IClassException>(
            (error) => ClassException(message: error.toString()))
        .flatMap((success) => Success(success));
  }
}
