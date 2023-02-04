import 'package:result_dart/result_dart.dart';
import 'package:wizard/app/core_module/types/entity.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/vos/student_class.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/vos/student_parents.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/vos/student_name.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/vos/student_phone_number.dart';

class Student extends Entity {
  StudentName _studentName;
  StudentClass _studentClass;
  StudentPhoneNumber _studentPhoneNumber;
  StudentParents _studentParents;

  StudentName get studentName => _studentName;
  void setStudentName(String value) => _studentName = StudentName(value);

  StudentClass get studentClass => _studentClass;
  void setStudentClass(int value) => _studentClass = StudentClass(value);

  StudentPhoneNumber get studentPhoneNumber => _studentPhoneNumber;
  void setStudentPhoneNumber(String value) =>
      _studentPhoneNumber = StudentPhoneNumber(value);

  StudentParents get studentParents => _studentParents;
  void setStudentFather(String value) =>
      _studentParents = StudentParents(value);

  Student({
    required super.id,
    required String studentName,
    required int studentClass,
    required String studentPhoneNumber,
    required String studentParents,
  })  : _studentName = StudentName(studentName),
        _studentClass = StudentClass(studentClass),
        _studentPhoneNumber = StudentPhoneNumber(studentPhoneNumber),
        _studentParents = StudentParents(studentParents);

  @override
  Result<Student, String> validate([Object? object]) {
    return super
        .validate()
        .flatMap(studentName.validate)
        .flatMap(studentClass.validate)
        .flatMap(studentPhoneNumber.validate)
        .flatMap(studentParents.validate)
        .pure(this);
  }
}
