import 'package:wizard/app/core_module/services/client_database/adapters/client_database_params.dart';
import 'package:wizard/app/core_module/services/client_database/client_database_interface.dart';
import 'package:wizard/app/core_module/services/client_database/helpers/tables.dart';
import 'package:wizard/app/modules/home/submodules/homework/domain/entities/homework.dart';
import 'package:wizard/app/modules/home/submodules/homework/domain/exceptions/homework_exception.dart';
import 'package:wizard/app/modules/home/submodules/homework/infra/adapters/homework_adapter.dart';
import 'package:wizard/app/modules/home/submodules/homework/infra/datasources/homework_datasource.dart';

class HomeworkDatasource implements IHomeworkDatasource {
  final IClientDataBase client;

  HomeworkDatasource({
    required this.client,
  });

  @override
  Future<bool> saveHomework(Homework homework) async {
    final paramsHome = ClientDataBaseSaveParams(
      table: Tables.homeworks,
      data: HomeworkAdapter.toMap(homework),
    );

    final resultHomeworks = await client.saveData(params: paramsHome);

    homework.setId(resultHomeworks[0]['id']);

    final paramsNotes = ClientDataBaseSaveParams(
      table: Tables.homeworks_notes,
      data: HomeworkAdapter.toMapNotes(homework),
    );

    final resultNotes = await client.saveData(params: paramsNotes);

    if (resultHomeworks.isEmpty || resultNotes.isEmpty) {
      throw const HomeWorkException(message: 'Error saving homework');
    }

    return resultHomeworks.isNotEmpty && resultNotes.isNotEmpty;
  }

  @override
  Future<List> getHomeworksByClass(int classID) async {
    final paramsHomework = ClientDataBaseGetDataByFieldParams(
      table: Tables.homeworks,
      field: 'id_class',
      value: classID,
      orderBy: 'name',
    );

    final resultHomework = await client.getDataByField(params: paramsHomework);

    final paramsNotes = ClientDataBaseGetDataByFieldParams(
      table: Tables.homeworks_notes,
      field: 'id_class',
      value: classID,
      orderBy: 'id_class',
    );

    final resultNotes = await client.getDataByField(params: paramsNotes);

    for (var homework in resultHomework) {
      homework['notes'] =
          resultNotes.where((e) => e['id_homework'] == homework['id']).toList();
    }

    if (resultHomework.isEmpty) {
      throw const HomeWorkException(message: 'Homeworks is empty!');
    }

    return resultHomework;
  }

  @override
  Future<bool> updateHomework(Homework homework) async {
    final params = ClientDataBaseUpdateParams(
      table: Tables.homeworks,
      data: HomeworkAdapter.toMapUpdate(homework),
    );

    final result = await client.updateData(params: params);

    final paramsNotes = ClientDataBaseUpdateParams(
      table: Tables.homeworks_notes,
      data: HomeworkAdapter.toMapNotesUpdate(homework),
    );

    final resultNotes = await client.updateData(params: paramsNotes);

    if (result.isEmpty || resultNotes.isEmpty) {
      throw const HomeWorkException(
          message: 'Error when trying to update a homework');
    }

    return result.isNotEmpty && resultNotes.isEmpty;
  }
}
