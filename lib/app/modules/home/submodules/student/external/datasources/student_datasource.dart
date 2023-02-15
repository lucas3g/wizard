import 'package:wizard/app/core_module/services/client_database/adapters/client_database_params.dart';
import 'package:wizard/app/core_module/services/client_database/client_database_interface.dart';
import 'package:wizard/app/core_module/services/client_database/helpers/tables.dart';
import 'package:wizard/app/core_module/vos/id_account_google.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/entity/student.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/exceptions/student_exception.dart';
import 'package:wizard/app/modules/home/submodules/student/infra/adapters/student_adapter.dart';
import 'package:wizard/app/modules/home/submodules/student/infra/datasources/student_datasource.dart';

class StudentDataSource implements IStudentDataSource {
  final IClientDataBase client;

  StudentDataSource({required this.client});

  @override
  Future<bool> createStudent(Student student) async {
    final params = ClientDataBaseSaveParams(
      table: Tables.students,
      data: StudentAdapter.toMap(student),
    );

    final result = await client.saveData(params: params);

    if (result.isEmpty) {
      throw const StudentException(
          message: 'Error when trying to create a student');
    }

    return result.isNotEmpty;
  }

  @override
  Future<List> getStudentByClass(int classID) async {
    final params = ClientDataBaseGetDataByFieldParams(
      table: Tables.students,
      field: 'id_class',
      value: classID,
      orderBy: 'name',
    );

    final result = await client.getDataByField(params: params);

    return result;
  }

  @override
  Future<List> getStudentByTeacher(IdAccountGoogleVO teacherID) async {
    final params = ClientDataBaseGetDataByFieldParams(
      table: Tables.students,
      field: 'id_teacher',
      value: teacherID.value,
      orderBy: 'name',
    );

    final result = await client.getDataByField(params: params);

    return result;
  }

  @override
  Future<bool> updateStudent(Student student) async {
    final params = ClientDataBaseUpdateParams(
      table: Tables.students,
      data: StudentAdapter.toMapUpdate(student),
    );

    final result = await client.updateData(params: params);

    if (result.isEmpty) {
      throw const StudentException(
          message: 'Error when trying to update a student');
    }

    return result.isNotEmpty;
  }
}
