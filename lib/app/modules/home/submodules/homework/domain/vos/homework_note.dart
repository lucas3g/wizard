// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:wizard/app/core_module/types/entity.dart';
import 'package:wizard/app/modules/home/submodules/homework/domain/vos/score.dart';

class HomeworkNote extends Entity {
  final int studentID;
  Score _score;

  Score get score => _score;
  void setScore(String value) => _score = Score(value);

  HomeworkNote({
    required super.id,
    required this.studentID,
    required score,
  }) : _score = Score(score);
}
