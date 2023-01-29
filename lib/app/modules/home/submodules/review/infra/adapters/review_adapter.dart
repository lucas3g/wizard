import 'package:uuid/uuid.dart';
import 'package:wizard/app/core_module/vos/id_vo.dart';
import 'package:wizard/app/modules/home/submodules/review/domain/entities/review.dart';
import 'package:wizard/app/modules/home/submodules/review/domain/vos/review_note.dart';

class ReviewAdapter {
  static Review empty() {
    return Review(
      id: IdVO(const Uuid().v1()),
      reviewClass: '',
      reviewName: '',
      reviewNote: [],
    );
  }

  static Review fromMap(dynamic map) {
    return Review(
      id: IdVO(map['id']),
      reviewClass: map['class'],
      reviewName: map['name'],
      reviewNote: List.from(map['notes'])
          .map(
            (e) => ReviewNote(
              studentID: e['studentID'],
              score: e['score'],
            ),
          )
          .toList(),
    );
  }

  static Map<String, dynamic> toMap(Review review) {
    return {
      'class': review.reviewClass.value,
      'name': review.reviewName.value,
    };
  }

  static List<Map<String, dynamic>> toMapNotes(Review review) {
    return review.reviewNote
        .map(
          (e) => {
            'studentID': e.studentID,
            'score': e.score.value,
            'class': review.reviewClass.value,
          },
        )
        .toList();
  }
}
