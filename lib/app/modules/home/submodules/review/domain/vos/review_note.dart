// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:wizard/app/core_module/types/entity.dart';
import 'package:wizard/app/modules/home/submodules/review/domain/vos/score.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/entity/student.dart';

class ReviewNote extends Entity {
  Student _student;
  ScoreReview _score;

  Student get student => _student;
  void setStudentID(Student student) => _student = Student(
        id: student.id,
        studentName: student.studentName.value,
        studentClass: student.studentClass.value,
        studentPhoneNumber: student.studentPhoneNumber.value,
        studentParents: student.studentParents.value,
      );

  ScoreReview get score => _score;
  void setScore(String value) => _score = ScoreReview(value);

  ReviewNote({
    required super.id,
    required Student student,
    required score,
  })  : _score = ScoreReview(score),
        _student = Student(
          id: student.id,
          studentName: student.studentName.value,
          studentClass: student.studentClass.value,
          studentPhoneNumber: student.studentPhoneNumber.value,
          studentParents: student.studentParents.value,
        );
}
