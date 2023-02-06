// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:wizard/app/core_module/services/supabase/adapters/supabase_params.dart';
import 'package:wizard/app/core_module/services/supabase/helpers/tables.dart';
import 'package:wizard/app/core_module/services/supabase/supabase_interface.dart';
import 'package:wizard/app/modules/home/submodules/presence/domain/entites/presence.dart';
import 'package:wizard/app/modules/home/submodules/presence/domain/exceptions/presence_exception.dart';
import 'package:wizard/app/modules/home/submodules/presence/infra/adapters/presence_adapter.dart';
import 'package:wizard/app/modules/home/submodules/presence/infra/datasources/presence_datasource.dart';

class PresenceDatasource implements IPresenceDatasource {
  final ISupaBase supa;

  PresenceDatasource({required this.supa});

  @override
  Future<bool> savePresence(Presence presence) async {
    final paramsPresence = SupaBaseSaveParams(
      table: Tables.presences,
      data: PresenceAdapter.toMap(presence),
    );

    final resultPresence = await supa.saveData(params: paramsPresence);

    presence.setId(resultPresence[0]['id']);

    final paramsCheck = SupaBaseSaveParams(
      table: Tables.presences_check,
      data: PresenceAdapter.toMapCheck(presence),
    );

    final resultCheck = await supa.saveData(params: paramsCheck);

    if (resultPresence.isEmpty || resultCheck.isEmpty) {
      throw const PresenceException(message: 'Error saving presence');
    }

    return resultPresence.isNotEmpty && resultCheck.isNotEmpty;
  }

  @override
  Future<List> getPresenceByClass(int pClass) async {
    final params = SupaBaseGetDataByFieldParams(
        table: Tables.presences,
        field: 'class',
        value: pClass,
        orderBy: 'class');

    final result = await supa.getDataByField(params: params);

    final paramsCheck = SupaBaseGetDataByFieldParams(
      table: Tables.presences_check,
      field: 'class',
      value: pClass,
      orderBy: 'class',
    );

    final resultChecks = await supa.getDataByField(params: paramsCheck);

    for (var review in result) {
      for (var presence
          in resultChecks.where((e) => e['id_presence'] == review['id'])) {
        review['presence'] = presence;
      }
    }

    if (result.isEmpty) {
      throw const PresenceException(message: 'Presences is empty!');
    }

    return result;
  }
}
