// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:wizard/app/core_module/vos/id_vo.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/entity/student.dart';

abstract class StudentEvents {}

class SaveStudentEvent extends StudentEvents {
  final Student student;

  SaveStudentEvent({
    required this.student,
  });
}

class GetStudentByClassEvent extends StudentEvents {
  final IdVO classID;

  GetStudentByClassEvent({
    required this.classID,
  });
}

class GetStudentByTeacherEvent extends StudentEvents {
  final IdVO teacherID;

  GetStudentByTeacherEvent({
    required this.teacherID,
  });
}
