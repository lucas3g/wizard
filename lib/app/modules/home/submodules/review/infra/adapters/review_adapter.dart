import 'package:intl/intl.dart';
import 'package:wizard/app/core_module/vos/id_vo.dart';
import 'package:wizard/app/modules/home/submodules/review/domain/entities/review.dart';
import 'package:wizard/app/modules/home/submodules/review/domain/vos/review_note.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/entity/student.dart';
import 'package:wizard/app/modules/home/submodules/student/infra/adapters/student_adapter.dart';
import 'package:wizard/app/utils/formatters.dart';

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
      reviewDate:
          DateFormat('yyyy-MM-dd').parse(map['date']).DiaMesAnoTextField(),
      reviewNote: List.from(map['notes'])
          .map(
            (e) => ReviewNote(
              id: IdVO(e['id']),
              student: Student(
                id: IdVO(e['id_student']),
                studentName: '',
                studentClass: e['id_class'],
                studentPhoneNumber: '',
                studentParents: '',
              ),
              score: e['score'],
            ),
          )
          .toList(),
    );
  }

  static Review fromMapSearch(dynamic map) {
    return Review(
      id: IdVO(map['id']),
      reviewClass: map['id_class'],
      reviewName: map['name'],
      reviewDate:
          DateFormat('yyyy-MM-dd').parse(map['date']).DiaMesAnoTextField(),
      reviewNote: List.from(map['notes'])
          .map(
            (e) => ReviewNote(
              id: IdVO(e['id']),
              student: StudentAdapter.fromMap(e['students']),
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
      'date': DateFormat('dd/MM/yyyy')
          .parse(review.reviewDate.value)
          .AnoMesDiaSupaBase(),
    };
  }

  static Map<String, dynamic> toMapUpdate(Review review) {
    return {
      'id': review.id.value,
      'id_class': review.reviewClass.value,
      'name': review.reviewName.value,
      'date': DateFormat('dd/MM/yyyy')
          .parse(review.reviewDate.value)
          .AnoMesDiaSupaBase(),
    };
  }

  static List<Map<String, dynamic>> toMapNotes(Review review) {
    return review.reviewNote
        .map(
          (e) => {
            'id_review': review.id.value,
            'id_student': e.student.id.value,
            'score': e.score.value,
            'id_class': review.reviewClass.value,
          },
        )
        .toList();
  }

  static List<Map<String, dynamic>> toMapNotesUpdate(Review review) {
    return review.reviewNote
        .map(
          (e) => {
            'id': e.id.value,
            'id_review': review.id.value,
            'id_student': e.student.id.value,
            'score': e.score.value,
            'id_class': review.reviewClass.value,
          },
        )
        .toList();
  }
}
