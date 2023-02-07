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
    if (params.data is List<Map<String, dynamic>>) {
      Map<String, dynamic> firstData =
          (params.data as List<Map<String, dynamic>>).first;

      List<String> keys = ['id_homework', 'id_presence', 'id_review'];
      for (String key in keys) {
        if (firstData.containsKey(key)) {
          await supa.from(params.table.name).delete().eq(key, firstData[key]);
          break;
        }
      }
    }

    await supa
        .from(params.table.name)
        .delete()
        .eq('date', params.data['date'])
        .eq('id_class', params.data['id_class']);

    final result =
        await supa.from(params.table.name).insert(params.data).select();

    return result;
  }
}
