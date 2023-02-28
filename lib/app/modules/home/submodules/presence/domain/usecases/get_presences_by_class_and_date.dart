// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:result_dart/result_dart.dart';
import 'package:wizard/app/core_module/types/dates_entity.dart';

import 'package:wizard/app/modules/home/submodules/presence/domain/entities/presence.dart';
import 'package:wizard/app/modules/home/submodules/presence/domain/exceptions/presence_exception.dart';
import 'package:wizard/app/modules/home/submodules/presence/domain/repositories/presence_repository.dart';

abstract class IGetPresencesByClassAndDateUseCase {
  AsyncResult<List<Presence>, IPresenceException> call(
      int pClass, DatesEntity date);
}

class GetPresencesByClassAndDateUseCase
    implements IGetPresencesByClassAndDateUseCase {
  final IPresenceRepository repository;

  GetPresencesByClassAndDateUseCase({required this.repository});

  @override
  AsyncResult<List<Presence>, IPresenceException> call(
      int pClass, DatesEntity date) {
    return repository.getPresenceByClassAndDate(pClass, date);
  }
}
