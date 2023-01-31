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
      reviewDate: '',
      reviewNote: [],
    );
  }

  static Review fromMap(dynamic map) {
    return Review(
      id: IdVO(map['id'].toString()),
      reviewClass: map['class'].toString(),
      reviewName: map['name'],
      reviewDate: map['date'].replaceAll('.', '/'),
      reviewNote: List.from(map['notes'])
          .map(
            (e) => ReviewNote(
              studentID: e['studentID'].toString(),
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
      'date': review.reviewDate.value.replaceAll('/', '.'),
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
