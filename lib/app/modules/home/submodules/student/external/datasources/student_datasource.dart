// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:result_dart/result_dart.dart';
import 'package:wizard/app/core_module/services/firestore/adapters/firestore_params.dart';

import 'package:wizard/app/core_module/services/firestore/online_storage_interface.dart';
import 'package:wizard/app/core_module/vos/id_vo.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/entity/student.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/exceptions/student_exception.dart';
import 'package:wizard/app/modules/home/submodules/student/infra/adapters/student_adapter.dart';
import 'package:wizard/app/modules/home/submodules/student/infra/datasources/student_datasource.dart';

class StudentDataSource implements IStudentDataSource {
  final IOnlineStorage onlineStorage;

  StudentDataSource({required this.onlineStorage});

  @override
  AsyncResult<bool, IStudentException> saveStudent(Student student) async {
    try {
      final params = FireStoreParams(
        collection: 'students',
        data: StudentAdapter.toMap(student),
      );

      final result = await onlineStorage.saveData(params: params);

      return result.toSuccess();
    } catch (e) {
      return StudentException(message: e.toString()).toFailure();
    }
  }

  @override
  AsyncResult<List<Student>, IStudentException> getStudentByClass(
      IdVO classID) async {
    try {
      final params = FireStoreGetDataParams(
        collection: 'students',
        field: 'class',
        value: classID.value,
        orderBy: 'name',
      );

      final result = await onlineStorage.getDataById(params: params);

      late List<Student> students = [];

      for (var doc in result.docs) {
        students.add(StudentAdapter.fromMap(doc.data()));
      }

      return students.toSuccess();
    } catch (e) {
      return StudentException(message: e.toString()).toFailure();
    }
  }
}
