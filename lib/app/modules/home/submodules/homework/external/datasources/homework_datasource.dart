// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:result_dart/result_dart.dart';
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
  AsyncResult<bool, IHomeWorkException> saveHomework(Homework homework) async {
    try {
      final params = FireStoreSaveOrUpdateParams(
        collection:
            'homeworks/${GlobalUser.instance.user!.id.value}/${homework.homeworkClass.value}',
        doc: homework.homeworkName.value,
        data: HomeworkAdapter.toMap(homework),
      );

      final result = await onlineStorage.saveOrUpdateData(params: params);

      return result.toSuccess();
    } catch (e) {
      return HomeWorkException(message: e.toString()).toFailure();
    }
  }
}
