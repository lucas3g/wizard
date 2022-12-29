import 'package:uuid/uuid.dart';
import 'package:wizard/app/core_module/vos/id_vo.dart';
import 'package:wizard/app/modules/home/submodules/class/domain/entities/class.dart';

class ClassAdapter {
  static Map<String, dynamic> toMap(Class pClass) {
    return {
      'id': pClass.id.value,
      'name': pClass.name.value,
      'idTeacher': pClass.idTeacher.value,
    };
  }

  static Class empty() {
    return Class(id: IdVO(const Uuid().v1()), name: '', idTeacher: '');
  }
}
