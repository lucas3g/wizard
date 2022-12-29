import 'package:result_dart/result_dart.dart';
import 'package:wizard/app/modules/home/submodules/class/domain/entities/class.dart';
import 'package:wizard/app/modules/home/submodules/class/domain/exceptions/class_exception.dart';

abstract class IClassRepository {
  AsyncResult<bool, IClassException> saveClass(Class pClass);
}
