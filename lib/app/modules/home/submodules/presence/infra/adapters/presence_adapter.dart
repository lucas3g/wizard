import 'package:wizard/app/core_module/constants/constants.dart';
import 'package:wizard/app/core_module/vos/id_vo.dart';
import 'package:wizard/app/modules/home/submodules/presence/domain/entites/presence.dart';
import 'package:wizard/app/modules/home/submodules/presence/domain/vos/presence_check.dart';

class PresenceAdapter {
  static Presence empty() {
    return Presence(
      id: const IdVO(1),
      presenceClass: -1,
      presenceObs: '',
      presenceHomeWork: '',
      presenceDate: '',
      presenceCheck: [],
    );
  }

  static Presence fromMap(dynamic map) {
    return Presence(
      id: IdVO(map['id']),
      presenceClass: map['class'],
      presenceObs: map['obs'] ?? '',
      presenceDate: map['date'].replaceAll('.', '/'),
      presenceHomeWork: map['homework'],
      presenceCheck: List.from(map['presence'])
          .map(
            (e) => PresenceCheck(
              studentID: e['studentID'],
              presencePresent: e['type'],
            ),
          )
          .toList(),
    );
  }

  static Map<String, dynamic> toMap(Presence presence) {
    return {
      'class': presence.presenceClass.value,
      'idTeacher': GlobalUser.instance.user.id.value,
      'date': presence.presenceDate.value.replaceAll('/', '.'),
      'obs': presence.presenceObs.value,
      'homework': presence.presenceHomeWork.value,
    };
  }

  static List<Map<String, dynamic>> toMapCheck(Presence presence) {
    return presence.presenceCheck
        .map(
          (e) => {
            'id_presence': presence.id.value,
            'studentID': e.studentID.value,
            'type': e.presencePresent.value,
            'class': presence.presenceClass.value,
          },
        )
        .toList();
  }
}
