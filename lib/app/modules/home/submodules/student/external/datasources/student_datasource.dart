// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:wizard/app/core_module/services/supabase/adapters/supabase_params.dart';
import 'package:wizard/app/core_module/services/supabase/helpers/tables.dart';
import 'package:wizard/app/core_module/services/supabase/supabase_interface.dart';
import 'package:wizard/app/core_module/vos/id_vo.dart';
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

    return result;
  }

  @override
  Future<List> getStudentByClass(IdVO classID) async {
    final params = SupaBaseGetDataByFieldParams(
      table: Tables.students,
      field: 'class',
      value: classID.value,
      orderBy: 'name',
    );

    final result = await supa.getDataByField(params: params);

    return result;
  }

  @override
  Future<List> getStudentByTeacher(IdVO teacherID) async {
    final params = SupaBaseGetDataByFieldParams(
      table: Tables.students,
      field: 'idTeacher',
      value: teacherID.value,
      orderBy: 'name',
    );

    final result = await supa.getDataByField(params: params);

    return result;
  }
}
