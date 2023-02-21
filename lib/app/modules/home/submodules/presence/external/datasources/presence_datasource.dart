import 'package:intl/intl.dart';
import 'package:wizard/app/core_module/services/client_database/adapters/client_database_params.dart';
import 'package:wizard/app/core_module/services/client_database/client_database_interface.dart';
import 'package:wizard/app/core_module/services/client_database/helpers/tables.dart';
import 'package:wizard/app/core_module/types/dates_entity.dart';
import 'package:wizard/app/modules/home/submodules/presence/domain/entites/presence.dart';
import 'package:wizard/app/modules/home/submodules/presence/domain/exceptions/presence_exception.dart';
import 'package:wizard/app/modules/home/submodules/presence/infra/adapters/presence_adapter.dart';
import 'package:wizard/app/modules/home/submodules/presence/infra/datasources/presence_datasource.dart';
import 'package:wizard/app/utils/formatters.dart';

class PresenceDatasource implements IPresenceDatasource {
  final IClientDataBase client;

  PresenceDatasource({required this.client});

  @override
  Future<bool> savePresence(Presence presence) async {
    final paramsPresence = ClientDataBaseSaveParams(
      table: Tables.presences,
      data: PresenceAdapter.toMap(presence),
    );

    final resultPresence = await client.saveData(params: paramsPresence);

    presence.setId(resultPresence[0]['id']);

    final paramsCheck = ClientDataBaseSaveParams(
      table: Tables.presences_check,
      data: PresenceAdapter.toMapCheck(presence),
    );

    final resultCheck = await client.saveData(params: paramsCheck);

    if (resultPresence.isEmpty || resultCheck.isEmpty) {
      throw const PresenceException(message: 'Error saving presence');
    }

    return resultPresence.isNotEmpty && resultCheck.isNotEmpty;
  }

  @override
  Future<List> getPresenceByClass(int pClass) async {
    final params = ClientDataBaseGetDataByFieldParams(
        table: Tables.presences,
        field: 'id_class',
        value: pClass,
        orderBy: 'id_class');

    final result = await client.getDataByField(params: params);

    final paramsCheck = ClientDataBaseGetDataByFieldParams(
      table: Tables.presences_check,
      field: 'id_class',
      value: pClass,
      orderBy: 'id_class',
    );

    final resultChecks = await client.getDataByField(params: paramsCheck);

    for (var review in result) {
      review['presence'] =
          resultChecks.where((e) => e['id_presence'] == review['id']).toList();
    }

    if (result.isEmpty) {
      throw const PresenceException(message: 'Presences is empty!');
    }

    return result;
  }

  @override
  Future<List> getPresenceByClassAndDate(int pClass, DatesEntity dates) async {
    final classFilter = ClientDataBaseFilters(field: 'id_class', value: pClass);
    final dateStartFilter = ClientDataBaseFilters(
      field: 'date',
      value:
          DateFormat('dd/MM/yyyy').parse(dates.dateStart).AnoMesDiaSupaBase(),
    );

    late ClientDataBaseGetDataByFiltersParams params;

    if (dates.dateEnd.isNotEmpty) {
      final dateEndFilter = ClientDataBaseFilters(
        field: 'date',
        value:
            DateFormat('dd/MM/yyyy').parse(dates.dateEnd).AnoMesDiaSupaBase(),
      );

      params = ClientDataBaseGetDataByFiltersParams(
        table: Tables.presences,
        filters: {classFilter, dateStartFilter, dateEndFilter},
        orderBy: 'id_class',
      );
    } else {
      params = ClientDataBaseGetDataByFiltersParams(
        table: Tables.presences,
        filters: {classFilter, dateStartFilter},
        orderBy: 'id_class',
      );
    }

    final result = await client.getDataByFilters(params: params);

    if (result.isEmpty) {
      throw const PresenceException(message: 'Presence List is empty');
    }

    final paramsCheck = ClientDataBaseGetDataWithForeignTablesParams(
      table: Tables.presences_check,
      foreignTable: Tables.students,
      orderBy: 'id_class',
    );

    final resultChecks =
        await client.getDataWithForeignTables(params: paramsCheck);

    for (var presence in result) {
      presence['presence'] = resultChecks
          .where((e) => e['id_presence'] == presence['id'])
          .toList();
    }

    if (result.isEmpty) {
      throw const PresenceException(message: 'Presences is empty!');
    }

    return result;
  }

  @override
  Future<bool> updatePresence(Presence presence) async {
    final params = ClientDataBaseUpdateParams(
      table: Tables.presences,
      data: PresenceAdapter.toMapUpdate(presence),
    );

    final result = await client.updateData(params: params);

    final paramsCheck = ClientDataBaseUpdateParams(
      table: Tables.presences_check,
      data: PresenceAdapter.toMapCheckUpdate(presence),
    );

    final resultCheck = await client.updateData(params: paramsCheck);

    if (result.isEmpty || resultCheck.isEmpty) {
      throw const PresenceException(
          message: 'Error when trying to update a presences');
    }

    return result.isNotEmpty && resultCheck.isEmpty;
  }
}
