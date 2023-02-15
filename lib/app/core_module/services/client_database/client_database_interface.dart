import 'package:wizard/app/core_module/services/client_database/adapters/client_database_params.dart';

abstract class IClientDataBase {
  Future<List> saveData({required ClientDataBaseSaveParams params});
  Future<List> updateData({required ClientDataBaseUpdateParams params});
  Future<List> getDataByField(
      {required ClientDataBaseGetDataByFieldParams params});
  Future<List> getDataByFilters({
    required ClientDataBaseGetDataByFiltersParams params,
  });
  Future<List> getDataWithForeignTables(
      {required ClientDataBaseGetDataWithForeignTablesParams params});
}
