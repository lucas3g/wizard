import 'package:wizard/app/core_module/types/entity.dart';
import 'package:wizard/app/modules/home/submodules/presence/domain/vos/presence_present.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/entity/student.dart';

class PresenceCheck extends Entity {
  Student _student;
  PresencePresent _presencePresent;

  Student get student => _student;
  void setStudentID(Student student) => _student = Student(
        id: student.id,
        studentName: student.studentName.value,
        studentClass: student.studentClass.value,
        studentPhoneNumber: student.studentPhoneNumber.value,
        studentParents: student.studentParents.value,
      );

  PresencePresent get presencePresent => _presencePresent;
  void setPresencePresent(String value) =>
      _presencePresent = PresencePresent(value);

  PresenceCheck({
    required super.id,
    required Student student,
    required presencePresent,
  })  : _student = Student(
          id: student.id,
          studentName: student.studentName.value,
          studentClass: student.studentClass.value,
          studentPhoneNumber: student.studentPhoneNumber.value,
          studentParents: student.studentParents.value,
        ),
        _presencePresent = PresencePresent(presencePresent);
}
