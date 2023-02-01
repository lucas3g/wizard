// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:wizard/app/core_module/services/supabase/helpers/tables.dart';

class SupaBaseSaveParams {
  final Tables table;
  final dynamic data;

  SupaBaseSaveParams({
    required this.table,
    required this.data,
  });
}

class SupaBaseGetDataByFieldParams {
  final Tables table;
  final String field;
  final dynamic value;
  final String orderBy;

  SupaBaseGetDataByFieldParams({
    required this.table,
    required this.field,
    required this.value,
    required this.orderBy,
  });
}
