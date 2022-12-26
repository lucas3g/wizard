import 'package:wizard/app/modules/home/submodules/student/domain/entity/student.dart';

class StudentAdapter {
  static Student empty() {
    return Student(
      studentName: '',
      studentClass: '',
      studentPhoneNumber: '',
      studentFather: '',
    );
  }
}
