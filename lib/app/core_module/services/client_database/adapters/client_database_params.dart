import 'package:wizard/app/core_module/services/client_database/helpers/tables.dart';

class ClientDataBaseSaveParams {
  final Tables table;
  final dynamic data;

  ClientDataBaseSaveParams({
    required this.table,
    required this.data,
  });
}

class ClientDataBaseUpdateParams {
  final Tables table;
  final dynamic data;

  ClientDataBaseUpdateParams({
    required this.table,
    required this.data,
  });
}

class ClientDataBaseGetDataByFieldParams {
  final Tables table;
  final String field;
  final dynamic value;
  final String orderBy;

  ClientDataBaseGetDataByFieldParams({
    required this.table,
    required this.field,
    required this.value,
    required this.orderBy,
  });
}

class ClientDataBaseGetDataByFiltersParams {
  final Tables table;
  final Set<ClientDataBaseFilters> filters;
  final String orderBy;

  ClientDataBaseGetDataByFiltersParams({
    required this.table,
    required this.filters,
    required this.orderBy,
  });
}

class ClientDataBaseFilters {
  final String field;
  final dynamic value;

  ClientDataBaseFilters({
    required this.field,
    required this.value,
  });
}

class ClientDataBaseGetDataWithForeignTablesParams {
  final Tables table;
  final Tables foreignTable;
  final String foreignKey;
  final String colummns;
  final String orderBy;

  ClientDataBaseGetDataWithForeignTablesParams({
    required this.table,
    required this.foreignTable,
    required this.foreignKey,
    required this.colummns,
    required this.orderBy,
  });
}
