import 'package:wizard/app/modules/home/submodules/presence/domain/entites/presence.dart';

abstract class IPresenceDatasource {
  Future<bool> savePresence(Presence presence);
  Future<List> getPresenceByClass(String pClass);
}
