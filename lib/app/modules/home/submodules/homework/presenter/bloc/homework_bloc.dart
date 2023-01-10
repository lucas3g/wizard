// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wizard/app/modules/home/submodules/homework/domain/usecases/get_homeworks_by_class_usecase.dart';
import 'package:wizard/app/modules/home/submodules/homework/domain/usecases/save_homework_usecase.dart';
import 'package:wizard/app/modules/home/submodules/homework/presenter/bloc/events/homework_events.dart';
import 'package:wizard/app/modules/home/submodules/homework/presenter/bloc/states/homework_states.dart';

class HomeworkBloc extends Bloc<HomeworkEvents, HomeworkStates> {
  final ISaveHomeworkUsecase saveHomeworkUsecase;
  final IGetHomeworksByClassUsecase getHomeworksByClassUsecase;

  HomeworkBloc({
    required this.saveHomeworkUsecase,
    required this.getHomeworksByClassUsecase,
  }) : super(InitialHomework()) {
    on<SaveHomeworkEvent>(_saveHomework);
    on<GetHomeworksByClassEvent>(_getHomeworksByClass);
  }

  Future _saveHomework(SaveHomeworkEvent event, emit) async {
    emit(LoadingHomework());

    final result = await saveHomeworkUsecase(event.homework);

    result.fold(
      (success) => emit(SuccessSaveHomework()),
      (failure) => emit(ErrorSaveHomework(message: failure.message)),
    );
  }

  Future _getHomeworksByClass(GetHomeworksByClassEvent event, emit) async {
    emit(LoadingHomework());

    final result = await getHomeworksByClassUsecase(event.classID);

    result.fold(
      (success) => emit(SuccessGetHomeworksByClass(homeworks: success)),
      (failure) => emit(ErrorSaveHomework(message: failure.message)),
    );
  }
}
