// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:wizard/app/modules/home/submodules/homework/domain/vos/score.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/entity/student.dart';

class HomeworkNote {
  final Student student;
  Score _score;

  Score get score => _score;
  void setScore(String value) => _score = Score(value);

  HomeworkNote({
    required this.student,
    required score,
  }) : _score = Score(score);
}
