import 'package:intl/intl.dart';
import 'package:wizard/app/core_module/vos/id_vo.dart';
import 'package:wizard/app/modules/home/submodules/homework/domain/entities/homework.dart';
import 'package:wizard/app/modules/home/submodules/homework/domain/vos/homework_note.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/entity/student.dart';
import 'package:wizard/app/modules/home/submodules/student/infra/adapters/student_adapter.dart';
import 'package:wizard/app/utils/formatters.dart';

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
      homeworkData:
          DateFormat('yyyy-MM-dd').parse(map['date']).DiaMesAnoTextField(),
      homeworkNote: List.from(map['notes'])
          .map(
            (e) => HomeworkNote(
              id: IdVO(map['id']),
              score: e['score'],
              student: Student(
                id: IdVO(e['id_student']),
                studentName: '',
                studentClass: e['id_class'],
                studentPhoneNumber: '',
                studentParents: '',
              ),
            ),
          )
          .toList(),
    );
  }

  static Homework fromMapSearch(dynamic map) {
    return Homework(
      id: IdVO(map['id']),
      homeworkClass: map['id_class'],
      homeworkName: map['name'],
      homeworkData:
          DateFormat('yyyy-MM-dd').parse(map['date']).DiaMesAnoTextField(),
      homeworkNote: List.from(map['notes'])
          .map(
            (e) => HomeworkNote(
              id: IdVO(map['id']),
              score: e['score'],
              student: StudentAdapter.fromMap(e['students']),
            ),
          )
          .toList(),
    );
  }

  static Map<String, dynamic> toMap(Homework homework) {
    return {
      'id_class': homework.homeworkClass.value,
      'name': homework.homeworkName.value,
      'date': DateFormat('dd/MM/yyyy')
          .parse(homework.homeworkData.value)
          .AnoMesDiaSupaBase(),
    };
  }

  static Map<String, dynamic> toMapUpdate(Homework homework) {
    return {
      'id': homework.id.value,
      'id_class': homework.homeworkClass.value,
      'name': homework.homeworkName.value,
      'date': DateFormat('dd/MM/yyyy')
          .parse(homework.homeworkData.value)
          .AnoMesDiaSupaBase(),
    };
  }

  static List<Map<String, dynamic>> toMapNotes(Homework homework) {
    return homework.homeworkNote
        .map((e) => {
              'id_homework': homework.id.value,
              'id_student': e.student.id.value,
              'score': e.score.value,
              'id_class': homework.homeworkClass.value,
            })
        .toList();
  }

  static List<Map<String, dynamic>> toMapNotesUpdate(Homework homework) {
    return homework.homeworkNote
        .map((e) => {
              'id': e.id.value,
              'id_homework': homework.id.value,
              'id_student': e.student.id.value,
              'score': e.score.value,
              'id_class': homework.homeworkClass.value,
            })
        .toList();
  }
}
