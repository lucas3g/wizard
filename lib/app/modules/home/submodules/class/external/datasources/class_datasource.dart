// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:result_dart/result_dart.dart';
import 'package:wizard/app/core_module/services/firestore/adapters/firestore_params.dart';

import 'package:wizard/app/core_module/services/firestore/online_storage_interface.dart';
import 'package:wizard/app/modules/home/submodules/class/domain/entities/class.dart';
import 'package:wizard/app/modules/home/submodules/class/domain/exceptions/class_exception.dart';
import 'package:wizard/app/modules/home/submodules/class/infra/adapters/class_adapter.dart';
import 'package:wizard/app/modules/home/submodules/class/infra/datasources/class_datasource.dart';

class ClassDataSource implements IClassDataSource {
  final IOnlineStorage onlineStorage;

  ClassDataSource({required this.onlineStorage});

  @override
  AsyncResult<bool, IClassException> saveClass(Class pClass) async {
    try {
      final params = FireStoreParams(
        collection: 'classes',
        data: ClassAdapter.toMap(pClass),
      );

      final result = await onlineStorage.saveData(params: params);

      return result.toSuccess();
    } catch (e) {
      return ClassException(message: e.toString()).toFailure();
    }
  }
}
