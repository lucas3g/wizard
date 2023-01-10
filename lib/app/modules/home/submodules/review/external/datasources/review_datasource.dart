// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:wizard/app/core_module/constants/constants.dart';
import 'package:wizard/app/core_module/services/firestore/adapters/firestore_params.dart';

import 'package:wizard/app/core_module/services/firestore/online_storage_interface.dart';
import 'package:wizard/app/modules/home/submodules/review/domain/entities/review.dart';
import 'package:wizard/app/modules/home/submodules/review/domain/exceptions/review_exception.dart';
import 'package:wizard/app/modules/home/submodules/review/infra/adapters/review_adapter.dart';
import 'package:wizard/app/modules/home/submodules/review/infra/datasources/review_datasource.dart';

class ReviewDatasource implements IReviewDatasource {
  final IOnlineStorage onlineStorage;

  ReviewDatasource({
    required this.onlineStorage,
  });

  @override
  Future<bool> saveReview(Review review) async {
    final params = FireStoreSaveOrUpdateParams(
      collection:
          'reviews/${GlobalUser.instance.user.id.value}/${review.reviewClass.value}',
      doc: review.reviewName.value,
      data: ReviewAdapter.toMap(review),
    );

    final result = await onlineStorage.saveOrUpdateData(params: params);

    if (!result) {
      throw const ReviewException(message: 'Error saving review');
    }

    return result;
  }
}
