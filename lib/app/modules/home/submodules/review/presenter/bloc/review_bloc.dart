// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wizard/app/modules/home/submodules/review/domain/usecases/save_review_usecase.dart';
import 'package:wizard/app/modules/home/submodules/review/presenter/bloc/events/review_events.dart';
import 'package:wizard/app/modules/home/submodules/review/presenter/bloc/states/review_states.dart';

class ReviewBloc extends Bloc<ReviewEvents, ReviewStates> {
  final ISaveReviewUsecase saveReviewUsecase;

  ReviewBloc({
    required this.saveReviewUsecase,
  }) : super(InitialReview()) {
    on<SaveReviewEvent>(_saveReview);
  }

  Future _saveReview(SaveReviewEvent event, emit) async {
    emit(LoadingReview());

    final result = await saveReviewUsecase(event.review);

    result.fold(
      (success) => emit(SuccessSaveReview()),
      (failure) => emit(ErrorSaveReview(message: failure.message)),
    );
  }
}
