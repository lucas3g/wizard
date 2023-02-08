import 'package:wizard/app/core_module/vos/id_vo.dart';
import 'package:wizard/app/modules/home/submodules/review/domain/entities/review.dart';
import 'package:wizard/app/modules/home/submodules/review/domain/vos/review_note.dart';

class ReviewAdapter {
  static Review empty() {
    return Review(
      id: const IdVO(1),
      reviewClass: -1,
      reviewName: '',
      reviewDate: '',
      reviewNote: [],
    );
  }

  static Review fromMap(dynamic map) {
    return Review(
      id: IdVO(map['id']),
      reviewClass: map['id_class'],
      reviewName: map['name'],
      reviewDate: map['date'].replaceAll('.', '/'),
      reviewNote: List.from(map['notes'])
          .map(
            (e) => ReviewNote(
              id: IdVO(map['id']),
              studentID: e['id_student'],
              score: e['score'],
            ),
          )
          .toList(),
    );
  }

  static Map<String, dynamic> toMap(Review review) {
    return {
      'id_class': review.reviewClass.value,
      'name': review.reviewName.value,
      'date': review.reviewDate.value.replaceAll('/', '.'),
    };
  }

  static List<Map<String, dynamic>> toMapNotes(Review review) {
    return review.reviewNote
        .map(
          (e) => {
            'id_review': review.id.value,
            'id_student': e.studentID,
            'score': e.score.value,
            'id_class': review.reviewClass.value,
          },
        )
        .toList();
  }
}
