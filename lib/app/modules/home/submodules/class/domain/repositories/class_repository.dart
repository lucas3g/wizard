import 'package:result_dart/result_dart.dart';
import 'package:wizard/app/modules/home/submodules/class/domain/entities/class.dart';
import 'package:wizard/app/modules/home/submodules/class/domain/exceptions/class_exception.dart';
import 'package:wizard/app/modules/home/submodules/class/domain/vos/class_id_teacher.dart';

abstract class IClassRepository {
  Future<Result<bool, IClassException>> saveClass(Class pClass);
  Future<Result<List<Class>, IClassException>> getClassesByTeacher(
      ClassIDTeacher idTeacher);
}
