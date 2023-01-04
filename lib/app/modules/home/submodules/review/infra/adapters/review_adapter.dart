import 'package:uuid/uuid.dart';
import 'package:wizard/app/core_module/vos/id_vo.dart';
import 'package:wizard/app/modules/home/submodules/review/domain/entities/review.dart';

class ReviewAdapter {
  static Review empty() {
    return Review(
      id: IdVO(const Uuid().v1()),
      reviewClass: '',
      reviewName: '',
    );
  }

  static Map<String, dynamic> toMap(Review review) {
    return {
      'class': review.reviewClass.value,
      'name': review.reviewName.value,
      'notes': review.reviewNote
          .map(
            (e) => {
              'student': e.student.id.value,
              'score': e.score.value,
            },
          )
          .toList(),
    };
  }
}
