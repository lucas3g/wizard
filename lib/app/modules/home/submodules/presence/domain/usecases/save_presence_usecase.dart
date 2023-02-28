// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:result_dart/result_dart.dart';

import 'package:wizard/app/modules/home/submodules/presence/domain/entities/presence.dart';
import 'package:wizard/app/modules/home/submodules/presence/domain/exceptions/presence_exception.dart';
import 'package:wizard/app/modules/home/submodules/presence/domain/repositories/presence_repository.dart';

abstract class ISavePresenceUseCase {
  AsyncResult<bool, IPresenceException> call(Presence presence);
}

class SavePresenceUseCase implements ISavePresenceUseCase {
  final IPresenceRepository repository;

  SavePresenceUseCase({required this.repository});

  @override
  AsyncResult<bool, IPresenceException> call(Presence presence) {
    return presence
        .validate()
        .mapError<IPresenceException>(
            (error) => PresenceException(message: error))
        .toAsyncResult()
        .flatMap(repository.savePresence);
  }
}
