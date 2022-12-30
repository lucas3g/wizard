import 'package:uuid/uuid.dart';
import 'package:wizard/app/core_module/vos/id_vo.dart';
import 'package:wizard/app/modules/home/submodules/presence/domain/entites/presence.dart';

class PresenceAdapter {
  static Presence empty() {
    return Presence(
      id: IdVO(const Uuid().v1()),
      presenceClass: '',
      presenceCheck: [],
    );
  }
}
