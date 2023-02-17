import 'package:intl/intl.dart';
import 'package:wizard/app/core_module/services/client_database/adapters/client_database_params.dart';
import 'package:wizard/app/core_module/services/client_database/client_database_interface.dart';
import 'package:wizard/app/core_module/services/client_database/helpers/tables.dart';
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
  Future<List> getPresenceByClassAndDate(int pClass, String date) async {
    final classFilter = ClientDataBaseFilters(field: 'id_class', value: pClass);
    final dateFilter = ClientDataBaseFilters(
      field: 'date',
      value: DateFormat('dd/MM/yyyy').parse(date).AnoMesDiaSupaBase(),
    );

    final params = ClientDataBaseGetDataByFiltersParams(
      table: Tables.presences,
      filters: {classFilter, dateFilter},
      orderBy: 'id_class',
    );

    final result = await client.getDataByFilters(params: params);

    if (result.isEmpty) {
      throw const PresenceException(message: 'Presence List is empty');
    }

    final paramsCheck = ClientDataBaseGetDataWithForeignTablesParams(
      table: Tables.presences_check,
      foreignTable: Tables.students,
      foreignKey: 'id_student',
      colummns: 'id,id_presence,id_student,id_class,type,name',
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
}
