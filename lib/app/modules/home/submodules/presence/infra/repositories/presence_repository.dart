// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:result_dart/result_dart.dart';
import 'package:wizard/app/core_module/types/dates_entity.dart';

import 'package:wizard/app/modules/home/submodules/presence/domain/entities/presence.dart';
import 'package:wizard/app/modules/home/submodules/presence/domain/exceptions/presence_exception.dart';
import 'package:wizard/app/modules/home/submodules/presence/domain/repositories/presence_repository.dart';
import 'package:wizard/app/modules/home/submodules/presence/infra/adapters/presence_adapter.dart';
import 'package:wizard/app/modules/home/submodules/presence/infra/datasources/presence_datasource.dart';

class PresenceRepository implements IPresenceRepository {
  final IPresenceDatasource datasource;

  PresenceRepository({required this.datasource});

  @override
  Future<Result<bool, IPresenceException>> savePresence(
      Presence presence) async {
    try {
      final result = await datasource.savePresence(presence);

      return result.toSuccess();
    } on IPresenceException catch (e) {
      return PresenceException(message: e.message).toFailure();
    } catch (e) {
      return PresenceException(message: e.toString()).toFailure();
    }
  }

  @override
  Future<Result<List<Presence>, IPresenceException>> getPresenceByClass(
      int pClass) async {
    try {
      final result = await datasource.getPresenceByClass(pClass);

      final List<Presence> list = [];

      for (var presence in result) {
        list.add(PresenceAdapter.fromMap(presence));
      }

      return list.toSuccess();
    } on IPresenceException catch (e) {
      return PresenceException(message: e.message).toFailure();
    } catch (e) {
      return PresenceException(message: e.toString()).toFailure();
    }
  }

  @override
  Future<Result<List<Presence>, IPresenceException>> getPresenceByClassAndDate(
      int pClass, DatesEntity dates) async {
    try {
      final result = await datasource.getPresenceByClassAndDate(pClass, dates);

      final List<Presence> list = [];

      for (var presence in result) {
        list.add(PresenceAdapter.fromMapSearch(presence));
      }

      return list.toSuccess();
    } on IPresenceException catch (e) {
      return PresenceException(message: e.message).toFailure();
    } catch (e) {
      return PresenceException(message: e.toString()).toFailure();
    }
  }

  @override
  Future<Result<bool, IPresenceException>> updatePresence(
      Presence presence) async {
    try {
      final result = await datasource.updatePresence(presence);

      return result.toSuccess();
    } on IPresenceException catch (e) {
      return PresenceException(message: e.message).toFailure();
    } catch (e) {
      return PresenceException(message: e.toString()).toFailure();
    }
  }
}
