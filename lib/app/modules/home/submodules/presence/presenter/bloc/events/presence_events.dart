// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:wizard/app/core_module/types/dates_entity.dart';
import 'package:wizard/app/modules/home/submodules/presence/domain/entities/presence.dart';

abstract class PresenceEvents {}

class SavePresenceEvent extends PresenceEvents {
  final Presence presence;

  SavePresenceEvent({required this.presence});
}

class GetPresenceByClassEvent extends PresenceEvents {
  final int pClass;

  GetPresenceByClassEvent({
    required this.pClass,
  });
}

class GetPresenceByClassAndDateEvent extends PresenceEvents {
  final int pClass;
  final DatesEntity dates;

  GetPresenceByClassAndDateEvent({
    required this.pClass,
    required this.dates,
  });
}

class UpdatePresenceEvent extends PresenceEvents {
  final Presence presence;

  UpdatePresenceEvent({required this.presence});
}
