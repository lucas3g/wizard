import 'package:result_dart/result_dart.dart';
import 'package:wizard/app/core_module/types/entity.dart';
import 'package:wizard/app/modules/home/submodules/homework/domain/vos/homework_class.dart';
import 'package:wizard/app/modules/home/submodules/homework/domain/vos/homework_name.dart';
import 'package:wizard/app/modules/home/submodules/homework/domain/vos/homework_note.dart';

class Homework extends Entity {
  HomeworkClass _homeworkClass;
  HomeworkName _homeworkName;
  late List<HomeworkNote> homeworkNote;

  HomeworkClass get homeworkClass => _homeworkClass;
  void setHomeworkClass(String value) => _homeworkClass = HomeworkClass(value);

  HomeworkName get homeworkName => _homeworkName;
  void setHomeworkName(String value) => _homeworkName = HomeworkName(value);

  Homework({
    required super.id,
    required homeworkClass,
    required homeworkName,
    required this.homeworkNote,
  })  : _homeworkClass = HomeworkClass(homeworkClass),
        _homeworkName = HomeworkName(homeworkName);

  @override
  Result<Homework, String> validate([Object? object]) {
    return super
        .validate()
        .flatMap(homeworkClass.validate)
        .flatMap(homeworkName.validate)
        .pure(this);
  }
}
