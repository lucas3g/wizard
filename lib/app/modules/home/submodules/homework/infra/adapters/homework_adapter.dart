import 'package:uuid/uuid.dart';
import 'package:wizard/app/core_module/vos/id_vo.dart';
import 'package:wizard/app/modules/home/submodules/homework/domain/entities/homework.dart';
import 'package:wizard/app/modules/home/submodules/homework/domain/vos/homework_note.dart';

class HomeworkAdapter {
  static Homework empty() {
    return Homework(
      id: IdVO(const Uuid().v1()),
      homeworkName: '',
      homeworkClass: '',
      homeworkNote: [],
    );
  }

  static Homework fromMap(dynamic map) {
    return Homework(
      id: IdVO(map['id']),
      homeworkClass: map['class'],
      homeworkName: map['name'],
      homeworkNote: List.from(map['notes'])
          .map(
            (e) => HomeworkNote(
              score: e['score'],
              studentID: e['student'],
            ),
          )
          .toList(),
    );
  }

  static Map<String, dynamic> toMap(Homework homework) {
    return {
      'id': homework.id.value,
      'class': homework.homeworkClass.value,
      'name': homework.homeworkName.value,
      'notes': homework.homeworkNote
          .map(
            (e) => {
              'student': e.studentID,
              'score': e.score.value,
            },
          )
          .toList(),
    };
  }
}
