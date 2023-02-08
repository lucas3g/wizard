// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:wizard/app/core_module/vos/id_account_google.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/entity/student.dart';

abstract class StudentEvents {}

class CreateStudentEvent extends StudentEvents {
  final Student student;

  CreateStudentEvent({
    required this.student,
  });
}

class UpdateStudentEvent extends StudentEvents {
  final Student student;

  UpdateStudentEvent({
    required this.student,
  });
}

class GetStudentByClassEvent extends StudentEvents {
  final int classID;

  GetStudentByClassEvent({
    required this.classID,
  });
}

class GetStudentByTeacherEvent extends StudentEvents {
  final IdAccountGoogleVO teacherID;

  GetStudentByTeacherEvent({
    required this.teacherID,
  });
}
