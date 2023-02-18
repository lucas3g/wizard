import 'package:result_dart/result_dart.dart';
import 'package:wizard/app/modules/home/submodules/presence/domain/entites/presence.dart';
import 'package:wizard/app/modules/home/submodules/presence/domain/exceptions/presence_exception.dart';

abstract class IPresenceRepository {
  Future<Result<bool, IPresenceException>> savePresence(Presence presence);
  Future<Result<bool, IPresenceException>> updatePresence(Presence presence);
  Future<Result<List<Presence>, IPresenceException>> getPresenceByClass(
      int pClass);
  Future<Result<List<Presence>, IPresenceException>> getPresenceByClassAndDate(
    int pClass,
    String date,
  );
}
