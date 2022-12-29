// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wizard/app/modules/home/submodules/class/domain/usecases/save_class_usecase.dart';
import 'package:wizard/app/modules/home/submodules/class/presenter/bloc/events/class_events.dart';
import 'package:wizard/app/modules/home/submodules/class/presenter/bloc/states/class_states.dart';

class ClassBloc extends Bloc<ClassEvents, ClassStates> {
  final ISaveClassUseCase saveClassUseCase;

  ClassBloc({required this.saveClassUseCase}) : super(InitialClass()) {
    on<SaveClassEvent>(_saveClass);
  }

  Future _saveClass(SaveClassEvent event, emit) async {
    emit(LoadingClass());

    final result = await saveClassUseCase(event.pClass);

    result.fold(
      (success) => emit(SuccessClass()),
      (failure) => emit(ErrorClass(message: failure.message)),
    );
  }
}
