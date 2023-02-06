import 'package:wizard/app/core_module/vos/id_vo.dart';
import 'package:wizard/app/modules/home/submodules/homework/domain/entities/homework.dart';
import 'package:wizard/app/modules/home/submodules/homework/domain/vos/homework_note.dart';

class HomeworkAdapter {
  static Homework empty() {
    return Homework(
      id: const IdVO(1),
      homeworkName: '',
      homeworkClass: -1,
      homeworkData: '',
      homeworkNote: [],
    );
  }

  static Homework fromMap(dynamic map) {
    return Homework(
      id: IdVO(map['id']),
      homeworkClass: map['id_class'],
      homeworkName: map['name'],
      homeworkData: map['date'].replaceAll('.', '/'),
      homeworkNote: List.from(map['notes'])
          .map(
            (e) => HomeworkNote(
              score: e['score'],
              studentID: e['id_student'],
            ),
          )
          .toList(),
    );
  }

  static Map<String, dynamic> toMap(Homework homework) {
    return {
      'id_class': homework.homeworkClass.value,
      'name': homework.homeworkName.value,
      'date': homework.homeworkData.value.replaceAll('/', '.'),
    };
  }

  static List<Map<String, dynamic>> toMapNotes(Homework homework) {
    return homework.homeworkNote
        .map((e) => {
              'id_homework': homework.id.value,
              'id_student': e.studentID,
              'score': e.score.value,
              'id_class': homework.homeworkClass.value,
            })
        .toList();
  }
}
