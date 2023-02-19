// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:result_dart/result_dart.dart';

import 'package:wizard/app/modules/home/submodules/homework/domain/entities/homework.dart';
import 'package:wizard/app/modules/home/submodules/homework/domain/exceptions/homework_exception.dart';
import 'package:wizard/app/modules/home/submodules/homework/domain/repositories/homework_repository.dart';
import 'package:wizard/app/modules/home/submodules/homework/infra/adapters/homework_adapter.dart';
import 'package:wizard/app/modules/home/submodules/homework/infra/datasources/homework_datasource.dart';

class HomeworkRepository implements IHomeworkRepository {
  final IHomeworkDatasource datasource;

  HomeworkRepository({
    required this.datasource,
  });

  @override
  Future<Result<bool, IHomeWorkException>> saveHomework(
      Homework homework) async {
    try {
      final result = await datasource.saveHomework(homework);

      return result.toSuccess();
    } on IHomeWorkException catch (e) {
      return HomeWorkException(message: e.message).toFailure();
    } catch (e) {
      return HomeWorkException(message: e.toString()).toFailure();
    }
  }

  @override
  Future<Result<List<Homework>, IHomeWorkException>> getHomeworksByClass(
      int classID) async {
    try {
      final result = await datasource.getHomeworksByClass(classID);

      final List<Homework> list = [];

      for (var homework in result) {
        list.add(HomeworkAdapter.fromMap(homework));
      }

      return list.toSuccess();
    } on IHomeWorkException catch (e) {
      return HomeWorkException(message: e.message).toFailure();
    } catch (e) {
      return HomeWorkException(message: e.toString()).toFailure();
    }
  }

  @override
  Future<Result<bool, IHomeWorkException>> updateHomework(
      Homework homework) async {
    try {
      final result = await datasource.updateHomework(homework);

      return result.toSuccess();
    } on IHomeWorkException catch (e) {
      return HomeWorkException(message: e.message).toFailure();
    } catch (e) {
      return HomeWorkException(message: e.toString()).toFailure();
    }
  }

  @override
  Future<Result<List<Homework>, IHomeWorkException>> getHomeworksByClassAndDate(
      int classID, String date) async {
    try {
      final result = await datasource.getHomeworksByClassAndDate(classID, date);

      final List<Homework> list = [];

      for (var homework in result) {
        list.add(HomeworkAdapter.fromMapSearch(homework));
      }

      return list.toSuccess();
    } on IHomeWorkException catch (e) {
      return HomeWorkException(message: e.message).toFailure();
    } catch (e) {
      return HomeWorkException(message: e.toString()).toFailure();
    }
  }
}
