import 'package:wizard/app/core_module/services/supabase/adapters/supabase_params.dart';

abstract class ISupaBase {
  Future<bool> saveData({required SupaBaseSaveParams params});
  Future<List> getDataByField({required SupaBaseGetDataByFieldParams params});
}
