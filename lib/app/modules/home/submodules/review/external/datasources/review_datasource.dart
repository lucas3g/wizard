// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:wizard/app/core_module/services/supabase/adapters/supabase_params.dart';
import 'package:wizard/app/core_module/services/supabase/helpers/tables.dart';
import 'package:wizard/app/core_module/services/supabase/supabase_interface.dart';
import 'package:wizard/app/modules/home/submodules/review/domain/entities/review.dart';
import 'package:wizard/app/modules/home/submodules/review/domain/exceptions/review_exception.dart';
import 'package:wizard/app/modules/home/submodules/review/infra/adapters/review_adapter.dart';
import 'package:wizard/app/modules/home/submodules/review/infra/datasources/review_datasource.dart';

class ReviewDatasource implements IReviewDatasource {
  final ISupaBase supa;

  ReviewDatasource({
    required this.supa,
  });

  @override
  Future<bool> saveReview(Review review) async {
    final params = SupaBaseSaveParams(
      table: Tables.reviews,
      data: ReviewAdapter.toMap(review),
    );

    final result = await supa.saveData(params: params);

    review.setId(result[0]['id']);

    final paramsNotes = SupaBaseSaveParams(
      table: Tables.reviews_notes,
      data: ReviewAdapter.toMapNotes(review),
    );

    final resultNotes = await supa.saveData(params: paramsNotes);

    if (result.isEmpty || resultNotes.isEmpty) {
      throw const ReviewException(message: 'Error saving review');
    }

    return result.isNotEmpty && resultNotes.isNotEmpty;
  }

  @override
  Future<List> getReviewsByClass(int classID) async {
    final params = SupaBaseGetDataByFieldParams(
      table: Tables.reviews,
      field: 'id_class',
      value: classID,
      orderBy: 'class',
    );

    final result = await supa.getDataByField(params: params);

    final paramsNotes = SupaBaseGetDataByFieldParams(
      table: Tables.reviews_notes,
      field: 'id_class',
      value: classID,
      orderBy: 'class',
    );

    final resultNotes = await supa.getDataByField(params: paramsNotes);

    for (var review in result) {
      for (var notes
          in resultNotes.where((e) => e['id_review'] == review['id'])) {
        review['notes'] = notes;
      }
    }

    if (result.isEmpty) {
      throw const ReviewException(message: 'Reviews is empty!');
    }

    return result;
  }
}
