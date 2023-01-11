// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wizard/app/modules/home/submodules/review/domain/usecases/get_review_by_class_usecase.dart';
import 'package:wizard/app/modules/home/submodules/review/domain/usecases/save_review_usecase.dart';
import 'package:wizard/app/modules/home/submodules/review/presenter/bloc/events/review_events.dart';
import 'package:wizard/app/modules/home/submodules/review/presenter/bloc/states/review_states.dart';

class ReviewBloc extends Bloc<ReviewEvents, ReviewStates> {
  final ISaveReviewUsecase saveReviewUsecase;
  final IGetReviewsByClassUsecase getReviewsByClassUsecase;

  ReviewBloc({
    required this.saveReviewUsecase,
    required this.getReviewsByClassUsecase,
  }) : super(InitialReview()) {
    on<SaveReviewEvent>(_saveReview);
    on<GetReviewsByClassEvent>(_getReviewsByClass);
  }

  Future _saveReview(SaveReviewEvent event, emit) async {
    emit(LoadingReview());

    final result = await saveReviewUsecase(event.review);

    result.fold(
      (success) => emit(SuccessSaveReview()),
      (failure) => emit(ErrorSaveReview(message: failure.message)),
    );
  }

  Future _getReviewsByClass(GetReviewsByClassEvent event, emit) async {
    emit(LoadingReview());

    final result = await getReviewsByClassUsecase(event.classID);

    result.fold(
      (success) => emit(SuccessGetReviewsByClass(reviews: success)),
      (failure) => emit(ErrorSaveReview(message: failure.message)),
    );
  }
}
