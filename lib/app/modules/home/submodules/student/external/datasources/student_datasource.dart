// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:wizard/app/core_module/services/supabase/adapters/supabase_params.dart';
import 'package:wizard/app/core_module/services/supabase/helpers/tables.dart';
import 'package:wizard/app/core_module/services/supabase/supabase_interface.dart';
import 'package:wizard/app/core_module/vos/id_account_google.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/entity/student.dart';
import 'package:wizard/app/modules/home/submodules/student/infra/adapters/student_adapter.dart';
import 'package:wizard/app/modules/home/submodules/student/infra/datasources/student_datasource.dart';

class StudentDataSource implements IStudentDataSource {
  final ISupaBase supa;

  StudentDataSource({required this.supa});

  @override
  Future<bool> saveStudent(Student student) async {
    final params = SupaBaseSaveParams(
      table: Tables.students,
      data: StudentAdapter.toMap(student),
    );

    final result = await supa.saveData(params: params);

    return result.isNotEmpty;
  }

  @override
  Future<List> getStudentByClass(int classID) async {
    final params = SupaBaseGetDataByFieldParams(
      table: Tables.students,
      field: 'id_class',
      value: classID,
      orderBy: 'name',
    );

    final result = await supa.getDataByField(params: params);

    return result;
  }

  @override
  Future<List> getStudentByTeacher(IdAccountGoogleVO teacherID) async {
    final params = SupaBaseGetDataByFieldParams(
      table: Tables.students,
      field: 'id_teacher',
      value: teacherID.value,
      orderBy: 'name',
    );

    final result = await supa.getDataByField(params: params);

    return result;
  }
}
