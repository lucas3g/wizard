// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:wizard/app/modules/home/submodules/review/domain/vos/score.dart';

class ReviewNote {
  final int studentID;
  ScoreReview _score;

  ScoreReview get score => _score;
  void setScore(String value) => _score = ScoreReview(value);

  ReviewNote({
    required this.studentID,
    required score,
  }) : _score = ScoreReview(score);
}
