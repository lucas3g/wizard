import 'package:result_dart/result_dart.dart';
import 'package:wizard/app/core_module/types/entity.dart';
import 'package:wizard/app/modules/home/submodules/review/domain/vos/review_class.dart';
import 'package:wizard/app/modules/home/submodules/review/domain/vos/review_name.dart';
import 'package:wizard/app/modules/home/submodules/review/domain/vos/review_note.dart';

class Review extends Entity {
  ReviewClass _reviewClass;
  ReviewName _reviewName;
  late List<ReviewNote> reviewNote = [];

  ReviewClass get reviewClass => _reviewClass;
  void setReviewClass(String value) => _reviewClass = ReviewClass(value);

  ReviewName get reviewName => _reviewName;
  void setReviewName(String value) => _reviewName = ReviewName(value);

  Review({
    required super.id,
    required reviewClass,
    required reviewName,
  })  : _reviewClass = ReviewClass(reviewClass),
        _reviewName = ReviewName(reviewName);

  @override
  Result<Review, String> validate([Object? object]) {
    return super
        .validate()
        .flatMap(reviewClass.validate)
        .flatMap(reviewName.validate)
        .pure(this);
  }
}
