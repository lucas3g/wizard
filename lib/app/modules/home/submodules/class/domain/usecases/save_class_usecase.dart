// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:result_dart/result_dart.dart';

import 'package:wizard/app/modules/home/submodules/class/domain/entities/class.dart';
import 'package:wizard/app/modules/home/submodules/class/domain/exceptions/class_exception.dart';
import 'package:wizard/app/modules/home/submodules/class/domain/repositories/class_repository.dart';

abstract class ISaveClassUseCase {
  AsyncResult<bool, IClassException> call(Class pClass);
}

class SaveClassUseCase implements ISaveClassUseCase {
  final IClassRepository repository;

  SaveClassUseCase({required this.repository});

  @override
  AsyncResult<bool, IClassException> call(Class pClass) {
    return pClass
        .validate()
        .mapError<IClassException>((error) => ClassException(message: error))
        .toAsyncResult()
        .flatMap(repository.saveClass);
  }
}
