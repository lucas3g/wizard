// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:wizard/app/modules/home/submodules/review/domain/entities/review.dart';

abstract class ReviewEvents {}

class SaveReviewEvent extends ReviewEvents {
  final Review review;

  SaveReviewEvent({
    required this.review,
  });
}

class GetReviewsByClassEvent extends ReviewEvents {
  final int classID;

  GetReviewsByClassEvent({
    required this.classID,
  });
}
