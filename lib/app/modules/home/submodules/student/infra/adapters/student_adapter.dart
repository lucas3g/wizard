import 'package:uuid/uuid.dart';
import 'package:wizard/app/core_module/constants/constants.dart';
import 'package:wizard/app/core_module/vos/id_vo.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/entity/student.dart';

class StudentAdapter {
  static Student empty() {
    return Student(
      id: IdVO(const Uuid().v1()),
      studentName: '',
      studentClass: '',
      studentPhoneNumber: '',
      studentParents: '',
    );
  }

  static Student fromMap(dynamic map) {
    return Student(
      id: IdVO(map['id']),
      studentName: map['name'],
      studentClass: map['class'],
      studentPhoneNumber: map['phoneNumber'],
      studentParents: map['parents'],
    );
  }

  static Map<String, dynamic> toMap(Student student) {
    return {
      'id': student.id.value,
      'name': student.studentName.value,
      'class': student.studentClass.value,
      'phoneNumber': student.studentPhoneNumber.value,
      'parents': student.studentParents.value,
      'teacherID': GlobalUser.instance.user.id.value,
    };
  }
}
