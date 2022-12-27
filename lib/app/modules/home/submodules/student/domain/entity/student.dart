import 'package:result_dart/result_dart.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/vos/student_class.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/vos/student_parents.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/vos/student_name.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/vos/student_phone_number.dart';

class Student {
  StudentName _studentName;
  StudentClass _studentClass;
  StudentPhoneNumber _studentPhoneNumber;
  StudentParents _studentParents;

  StudentName get studentName => _studentName;
  void setStudentName(String value) => _studentName = StudentName(value);

  StudentClass get studentClass => _studentClass;
  void setStudentClass(String value) => _studentClass = StudentClass(value);

  StudentPhoneNumber get studentPhoneNumber => _studentPhoneNumber;
  void setStudentPhoneNumber(String value) =>
      _studentPhoneNumber = StudentPhoneNumber(value);

  StudentParents get studentParents => _studentParents;
  void setStudentFather(String value) =>
      _studentParents = StudentParents(value);

  Student({
    required studentName,
    required studentClass,
    required studentPhoneNumber,
    required studentParents,
  })  : _studentName = StudentName(studentName),
        _studentClass = StudentClass(studentClass),
        _studentPhoneNumber = StudentPhoneNumber(studentPhoneNumber),
        _studentParents = StudentParents(studentParents);

  Result<Unit, String> validate() {
    return studentName
        .validate()
        .flatMap(studentClass.validate)
        .flatMap(studentPhoneNumber.validate)
        .flatMap(studentParents.validate);
  }
}
