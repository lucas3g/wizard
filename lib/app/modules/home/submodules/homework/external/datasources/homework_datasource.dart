// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:wizard/app/core_module/services/supabase/adapters/supabase_params.dart';
import 'package:wizard/app/core_module/services/supabase/helpers/tables.dart';
import 'package:wizard/app/core_module/services/supabase/supabase_interface.dart';
import 'package:wizard/app/modules/home/submodules/homework/domain/entities/homework.dart';
import 'package:wizard/app/modules/home/submodules/homework/domain/exceptions/homework_exception.dart';
import 'package:wizard/app/modules/home/submodules/homework/infra/adapters/homework_adapter.dart';
import 'package:wizard/app/modules/home/submodules/homework/infra/datasources/homework_datasource.dart';

class HomeworkDatasource implements IHomeworkDatasource {
  final ISupaBase supa;

  HomeworkDatasource({
    required this.supa,
  });

  @override
  Future<bool> saveHomework(Homework homework) async {
    final paramsHome = SupaBaseSaveParams(
      table: Tables.homeworks,
      data: HomeworkAdapter.toMap(homework),
    );

    final resultHomeworks = await supa.saveData(params: paramsHome);

    final paramsNotes = SupaBaseSaveParams(
      table: Tables.homeworks_notes,
      data: HomeworkAdapter.toMapNotes(homework),
    );

    final resultNotes = await supa.saveData(params: paramsNotes);

    if (!resultHomeworks || !resultNotes) {
      throw const HomeWorkException(message: 'Error saving homework');
    }

    return resultHomeworks && resultNotes;
  }

  @override
  Future<List> getHomeworksByClass(String classID) async {
    final paramsHomework = SupaBaseGetDataByFieldParams(
      table: Tables.homeworks,
      field: 'class',
      value: classID,
      orderBy: 'name',
    );

    final resultHomework = await supa.getDataByField(params: paramsHomework);

    final paramsNotes = SupaBaseGetDataByFieldParams(
      table: Tables.homeworks_notes,
      field: 'class',
      value: classID,
      orderBy: 'class',
    );

    final resultNotes = await supa.getDataByField(params: paramsNotes);

    if (resultHomework.isEmpty) {
      throw const HomeWorkException(message: 'Homeworks is empty!');
    }

    resultHomework[0]['notes'] = resultNotes;

    return resultHomework;
  }
}
