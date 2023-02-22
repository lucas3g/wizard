import 'package:intl/intl.dart';
import 'package:wizard/app/core_module/services/client_database/adapters/client_database_params.dart';
import 'package:wizard/app/core_module/services/client_database/client_database_interface.dart';
import 'package:wizard/app/core_module/services/client_database/helpers/tables.dart';
import 'package:wizard/app/core_module/types/dates_entity.dart';
import 'package:wizard/app/modules/home/submodules/review/domain/entities/review.dart';
import 'package:wizard/app/modules/home/submodules/review/domain/exceptions/review_exception.dart';
import 'package:wizard/app/modules/home/submodules/review/infra/adapters/review_adapter.dart';
import 'package:wizard/app/modules/home/submodules/review/infra/datasources/review_datasource.dart';
import 'package:wizard/app/utils/formatters.dart';

class ReviewDatasource implements IReviewDatasource {
  final IClientDataBase client;

  ReviewDatasource({
    required this.client,
  });

  @override
  Future<bool> saveReview(Review review) async {
    final params = ClientDataBaseSaveParams(
      table: Tables.reviews,
      data: ReviewAdapter.toMap(review),
    );

    final result = await client.saveData(params: params);

    review.setId(result[0]['id']);

    final paramsNotes = ClientDataBaseSaveParams(
      table: Tables.reviews_notes,
      data: ReviewAdapter.toMapNotes(review),
    );

    final resultNotes = await client.saveData(params: paramsNotes);

    if (result.isEmpty || resultNotes.isEmpty) {
      throw const ReviewException(message: 'Error saving review');
    }

    return result.isNotEmpty && resultNotes.isNotEmpty;
  }

  @override
  Future<List> getReviewsByClass(int classID) async {
    final params = ClientDataBaseGetDataByFieldParams(
      table: Tables.reviews,
      field: 'id_class',
      value: classID,
      orderBy: 'id_class',
    );

    final result = await client.getDataByField(params: params);

    final paramsNotes = ClientDataBaseGetDataByFieldParams(
      table: Tables.reviews_notes,
      field: 'id_class',
      value: classID,
      orderBy: 'id_class',
    );

    final resultNotes = await client.getDataByField(params: paramsNotes);

    for (var review in result) {
      review['notes'] =
          resultNotes.where((e) => e['id_review'] == review['id']).toList();
    }

    if (result.isEmpty) {
      throw const ReviewException(message: 'Reviews is empty!');
    }

    return result;
  }

  @override
  Future<List> getReviewsByClassAndDate(int classID, DatesEntity dates) async {
    final classFilter =
        ClientDataBaseFilters(field: 'id_class', value: classID);
    final dateStartFilter = ClientDataBaseFilters(
      field: 'date',
      value:
          DateFormat('dd/MM/yyyy').parse(dates.dateStart).AnoMesDiaSupaBase(),
    );

    late ClientDataBaseGetDataByFiltersParams params;

    if (dates.dateEnd.isNotEmpty) {
      final dateEndFilter = ClientDataBaseFilters(
        field: 'date',
        value:
            DateFormat('dd/MM/yyyy').parse(dates.dateEnd).AnoMesDiaSupaBase(),
      );

      params = ClientDataBaseGetDataByFiltersParams(
        table: Tables.reviews,
        filters: {classFilter, dateStartFilter, dateEndFilter},
        orderBy: 'id_class',
      );
    } else {
      params = ClientDataBaseGetDataByFiltersParams(
        table: Tables.reviews,
        filters: {classFilter, dateStartFilter},
        orderBy: 'id_class',
      );
    }

    final result = await client.getDataByFilters(params: params);

    if (result.isEmpty) {
      throw const ReviewException(message: 'Review List is empty');
    }

    final paramsNotes = ClientDataBaseGetDataWithForeignTablesParams(
      table: Tables.reviews_notes,
      foreignTable: Tables.students,
      orderBy: 'id_class',
    );

    final resultNotes =
        await client.getDataWithForeignTables(params: paramsNotes);

    for (var review in result) {
      review['notes'] =
          resultNotes.where((e) => e['id_review'] == review['id']).toList();
    }

    if (result.isEmpty) {
      throw const ReviewException(message: 'Review Notes is empty!');
    }

    return result;
  }

  @override
  Future<bool> updateReview(Review review) async {
    final params = ClientDataBaseUpdateParams(
      table: Tables.reviews,
      data: ReviewAdapter.toMapUpdate(review),
    );

    final result = await client.updateData(params: params);

    final paramsNotes = ClientDataBaseUpdateParams(
      table: Tables.reviews_notes,
      data: ReviewAdapter.toMapNotesUpdate(review),
    );

    final resultNotes = await client.updateData(params: paramsNotes);

    if (result.isEmpty || resultNotes.isEmpty) {
      throw const ReviewException(
          message: 'Error when trying to update a review');
    }

    return result.isNotEmpty && resultNotes.isEmpty;
  }
}
