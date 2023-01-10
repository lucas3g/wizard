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
  Future<Result<bool, IClassException>> saveClass(Class pClass) async {
    try {
      final result = await dataSource.saveClass(pClass);

      return result.toSuccess();
    } on IClassException catch (e) {
      return ClassException(message: e.message).toFailure();
    } catch (e) {
      return ClassException(message: e.toString()).toFailure();
    }
  }

  @override
  Future<Result<List<Class>, IClassException>> getClassesByTeacher(
      ClassIDTeacher idTeacher) async {
    try {
      final result = await dataSource.getClassesByTeacher(idTeacher);

      return result.toSuccess();
    } on IClassException catch (e) {
      return ClassException(message: e.message).toFailure();
    } catch (e) {
      return ClassException(message: e.toString()).toFailure();
    }
  }
}
