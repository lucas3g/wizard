import 'package:wizard/app/core_module/vos/id_vo.dart';
import 'package:wizard/app/modules/home/submodules/homework/domain/entities/homework.dart';
import 'package:wizard/app/modules/home/submodules/homework/domain/vos/homework_note.dart';

class HomeworkAdapter {
  static Homework empty() {
    return Homework(
      id: const IdVO(1),
      homeworkName: '',
      homeworkClass: '',
      homeworkData: '',
      homeworkNote: [],
    );
  }

  static Homework fromMap(dynamic map) {
    return Homework(
      id: IdVO(map['id']),
      homeworkClass: map['class'].toString(),
      homeworkName: map['name'],
      homeworkData: map['date'].replaceAll('.', '/'),
      homeworkNote: List.from(map['notes'])
          .map(
            (e) => HomeworkNote(
              score: e['score'],
              studentID: e['studentID'],
            ),
          )
          .toList(),
    );
  }

  static Map<String, dynamic> toMap(Homework homework) {
    return {
      'class': homework.homeworkClass.value,
      'name': homework.homeworkName.value,
      'date': homework.homeworkData.value.replaceAll('/', '.'),
    };
  }

  static List<Map<String, dynamic>> toMapNotes(Homework homework) {
    return homework.homeworkNote
        .map((e) => {
              'id_homework': homework.id.value,
              'studentID': e.studentID,
              'score': e.score.value,
              'class': homework.homeworkClass.value,
            })
        .toList();
  }
}
