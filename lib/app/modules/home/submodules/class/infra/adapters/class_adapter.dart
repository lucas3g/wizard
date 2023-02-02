import 'package:wizard/app/core_module/constants/constants.dart';
import 'package:wizard/app/core_module/vos/id_vo.dart';
import 'package:wizard/app/modules/home/submodules/class/domain/entities/class.dart';

class ClassAdapter {
  static Map<String, dynamic> toMap(Class pClass) {
    return {
      'name': pClass.name.value,
      'dayweek': pClass.dayWeek.value,
      'schedule': pClass.schedule.value,
      'idTeacher': pClass.idTeacher.value,
    };
  }

  static Class fromMap(dynamic map) {
    return Class(
      id: IdVO(map['id']),
      name: map['name'],
      dayWeek: map['dayweek'],
      schedule: map['schedule'],
      idTeacher: map['idTeacher'],
    );
  }

  static Class empty() {
    return Class(
      id: const IdVO(1),
      name: '',
      dayWeek: '',
      schedule: '',
      idTeacher: GlobalUser.instance.user.id.value,
    );
  }
}
