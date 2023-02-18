import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wizard/app/core_module/services/client_database/adapters/client_database_params.dart';
import 'package:wizard/app/core_module/services/client_database/client_database_interface.dart';

class SupaBaseService implements IClientDataBase {
  final SupabaseClient supa;

  SupaBaseService({
    required this.supa,
  });

  @override
  Future<List> getDataByField(
      {required ClientDataBaseGetDataByFieldParams params}) async {
    final result = await supa
        .from(params.table.name)
        .select()
        .eq(params.field, params.value)
        .order(params.orderBy, ascending: true);

    return result;
  }

  @override
  Future<List> saveData({required ClientDataBaseSaveParams params}) async {
    final result =
        await supa.from(params.table.name).insert(params.data).select();

    return result;
  }

  @override
  Future<List> updateData({required ClientDataBaseUpdateParams params}) async {
    if (params.data is List) {
      late List result = [];

      for (var data in params.data) {
        result = await supa
            .from(params.table.name)
            .update(data)
            .eq('id', data['id'])
            .select();
      }

      return result;
    } else {
      final result = await supa
          .from(params.table.name)
          .update(params.data)
          .eq('id', params.data['id'])
          .select();

      return result;
    }
  }

  @override
  Future<List> getDataByFilters(
      {required ClientDataBaseGetDataByFiltersParams params}) async {
    final Map<String, dynamic> match = {};

    for (var filter in params.filters) {
      match.addAll({filter.field: filter.value});
    }

    final result = await supa.from(params.table.name).select().match(match);

    return result;
  }

  @override
  Future<List> getDataWithForeignTables(
      {required ClientDataBaseGetDataWithForeignTablesParams params}) async {
    final result = await supa
        .from(params.table.name)
        .select('*, ${params.foreignTable.name}!inner(*)')
        .order(params.orderBy, ascending: true);

    return result;
  }
}
