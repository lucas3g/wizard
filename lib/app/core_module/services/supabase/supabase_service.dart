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
        .execute();

    return result.data;
  }

  @override
  Future<bool> saveData({required SupaBaseSaveParams params}) async {
    late bool create = false;

    if (params.data is List) {
      for (var data in params.data) {
        final result =
            await supa.from(params.table.name).insert(data).execute();

        create = result.data != null;
      }

      return create;
    }

    final result =
        await supa.from(params.table.name).insert(params.data).execute();

    return result.data != null;
  }
}
