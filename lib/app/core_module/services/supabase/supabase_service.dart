// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:wizard/app/core_module/services/supabase/adapters/supabase_params.dart';
import 'package:wizard/app/core_module/services/supabase/supabase_interface.dart';

class SupaBaseService implements ISupaBase {
  final SupabaseClient supa;

  SupaBaseService({
    required this.supa,
  });

  @override
  Future<List> getDataByField(
      {required SupaBaseGetDataByFieldParams params}) async {
    final result = await supa
        .from(params.table.name)
        .select()
        .eq(params.field, params.value)
        .order(params.orderBy, ascending: true);

    return result;
  }

  @override
  Future<List> saveData({required SupaBaseSaveParams params}) async {
    final result =
        await supa.from(params.table.name).insert(params.data).select();

    return result;
  }

  @override
  Future<List> updateData({required SupaBaseUpdateParams params}) async {
    final result = await supa
        .from(params.table.name)
        .update(params.data)
        .eq('id', params.data['id'])
        .select();

    return result;
  }

  @override
  Future<List> getDataByFilters(
      {required SupaBaseGetDataByFiltersParams params}) async {
    final Map<String, dynamic> match = {};

    params.filters.map((e) => match.addAll({e.field: e.value}));

    final result = await supa.from(params.table.name).select().match(match);

    return result;
  }

  @override
  Future<List> getDataWithForeignTables(
      {required SupaBaseGetDataWithForeignTablesParams params}) async {
    final result = await supa
        .from(params.table.name)
        .select(
            '${params.colummns}, ${params.foreignTable.name}(${params.foreignKey})')
        .order(params.orderBy, ascending: true);

    return result;
  }
}
