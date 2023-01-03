import 'package:result_dart/result_dart.dart';
import 'package:wizard/app/modules/home/submodules/homework/domain/entities/homework.dart';
import 'package:wizard/app/modules/home/submodules/homework/domain/exceptions/homework_exception.dart';

abstract class IHomeworkRepository {
  AsyncResult<bool, IHomeWorkException> saveHomework(Homework homework);
}
