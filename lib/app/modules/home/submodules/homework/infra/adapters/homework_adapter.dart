import 'package:uuid/uuid.dart';
import 'package:wizard/app/core_module/vos/id_vo.dart';
import 'package:wizard/app/modules/home/submodules/homework/domain/entities/homework.dart';

class HomeworkAdapter {
  static Homework empty() {
    return Homework(
      id: IdVO(const Uuid().v1()),
      homeworkName: '',
      homeworkClass: '',
    );
  }

  static Map<String, dynamic> toMap(Homework homework) {
    return {
      'class': homework.homeworkClass.value,
      'name': homework.homeworkName.value,
      'notes': homework.homeworkNote
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
