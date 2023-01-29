// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:wizard/app/core_module/services/supabase/adapters/supabase_params.dart';
import 'package:wizard/app/core_module/services/supabase/helpers/tables.dart';
import 'package:wizard/app/core_module/services/supabase/supabase_interface.dart';
import 'package:wizard/app/modules/home/submodules/class/domain/entities/class.dart';
import 'package:wizard/app/modules/home/submodules/class/domain/exceptions/class_exception.dart';
import 'package:wizard/app/modules/home/submodules/class/domain/vos/class_id_teacher.dart';
import 'package:wizard/app/modules/home/submodules/class/infra/adapters/class_adapter.dart';
import 'package:wizard/app/modules/home/submodules/class/infra/datasources/class_datasource.dart';

class ClassDataSource implements IClassDataSource {
  final ISupaBase supa;

  ClassDataSource({required this.supa});

  @override
  Future<bool> saveClass(Class pClass) async {
    final params = SupaBaseSaveParams(
      table: Tables.classes,
      data: ClassAdapter.toMap(pClass),
    );

    final result = await supa.saveData(params: params);

    if (!result) {
      throw const ClassException(message: 'Error saving class');
    }

    return result;
  }

  @override
  Future<List> getClassesByTeacher(ClassIDTeacher idTeacher) async {
    final params = SupaBaseGetDataByFieldParams(
      table: Tables.classes,
      field: idTeacher.value,
      orderBy: 'name',
    );

    final result = await supa.getDataByField(params: params);

    if (result.isEmpty) {
      throw const ClassException(message: 'Class is empty!');
    }

    return result;
  }
}
