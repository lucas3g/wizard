// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:wizard/app/core_module/services/firestore/adapters/firestore_params.dart';

import 'package:wizard/app/core_module/services/firestore/online_storage_interface.dart';
import 'package:wizard/app/core_module/vos/id_vo.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/entity/student.dart';
import 'package:wizard/app/modules/home/submodules/student/infra/adapters/student_adapter.dart';
import 'package:wizard/app/modules/home/submodules/student/infra/datasources/student_datasource.dart';

class StudentDataSource implements IStudentDataSource {
  final IOnlineStorage onlineStorage;

  StudentDataSource({required this.onlineStorage});

  @override
  Future<bool> saveStudent(Student student) async {
    final params = FireStoreSaveOrUpdateParams(
      collection: 'students',
      doc: student.id.value,
      data: StudentAdapter.toMap(student),
    );

    final result = await onlineStorage.saveOrUpdateData(params: params);

    return result;
  }

  @override
  Future<List> getStudentByClass(IdVO classID) async {
    final params = FireStoreGetDataParams(
      collection: 'students',
      field: 'class',
      value: classID.value,
      orderBy: 'name',
    );

    final result = await onlineStorage.getDataById(params: params);

    return result.docs;
  }

  @override
  Future<List> getStudentByTeacher(IdVO teacherID) async {
    final params = FireStoreGetDataParams(
      collection: 'students',
      field: 'teacherID',
      value: teacherID.value,
      orderBy: 'name',
    );

    final result = await onlineStorage.getDataById(params: params);

    return result.docs;
  }
}
