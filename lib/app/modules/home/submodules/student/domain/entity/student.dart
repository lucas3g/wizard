import 'package:wizard/app/modules/home/submodules/student/domain/vos/student_class.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/vos/student_father.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/vos/student_name.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/vos/student_phone_number.dart';

class Student {
  StudentName _studentName;
  StudentClass _studentClass;
  StudentPhoneNumber _studentPhoneNumber;
  StudentFather _studentFather;

  StudentName get studentName => _studentName;
  void setStudentName(String value) => _studentName = StudentName(value);

  StudentClass get studentClass => _studentClass;
  void setStudentClass(String value) => _studentClass = StudentClass(value);

  StudentPhoneNumber get studentPhoneNumber => _studentPhoneNumber;
  void setStudentPhoneNumber(String value) =>
      _studentPhoneNumber = StudentPhoneNumber(value);

  StudentFather get studentFather => _studentFather;
  void setStudentFather(String value) => _studentFather = StudentFather(value);

  Student({
    required studentName,
    required studentClass,
    required studentPhoneNumber,
    required studentFather,
  })  : _studentName = StudentName(studentName),
        _studentClass = StudentClass(studentClass),
        _studentPhoneNumber = StudentPhoneNumber(studentPhoneNumber),
        _studentFather = StudentFather(studentFather);
}
