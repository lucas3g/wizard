// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:wizard/app/modules/home/submodules/student/domain/entity/student.dart';

abstract class StudentStates {}

class InitialStudent extends StudentStates {}

class LoadingStudent extends StudentStates {}

class SuccessCreateStudent extends StudentStates {}

class SuccessUpdateStudent extends StudentStates {}

class SuccessGetStudentByClass extends StudentStates {
  final List<Student> students;

  SuccessGetStudentByClass({
    required this.students,
  });
}

class SuccessGetStudentByTeacher extends StudentStates {
  final List<Student> students;

  SuccessGetStudentByTeacher({
    required this.students,
  });
}

class ErrorStudent extends StudentStates {
  final String message;

  ErrorStudent({
    required this.message,
  });
}
