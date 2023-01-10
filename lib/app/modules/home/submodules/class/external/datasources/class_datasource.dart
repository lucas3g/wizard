// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:wizard/app/core_module/services/firestore/adapters/firestore_params.dart';

import 'package:wizard/app/core_module/services/firestore/online_storage_interface.dart';
import 'package:wizard/app/modules/home/submodules/class/domain/entities/class.dart';
import 'package:wizard/app/modules/home/submodules/class/domain/exceptions/class_exception.dart';
import 'package:wizard/app/modules/home/submodules/class/domain/vos/class_id_teacher.dart';
import 'package:wizard/app/modules/home/submodules/class/infra/adapters/class_adapter.dart';
import 'package:wizard/app/modules/home/submodules/class/infra/datasources/class_datasource.dart';

class ClassDataSource implements IClassDataSource {
  final IOnlineStorage onlineStorage;

  ClassDataSource({required this.onlineStorage});

  @override
  Future<bool> saveClass(Class pClass) async {
    final params = FireStoreSaveOrUpdateParams(
      collection: 'classes',
      doc: pClass.id.value,
      data: ClassAdapter.toMap(pClass),
    );

    final result = await onlineStorage.saveOrUpdateData(params: params);

    return result;
  }

  @override
  Future<List<Class>> getClassesByTeacher(ClassIDTeacher idTeacher) async {
    final params = FireStoreGetDataParams(
      collection: 'classes',
      field: 'idTeacher',
      value: idTeacher.value,
    );

    final result = await onlineStorage.getDataById(params: params);

    if (result.docs.isEmpty) {
      throw const ClassException(message: 'Class is empty!');
    }

    late List<Class> list = [];

    for (var doc in result.docs) {
      list.add(ClassAdapter.fromMap(doc.data()));
    }

    return list;
  }
}
