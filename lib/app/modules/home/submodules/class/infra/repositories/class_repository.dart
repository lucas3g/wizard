// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:result_dart/result_dart.dart';

import 'package:wizard/app/modules/home/submodules/class/domain/entities/class.dart';
import 'package:wizard/app/modules/home/submodules/class/domain/exceptions/class_exception.dart';
import 'package:wizard/app/modules/home/submodules/class/domain/repositories/class_repository.dart';
import 'package:wizard/app/modules/home/submodules/class/domain/vos/class_id_teacher.dart';
import 'package:wizard/app/modules/home/submodules/class/infra/adapters/class_adapter.dart';
import 'package:wizard/app/modules/home/submodules/class/infra/datasources/class_datasource.dart';

class ClassRepository implements IClassRepository {
  final IClassDataSource dataSource;

  ClassRepository({required this.dataSource});

  @override
  Future<Result<bool, IClassException>> createClass(Class pClass) async {
    try {
      final result = await dataSource.createClass(pClass);

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
      late List<Class> list = [];

      for (var doc in result) {
        list.add(ClassAdapter.fromMap(doc));
      }

      return list.toSuccess();
    } on IClassException catch (e) {
      return ClassException(message: e.message).toFailure();
    } catch (e) {
      return ClassException(message: e.toString()).toFailure();
    }
  }

  @override
  Future<Result<bool, IClassException>> updateClass(Class pClass) async {
    try {
      final result = await dataSource.updateClass(pClass);

      return result.toSuccess();
    } on IClassException catch (e) {
      return ClassException(message: e.message).toFailure();
    } catch (e) {
      return ClassException(message: e.toString()).toFailure();
    }
  }
}
