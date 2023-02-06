import 'package:wizard/app/modules/home/submodules/student/domain/vos/student_name.dart';

class ReportStudent {
  int _codStudent;
  int _idStudent;
  StudentName _studentName;

  int get codStudent => _codStudent;
  void setCodStudent(int value) => _codStudent = value;

  int get idStudent => _idStudent;
  void setIdStudent(int value) => _idStudent = value;

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
