// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:wizard/app/modules/home/submodules/presence/domain/entites/presence.dart';

abstract class PresenceEvents {}

class SavePresenceEvent extends PresenceEvents {
  final Presence presence;

  SavePresenceEvent({required this.presence});
}

class GetPresenceByClassEvent extends PresenceEvents {
  final String pClass;

  GetPresenceByClassEvent({
    required this.pClass,
  });
}
