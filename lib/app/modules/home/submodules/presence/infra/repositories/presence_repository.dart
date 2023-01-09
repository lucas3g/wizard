// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:result_dart/result_dart.dart';

import 'package:wizard/app/modules/home/submodules/presence/domain/entites/presence.dart';
import 'package:wizard/app/modules/home/submodules/presence/domain/exceptions/presence_exception.dart';
import 'package:wizard/app/modules/home/submodules/presence/domain/repositories/presence_repository.dart';
import 'package:wizard/app/modules/home/submodules/presence/infra/datasources/presence_datasource.dart';

class PresenceRepository implements IPresenceRepository {
  final IPresenceDatasource datasource;

  PresenceRepository({required this.datasource});

  @override
  AsyncResult<bool, IPresenceException> savePresence(Presence presence) {
    return datasource
        .savePresence(presence)
        .mapError<IPresenceException>(
            (error) => PresenceException(message: error.message))
        .flatMap((success) => Success(success));
  }

  @override
  AsyncResult<List<Presence>, IPresenceException> getPresenceByClass(
      String pClass) {
    return datasource
        .getPresenceByClass(pClass)
        .mapError<IPresenceException>(
            (error) => PresenceException(message: error.message))
        .flatMap((success) => Success(success));
  }
}
