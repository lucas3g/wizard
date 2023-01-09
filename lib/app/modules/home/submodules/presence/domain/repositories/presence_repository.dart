import 'package:result_dart/result_dart.dart';
import 'package:wizard/app/modules/home/submodules/presence/domain/entites/presence.dart';
import 'package:wizard/app/modules/home/submodules/presence/domain/exceptions/presence_exception.dart';

abstract class IPresenceRepository {
  AsyncResult<bool, IPresenceException> savePresence(Presence presence);
  AsyncResult<List<Presence>, IPresenceException> getPresenceByClass(
      String pClass);
}
