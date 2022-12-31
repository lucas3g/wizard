// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:result_dart/result_dart.dart';
import 'package:wizard/app/core_module/services/firestore/adapters/firestore_params.dart';

import 'package:wizard/app/core_module/services/firestore/online_storage_interface.dart';
import 'package:wizard/app/modules/home/submodules/presence/domain/entites/presence.dart';
import 'package:wizard/app/modules/home/submodules/presence/domain/exceptions/presence_exception.dart';
import 'package:wizard/app/modules/home/submodules/presence/infra/adapters/presence_adapter.dart';
import 'package:wizard/app/modules/home/submodules/presence/infra/datasources/presence_datasource.dart';
import 'package:wizard/app/utils/formatters.dart';

class PresenceDatasource implements IPresenceDatasource {
  final IOnlineStorage onlineStorage;

  PresenceDatasource({required this.onlineStorage});

  @override
  AsyncResult<bool, IPresenceException> savePresence(Presence presence) async {
    try {
      final params = FireStoreSaveOrUpdateParams(
        collection: 'presences/${presence.presenceClass.value}/presence',
        doc: DateTime.now().DiaMesAnoDB(),
        data: PresenceAdapter.toMap(presence),
      );

      final result = await onlineStorage.saveOrUpdateData(params: params);

      return result.toSuccess();
    } catch (e) {
      return PresenceException(message: e.toString()).toFailure();
    }
  }
}
