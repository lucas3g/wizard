// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wizard/app/modules/home/submodules/class/domain/usecases/get_classes_by_teacher_usecase.dart';
import 'package:wizard/app/modules/home/submodules/class/domain/usecases/create_class_usecase.dart';
import 'package:wizard/app/modules/home/submodules/class/domain/usecases/update_class_usecase.dart';
import 'package:wizard/app/modules/home/submodules/class/presenter/bloc/events/class_events.dart';
import 'package:wizard/app/modules/home/submodules/class/presenter/bloc/states/class_states.dart';

class ClassBloc extends Bloc<ClassEvents, ClassStates> {
  final ICreateClassUseCase createClassUseCase;
  final IUpdateClassUseCase updateClassUseCase;
  final IGetClassesByTeacherUseCase getClassesByTeacherUseCase;

  ClassBloc({
    required this.createClassUseCase,
    required this.updateClassUseCase,
    required this.getClassesByTeacherUseCase,
  }) : super(InitialClass()) {
    on<CreateClassEvent>(_createClass);
    on<UpdateClassEvent>(_updateClass);
    on<GetClassesByIdTeacher>(_getClassesByIdTeacher);
  }

  Future _createClass(CreateClassEvent event, emit) async {
    emit(LoadingClass());

    final result = await createClassUseCase(event.pClass);

    result.fold(
      (success) => emit(SuccessCreateClass()),
      (failure) => emit(ErrorClass(message: failure.message)),
    );
  }

  Future _updateClass(UpdateClassEvent event, emit) async {
    emit(LoadingClass());

    final result = await updateClassUseCase(event.pClass);

    result.fold(
      (success) => emit(SuccessUpdateClass()),
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
