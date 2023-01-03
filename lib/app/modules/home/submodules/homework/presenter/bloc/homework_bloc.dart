// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wizard/app/modules/home/submodules/homework/domain/usecases/save_homework_usecase.dart';
import 'package:wizard/app/modules/home/submodules/homework/presenter/bloc/events/homework_events.dart';
import 'package:wizard/app/modules/home/submodules/homework/presenter/bloc/states/homework_states.dart';

class HomeworkBloc extends Bloc<HomeworkEvents, HomeworkStates> {
  final ISaveHomeworkUsecase saveHomeworkUsecase;

  HomeworkBloc({
    required this.saveHomeworkUsecase,
  }) : super(InitialHomework()) {
    on<SaveHomeworkEvent>(_saveHomework);
  }

  Future _saveHomework(SaveHomeworkEvent event, emit) async {
    emit(LoadingHomework());

    final result = await saveHomeworkUsecase(event.homework);

    result.fold(
      (success) => emit(SuccessSaveHomework()),
      (failure) => emit(ErrorSaveHomework(message: failure.message)),
    );
  }
}
