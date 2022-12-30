import 'package:result_dart/result_dart.dart';
import 'package:wizard/app/core_module/types/entity.dart';
import 'package:wizard/app/modules/home/submodules/presence/domain/vos/presence_check.dart';
import 'package:wizard/app/modules/home/submodules/presence/domain/vos/presence_class.dart';

class Presence extends Entity {
  PresenceClass _presenceClass;
  late List<PresenceCheck>? presenceCheck;

  PresenceClass get presenceClass => _presenceClass;
  void setPresenceClass(String value) => _presenceClass = PresenceClass(value);

  Presence({
    required super.id,
    required presenceClass,
    this.presenceCheck,
  }) : _presenceClass = PresenceClass(presenceClass);

  @override
  Result<Presence, String> validate([Object? object]) {
    return super.validate().flatMap(presenceClass.validate).pure(this);
  }
}
