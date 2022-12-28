import 'package:wizard/app/core_module/vos/id_vo.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/entity/student.dart';

class StudentAdapter {
  static Student empty() {
    return Student(
      id: const IdVO('1'),
      studentName: '',
      studentClass: '',
      studentPhoneNumber: '',
      studentParents: '',
    );
  }
}
