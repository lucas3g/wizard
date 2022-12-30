// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wizard/app/modules/home/submodules/class/domain/usecases/get_classes_by_teacher_usecase.dart';
import 'package:wizard/app/modules/home/submodules/class/domain/usecases/save_class_usecase.dart';
import 'package:wizard/app/modules/home/submodules/class/presenter/bloc/events/class_events.dart';
import 'package:wizard/app/modules/home/submodules/class/presenter/bloc/states/class_states.dart';

class ClassBloc extends Bloc<ClassEvents, ClassStates> {
  final ISaveClassUseCase saveClassUseCase;
  final IGetClassesByTeacherUseCase getClassesByTeacherUseCase;

  ClassBloc({
    required this.saveClassUseCase,
    required this.getClassesByTeacherUseCase,
  }) : super(InitialClass()) {
    on<SaveClassEvent>(_saveClass);
    on<GetClassesByIdTeacher>(_getClassesByIdTeacher);
  }

  Future _saveClass(SaveClassEvent event, emit) async {
    emit(LoadingClass());

    final result = await saveClassUseCase(event.pClass);

    result.fold(
      (success) => emit(SuccessClass()),
      (failure) => emit(ErrorClass(message: failure.message)),
    );
  }

  Future _getClassesByIdTeacher(GetClassesByIdTeacher event, emit) async {
    emit(LoadingClass());

    final result = await getClassesByTeacherUseCase(event.idTeacher);

    result.fold(
      (success) => emit(SuccessGetListClass(classes: success)),
      (failure) => emit(ErrorClass(message: failure.message)),
    );
  }
}
