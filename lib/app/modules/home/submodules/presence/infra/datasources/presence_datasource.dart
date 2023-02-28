import 'package:wizard/app/core_module/types/dates_entity.dart';
import 'package:wizard/app/modules/home/submodules/presence/domain/entities/presence.dart';

abstract class IPresenceDatasource {
  Future<bool> savePresence(Presence presence);
  Future<bool> updatePresence(Presence presence);
  Future<List> getPresenceByClass(int pClass);
  Future<List> getPresenceByClassAndDate(int pClass, DatesEntity dates);
}
