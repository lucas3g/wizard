// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:result_dart/result_dart.dart';

import 'package:wizard/app/modules/home/submodules/class/domain/entities/class.dart';
import 'package:wizard/app/modules/home/submodules/class/domain/exceptions/class_exception.dart';
import 'package:wizard/app/modules/home/submodules/class/domain/repositories/class_repository.dart';

abstract class ICreateClassUseCase {
  AsyncResult<bool, IClassException> call(Class pClass);
}

class CreateClassUseCase implements ICreateClassUseCase {
  final IClassRepository repository;

  CreateClassUseCase({required this.repository});

  @override
  AsyncResult<bool, IClassException> call(Class pClass) {
    return pClass
        .validate()
        .mapError<IClassException>((error) => ClassException(message: error))
        .toAsyncResult()
        .flatMap(repository.createClass);
  }
}
