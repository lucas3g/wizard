import 'package:result_dart/result_dart.dart';
import 'package:wizard/app/core_module/types/entity.dart';
import 'package:wizard/app/modules/home/submodules/class/domain/vos/class_day_week.dart';
import 'package:wizard/app/modules/home/submodules/class/domain/vos/class_id_teacher.dart';
import 'package:wizard/app/modules/home/submodules/class/domain/vos/class_name.dart';
import 'package:wizard/app/modules/home/submodules/class/domain/vos/class_schedule.dart';

class Class extends Entity {
  ClassName _name;
  ClassDayWeek _dayWeek;
  ClassSchedule _schedule;
  ClassIDTeacher _idTeacher;

  ClassName get name => _name;
  void setClassName(String value) => _name = ClassName(value);

  ClassDayWeek get dayWeek => _dayWeek;
  void setDayWeek(String value) => _dayWeek = ClassDayWeek(value);

  ClassSchedule get schedule => _schedule;
  void setSchedule(String value) => _schedule = ClassSchedule(value);

  ClassIDTeacher get idTeacher => _idTeacher;
  void setIdTeacher(int value) => _idTeacher = ClassIDTeacher(value);

  Class({
    required super.id,
    required name,
    required dayWeek,
    required schedule,
    required idTeacher,
  })  : _name = ClassName(name),
        _dayWeek = ClassDayWeek(dayWeek),
        _schedule = ClassSchedule(schedule),
        _idTeacher = ClassIDTeacher(idTeacher);

  @override
  Result<Class, String> validate([Object? object]) {
    return super
        .validate()
        .flatMap(name.validate)
        .flatMap(dayWeek.validate)
        .flatMap(schedule.validate)
        .flatMap(idTeacher.validate)
        .pure(this);
  }
}
