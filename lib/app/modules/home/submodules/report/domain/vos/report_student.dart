import 'package:wizard/app/modules/home/submodules/student/domain/vos/student_name.dart';

class ReportStudent {
  int _codStudent;
  String _idStudent;
  StudentName _studentName;

  int get codStudent => _codStudent;
  void setCodStudent(int value) => _codStudent = value;

  String get idStudent => _idStudent;
  void setIdStudent(String value) => _idStudent = value;

  StudentName get studentName => _studentName;
  void setStudentName(String value) => _studentName = StudentName(value);

  ReportStudent({
    required codStudent,
    required idStudent,
    required studentName,
  })  : _codStudent = codStudent,
        _idStudent = idStudent,
        _studentName = StudentName(studentName);
}
