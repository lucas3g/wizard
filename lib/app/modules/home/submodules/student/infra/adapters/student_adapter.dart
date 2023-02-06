import 'package:wizard/app/core_module/constants/constants.dart';
import 'package:wizard/app/core_module/vos/id_vo.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/entity/student.dart';

class StudentAdapter {
  static Student empty() {
    return Student(
      id: const IdVO(1),
      studentName: '',
      studentClass: -1,
      studentPhoneNumber: '',
      studentParents: '',
    );
  }

  static Student fromMap(dynamic map) {
    return Student(
      id: IdVO(map['id']),
      studentName: map['name'],
      studentClass: map['id_class'],
      studentPhoneNumber: map['phone_number'],
      studentParents: map['parents'],
    );
  }

  static Map<String, dynamic> toMap(Student student) {
    return {
      'name': student.studentName.value,
      'id_class': student.studentClass.value,
      'phone_number': student.studentPhoneNumber.value,
      'parents': student.studentParents.value,
      'id_teacher': GlobalUser.instance.user.id.value,
    };
  }
}
