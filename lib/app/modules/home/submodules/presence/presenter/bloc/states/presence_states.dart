// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:wizard/app/modules/home/submodules/presence/domain/entities/presence.dart';

abstract class PresenceStates {}

class InitialPresence extends PresenceStates {}

class LoadingPresence extends PresenceStates {}

class SuccessSavePresence extends PresenceStates {}

class SuccessUpdatePresence extends PresenceStates {}

class SuccessGetPresenceByClass extends PresenceStates {
  final List<Presence> presences;

  SuccessGetPresenceByClass({
    required this.presences,
  });
}

class SuccessGetPresenceByClassAndDate extends PresenceStates {
  final List<Presence> presences;

  SuccessGetPresenceByClassAndDate({
    required this.presences,
  });
}

class ErrorPresence extends PresenceStates {
  final String message;

  ErrorPresence({
    required this.message,
  });
}
