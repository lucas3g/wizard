import 'package:uuid/uuid.dart';
import 'package:wizard/app/core_module/constants/constants.dart';
import 'package:wizard/app/core_module/vos/id_vo.dart';
import 'package:wizard/app/modules/home/submodules/presence/domain/entites/presence.dart';
import 'package:wizard/app/utils/formatters.dart';

class PresenceAdapter {
  static Presence empty() {
    return Presence(
      id: IdVO(const Uuid().v1()),
      presenceClass: '',
      presenceCheck: [],
    );
  }

  static Map<String, dynamic> toMap(Presence presence) {
    return {
      'class': presence.presenceClass.value,
      'teacher': GlobalUser.instance.user!.id.value,
      'date': DateTime.now().DiaMesAnoDB(),
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
