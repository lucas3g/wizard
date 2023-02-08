import 'package:result_dart/result_dart.dart';
import 'package:wizard/app/modules/home/submodules/class/domain/entities/class.dart';
import 'package:wizard/app/modules/home/submodules/class/domain/exceptions/class_exception.dart';
import 'package:wizard/app/modules/home/submodules/class/domain/vos/class_id_teacher.dart';

abstract class IClassRepository {
  Future<Result<bool, IClassException>> createClass(Class pClass);
  Future<Result<bool, IClassException>> updateClass(Class pClass);
  Future<Result<List<Class>, IClassException>> getClassesByTeacher(
      ClassIDTeacher idTeacher);
}
