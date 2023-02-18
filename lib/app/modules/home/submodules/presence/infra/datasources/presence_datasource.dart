import 'package:wizard/app/modules/home/submodules/presence/domain/entites/presence.dart';

abstract class IPresenceDatasource {
  Future<bool> savePresence(Presence presence);
  Future<bool> updatePresence(Presence presence);
  Future<List> getPresenceByClass(int pClass);
  Future<List> getPresenceByClassAndDate(int pClass, String date);
}
