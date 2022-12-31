// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class PresenceStates {}

class InitialPresence extends PresenceStates {}

class LoadingPresence extends PresenceStates {}

class SuccessSavePresence extends PresenceStates {}

class ErrorPresence extends PresenceStates {
  final String message;

  ErrorPresence({
    required this.message,
  });
}
