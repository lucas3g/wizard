import 'package:result_dart/result_dart.dart';

import 'package:wizard/app/modules/home/submodules/presence/domain/entites/presence.dart';
import 'package:wizard/app/modules/home/submodules/presence/domain/exceptions/presence_exception.dart';
import 'package:wizard/app/modules/home/submodules/presence/domain/repositories/presence_repository.dart';

abstract class IUpdatePresencesUseCase {
  AsyncResult<bool, IPresenceException> call(Presence presence);
}

class UpdatePresencesUseCase implements IUpdatePresencesUseCase {
  final IPresenceRepository repository;

  UpdatePresencesUseCase({required this.repository});

  @override
  AsyncResult<bool, IPresenceException> call(Presence presence) {
    return repository.updatePresence(presence);
  }
}
