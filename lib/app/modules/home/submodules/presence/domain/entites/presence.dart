import 'package:result_dart/result_dart.dart';
import 'package:wizard/app/core_module/types/entity.dart';
import 'package:wizard/app/modules/home/submodules/presence/domain/vos/presence_check.dart';
import 'package:wizard/app/modules/home/submodules/presence/domain/vos/presence_class.dart';
import 'package:wizard/app/modules/home/submodules/presence/domain/vos/presence_date.dart';
import 'package:wizard/app/modules/home/submodules/presence/domain/vos/presence_homework.dart';
import 'package:wizard/app/modules/home/submodules/presence/domain/vos/presence_obs.dart';

class Presence extends Entity {
  PresenceClass _presenceClass;
  PresenceObs _presenceObs;
  PresenceHomeWork _presenceHomeWork;
  PresenceDate _presenceDate;
  late List<PresenceCheck>? presenceCheck;

  PresenceClass get presenceClass => _presenceClass;
  void setPresenceClass(String value) => _presenceClass = PresenceClass(value);

  PresenceObs get presenceObs => _presenceObs;
  void setPresenceObs(String value) => _presenceObs = PresenceObs(value);

  PresenceDate get presenceDate => _presenceDate;
  void setPresenceDate(String value) => _presenceDate = PresenceDate(value);

  PresenceHomeWork get presenceHomeWork => _presenceHomeWork;
  void setPresenceHomeWork(String value) =>
      _presenceHomeWork = PresenceHomeWork(value);

  Presence({
    required super.id,
    required presenceClass,
    required presenceObs,
    required presenceHomeWork,
    required presenceDate,
    this.presenceCheck,
  })  : _presenceClass = PresenceClass(presenceClass),
        _presenceObs = PresenceObs(presenceObs),
        _presenceDate = PresenceDate(presenceDate),
        _presenceHomeWork = PresenceHomeWork(presenceHomeWork);

  @override
  Result<Presence, String> validate([Object? object]) {
    return super
        .validate()
        .flatMap(presenceClass.validate)
        .flatMap(presenceHomeWork.validate)
        .pure(this);
  }

  @override
  String toString() {
    return '${presenceCheck!.map((e) => e)}';
  }
}
