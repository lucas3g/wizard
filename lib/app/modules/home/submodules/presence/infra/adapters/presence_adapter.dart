import 'package:uuid/uuid.dart';
import 'package:wizard/app/core_module/constants/constants.dart';
import 'package:wizard/app/core_module/vos/id_vo.dart';
import 'package:wizard/app/modules/home/submodules/presence/domain/entites/presence.dart';
import 'package:wizard/app/modules/home/submodules/presence/domain/vos/presence_check.dart';
import 'package:wizard/app/utils/formatters.dart';

class PresenceAdapter {
  static Presence empty() {
    return Presence(
      id: IdVO(const Uuid().v1()),
      presenceClass: '',
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
      presenceObs: map['obs'],
      presenceDate: map['date'],
      presenceHomeWork: map['homework'],
      presenceCheck: List.from(map['presence'])
          .map(
            (e) => PresenceCheck(
              studentID: e['student'],
              presencePresent: e['type'],
            ),
          )
          .toList(),
    );
  }

  static Presence fromPresence(Presence presence) {
    return Presence(
      id: presence.id,
      presenceClass: presence.presenceClass.value,
      presenceObs: presence.presenceObs.value,
      presenceHomeWork: presence.presenceHomeWork.value,
      presenceCheck: presence.presenceCheck,
      presenceDate: presence.presenceDate.value,
    );
  }

  static Map<String, dynamic> toMap(Presence presence) {
    return {
      'id': presence.id.value,
      'class': presence.presenceClass.value,
      'teacher': GlobalUser.instance.user.id.value,
      'date': DateTime.now().DiaMesAnoDB(),
      'obs': presence.presenceObs.value,
      'homework': presence.presenceHomeWork.value,
      'presence': presence.presenceCheck!
          .map(
            (e) => {
              'student': e.studentID.value,
              'type': e.presencePresent.value,
            },
          )
          .toList(),
    };
  }
}
