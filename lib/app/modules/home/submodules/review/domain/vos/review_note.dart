// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:wizard/app/modules/home/submodules/review/domain/vos/score.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/entity/student.dart';

class ReviewNote {
  final Student student;
  ScoreReview _score;

  ScoreReview get score => _score;
  void setScore(String value) => _score = ScoreReview(value);

  ReviewNote({
    required this.student,
    required score,
  }) : _score = ScoreReview(score);
}
