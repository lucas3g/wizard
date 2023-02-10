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
  Future<bool> createClass(Class pClass) async {
    final params = SupaBaseSaveParams(
      table: Tables.classes,
      data: ClassAdapter.toMap(pClass),
    );

    final result = await supa.saveData(params: params);

    if (result.isEmpty) {
      throw const ClassException(
          message: 'Error when trying to create a class');
    }

    return result.isNotEmpty;
  }

  @override
  Future<List> getClassesByTeacher(ClassIDTeacher idTeacher) async {
    final params = SupaBaseGetDataByFieldParams(
      table: Tables.classes,
      field: 'id_teacher',
      value: idTeacher.value,
      orderBy: 'name',
    );

    final result = await supa.getDataByField(params: params);

    if (result.isEmpty) {
      throw const ClassException(message: 'Class is empty!');
    }

    return result;
  }

  @override
  Future<bool> updateClass(Class pClass) async {
    final params = SupaBaseUpdateParams(
      table: Tables.classes,
      data: ClassAdapter.toMapUpdate(pClass),
    );

    final result = await supa.updateData(params: params);

    if (result.isEmpty) {
      throw const ClassException(
          message: 'Error when trying to update a class');
    }

    return result.isNotEmpty;
  }
}
