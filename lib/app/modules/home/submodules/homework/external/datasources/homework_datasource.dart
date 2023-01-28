// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:wizard/app/core_module/constants/constants.dart';
import 'package:wizard/app/core_module/services/firestore/adapters/firestore_params.dart';

import 'package:wizard/app/core_module/services/firestore/online_storage_interface.dart';
import 'package:wizard/app/modules/home/submodules/homework/domain/entities/homework.dart';
import 'package:wizard/app/modules/home/submodules/homework/domain/exceptions/homework_exception.dart';
import 'package:wizard/app/modules/home/submodules/homework/infra/adapters/homework_adapter.dart';
import 'package:wizard/app/modules/home/submodules/homework/infra/datasources/homework_datasource.dart';

class HomeworkDatasource implements IHomeworkDatasource {
  final IOnlineStorage onlineStorage;

  HomeworkDatasource({
    required this.onlineStorage,
  });

  @override
  Future<bool> saveHomework(Homework homework) async {
    final params = FireStoreSaveOrUpdateParams(
      collection:
          'homeworks/${GlobalUser.instance.user.id.value}/${homework.homeworkClass.value}/${homework.homeworkData.value}/',
      doc: homework.homeworkName.value,
      data: HomeworkAdapter.toMap(homework),
    );

    final result = await onlineStorage.saveOrUpdateData(params: params);

    if (!result) {
      throw const HomeWorkException(message: 'Error saving homework');
    }

    return result;
  }

  @override
  Future<List> getHomeworksByClass(String classID) async {
    final params = FireStoreGetDataByCollectionParams(
      collection: 'homeworks',
      doc: GlobalUser.instance.user.id.value,
      field: classID,
    );

    final result = await onlineStorage.getDataByCollection(params: params);

    if (result.docs.isEmpty) {
      throw const HomeWorkException(message: 'Homeworks is empty!');
    }

    return result.docs;
  }
}
